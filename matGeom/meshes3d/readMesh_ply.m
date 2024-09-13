function varargout = readMesh_ply(fileName)
%READMESH_PLY Read mesh data stored in PLY (Stanford triangle) format.
%
%   [V, F] = readMesh_ply(FNAME)
%   V is a NV-by-3 numeric array containing vertex coordinates,
%   F is a NF-by-3 or NF-by-4 array containg vertex indices of each face.
%
%   MESH = readMesh_ply(FNAME)
%   Returns mesh vertex and face information into a single structure with
%   fields 'vertices' and 'faces'.
%
%   Example
%     [v, f] = readMesh_ply('bunny_F1k.ply');
%     trisurf(f, v(:,1),v(:,2),v(:,3));
%     colormap(gray); axis equal;
%
%   References
%   Adapted from Gabriel Peyré's "read_ply" function, that is was a wrapper
%   for the "plyread" function written by Pascal Getreuer.
%
%   See also 
%       meshes3d, readMesh, readMesh_off, readMesh_stl

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2018-04-26, using Matlab 9.4.0.813654 (R2018a)
% Copyright 2018-2024 INRA - Cepia Software Platform

%% Open file

% check existence of file
if ~exist(fileName, 'file')
    error('matGeom:readMesh_ply:FileNotFound', ...
        ['Could not find file: ' fileName]);
end

% open file in read text mode
[fid, msg] = fopen(fileName, 'rt'); 

% check file was properly open
if fid == -1
    error(msg); 
end

% check file format marker
buf = fscanf(fid, '%s', 1);
if ~strcmp(buf, 'ply')
    fclose(fid);
    error('Not a PLY file.');
end


%% Read header

% initialize empty fields
ftell(fid);
dataFormat = '';
nComments = 0;
comments = {};      % for storing any file comments
nElements = 0;
elements = [];      % structure for holding the element data
elementCounts = []; % number of each type of element in file
elementNames = {};  % list of element names in the order they are stored in the file
nProperties = 0;
propertyNames = [];	% structure of lists of property names
propertyTypes = []; % corresponding structure recording property types

% iterate over the lines of the file until we find the "end_header" line
while true
    buf = fgetl(fid); % read one line from file
    tokens = split(buf); % split line into tokens
    nToks = length(tokens); % count tokens
    
    if nToks == 0
        continue;
    end

    % At the beginning of an element, the first token indicates the nature
    % of the element
    switch lower(tokens{1})
        case 'format'
            % read data format (ascii or binary)
            if nToks >= 2
                dataFormat = lower(tokens{2});
                if nToks == 3 && ~strcmp(tokens{3},'1.0')
                    fclose(fid);
                    error('Only PLY format version 1.0 supported.');
                end
            end

        case 'comment'
            % read file comments
            nComments = nComments + 1;
            comments{nComments} = ''; %#ok<AGROW>
            for i = 2:nToks
                comments{nComments} = [comments{nComments}, tokens{i}, ' '];
            end

        case 'element'
            % element name
            if nToks >= 3
                % check element was not already initialized
                if isfield(elements,tokens{2})
                    fclose(fid);
                    error(['Duplicate element name, ''',tokens{2},'''.']);
                end

                nElements = nElements + 1;
                nProperties = 0;
                elements.(tokens{2}) = [];
                propertyTypes.(tokens{2}) =[];
                elementNames{nElements} = tokens{2}; %#ok<AGROW>
                propertyNames.(tokens{2}) = {};
                element = tokens{2};
                elementCounts(nElements) = str2double(tokens{3}); %#ok<AGROW>

                if isnan(elementCounts(nElements))
                    fclose(fid);
                    error(['Bad element definition: ', buf]);
                end
            else
                error(['Bad element definition: ', buf]);
            end

        case 'property'
        	% element property
            if ~isempty(element) && nToks >= 3
                nProperties = nProperties + 1;

                if isfield(elements.(element), tokens{nToks})
                    fclose(fid);
                    error(['Duplicate property name, ''',element,'.',tokens{2},'''.']);
                end

                % add property subfield to elements
                elements.(element).(tokens{nToks}) = [];
                % add property subfield to PropertyTypes and save type
                propertyTypes.(element).(tokens{nToks}) = tokens(2:nToks-1);
                % record property name order
                propertyNames.(element){nProperties} = tokens{nToks};
            else
                fclose(fid);
                if isempty(element)
                    error(['Property definition without element definition: ', buf]);
                else
                    error(['Bad property definition: ', buf]);
                end
            end

        case 'end_header' 
            % end of header, break infinite loop
            break;
    end
end


%% Set reading for specified data format
if isempty(dataFormat)
    warning('Data format unspecified, assuming ASCII.');
    dataFormat = 'ascii';
end

switch dataFormat
    case 'ascii'
        dataFormat = 0;
    case 'binary_little_endian'
        dataFormat = 1;
    case 'binary_big_endian'
        dataFormat = 2;
    otherwise
        fclose(fid);
        error('Data format ''%s'' not supported.', dataFormat);
end

if dataFormat == 0
    % read the rest of the file as ASCII data
    buf = fscanf(fid,'%f');
    offset = 1;
else
    % reopen the file in read binary mode
    fclose(fid);
    
    if dataFormat == 1
        fid = fopen(fileName, 'r', 'ieee-le.l64'); % little endian
    else
        fid = fopen(fileName, 'r', 'ieee-be.l64'); % big endian
    end
    
    % find the end of the header again (using ftell on the old handle doesn't give the correct position)
    bufferSize = 8192;
    buf = [blanks(10),char(fread(fid,bufferSize,'uchar')')];
    i = [];
    tmp = -11;
    
    while isempty(i)
        % look for end_header + CR/LF
        i = strfind(buf, ['end_header', 13, 10]);
        % look for end_header + LF
        i = [i, strfind(buf, ['end_header', 10])]; %#ok<AGROW>
        
        if isempty(i)
            tmp = tmp + bufferSize;
            buf = [buf(bufferSize+1:bufferSize+10), char(fread(fid,bufferSize,'uchar')')];
        end
    end
    
    % seek to just after the line feed
    fseek(fid, i + tmp + 11 + (buf(i + 10) == 13), -1);
end


%% Read element data

% PLY and MATLAB data types (for fread)
plyTypeNames = {'char','uchar','short','ushort','int','uint','float','double', ...
    'char8','uchar8','short16','ushort16','int32','uint32','float32','double64'};
matlabTypeNames = {'schar','uchar','int16','uint16','int32','uint32','single','double'};
dataTypeSizes = [1,1,2,2,4,4,4,8];	% size in bytes of each type

% iterate over element types
for i = 1:nElements
    % get current element property information
    currPropNames = propertyNames.(elementNames{i});
    currPropTypes = propertyTypes.(elementNames{i});
    nProperties = size(currPropNames,2);
    
    % fprintf('Reading %s...\n',ElementNames{i});
    
    if dataFormat == 0
        % read ASCII data
        type = zeros(1, nProperties);
        for j = 1:nProperties
            tokens = currPropTypes.(currPropNames{j});
            
            if strcmpi(tokens{1},'list')
                type(j) = 1;
            end
        end
        
        % parse buffer
        if ~any(type)
            % no list types
            rawData = reshape(buf(offset:offset+elementCounts(i)*nProperties-1),nProperties,elementCounts(i))';
            offset = offset + elementCounts(i)*nProperties;
        else
            allData = cell(nProperties,1);
            
            for k = 1:nProperties
                allData{k} = cell(elementCounts(i),1);
            end
            
            % list type
            for j = 1:elementCounts(i)
                for k = 1:nProperties
                    if ~type(k)
                        rawData(j,k) = buf(offset);
                        offset = offset + 1;
                    else
                        tmp = buf(offset);
                        allData{k}{j} = buf(offset+(1:tmp))';
                        offset = offset + tmp + 1;
                    end
                end
            end
        end
    else
        % read binary data
        % translate PLY data type names to MATLAB data type names
        listFlag = 0; % = 1 if there is a list type
        sameFlag = 1; % = 1 if all types are the same
        
        type = cell(1,nProperties);
        type2 = type;
        typeSize = zeros(1,nProperties);
        typeSize2 = typeSize;
        for j = 1:nProperties
            tokens = currPropTypes.(currPropNames{j});
            
            if ~strcmp(tokens{1}, 'list')	% non-list type
                tmp = rem(find(matches(plyTypeNames,tokens{1}))-1,8)+1;
                
                if ~isempty(tmp)
                    typeSize(j) = dataTypeSizes(tmp);
                    type{j} = matlabTypeNames{tmp};
                    typeSize2(j) = 0;
                    type2{j} = '';
                    
                    sameFlag = sameFlag & strcmp(type{1},type{j});
                else
                    fclose(fid);
                    error(['Unknown property data type, ''',tokens{1},''', in ', ...
                        elementNames{i},'.',currPropNames{j},'.']);
                end
            else % list type
                if length(tokens) == 3
                    listFlag = 1;
                    sameFlag = 0;
                    tmp = rem(find(matches(plyTypeNames,tokens{2}))-1,8)+1;
                    tmp2 = rem(find(matches(plyTypeNames,tokens{3}))-1,8)+1;
                    
                    if ~isempty(tmp) && ~isempty(tmp2)
                        typeSize(j) = dataTypeSizes(tmp);
                        type{j} = matlabTypeNames{tmp};
                        typeSize2(j) = dataTypeSizes(tmp2);
                        type2{j} = matlabTypeNames{tmp2};
                    else
                        fclose(fid);
                        error(['Unknown property data type, ''list ',tokens{2},' ',tokens{3},''', in ', ...
                            elementNames{i},'.',currPropNames{j},'.']);
                    end
                else
                    fclose(fid);
                    error(['Invalid list syntax in ',elementNames{i},'.',currPropNames{j},'.']);
                end
            end
        end
        
        % read file
        if ~listFlag
            if sameFlag
                % no list types, all the same type (fast)
                rawData = fread(fid,[nProperties,elementCounts(i)],type{1})';
            else
                % no list types, mixed type
                rawData = zeros(elementCounts(i),nProperties);
                
                for j = 1:elementCounts(i)
                    for k = 1:nProperties
                        rawData(j,k) = fread(fid,1,type{k});
                    end
                end
            end
        else
            allData = cell(nProperties,1);
            
            for k = 1:nProperties
                allData{k} = cell(elementCounts(i),1);
            end
            
            if nProperties == 1
                bufferSize = 512;
                nSkip = 4;
                j = 0;
                
                % list type, one property (fast if lists are usually the same length)
                while j < elementCounts(i)
                    Position = ftell(fid);
                    % read in BufSize count values, assuming all counts = nSkip
                    [buf,bufferSize] = fread(fid,bufferSize,type{1},nSkip*typeSize2(1));
                    miss = find(buf ~= nSkip); % find first count that is not nSkip
                    fseek(fid,Position + typeSize(1),-1); % seek back to after first count
                    
                    if isempty(miss) % all counts are nSkip
                        buf = fread(fid,[nSkip,bufferSize],[int2str(nSkip),'*',type2{1}],typeSize(1))';
                        fseek(fid,-typeSize(1),0); % undo last skip
                        
                        for k = 1:bufferSize
                            allData{1}{j+k} = buf(k,:);
                        end
                        
                        j = j + bufferSize;
                        bufferSize = floor(1.5*bufferSize);
                    else
                        if miss(1) > 1 % some counts are numSkip
                            Buf2 = fread(fid,[nSkip,miss(1)-1],[int2str(nSkip),'*',type2{1}],typeSize(1));
                            Buf2 = Buf2';
                            
                            for k = 1:miss(1)-1
                                allData{1}{j+k} = Buf2(k,:);
                            end
                            
                            j = j + k;
                        end

                        % Alec: check if done and rewind one step
                        if j >= elementCounts(i)
                            fseek(fid,-1,0);
                            break;
                        end
                        
                        % read in the list with the missed count
                        nSkip = buf(miss(1));
                        j = j + 1;
                        allData{1}{j} = fread(fid,[1,nSkip],type2{1});
                        bufferSize = ceil(0.6*bufferSize);
                    end
                end
            else
                % list type(s), multiple properties (slow)
                rawData = zeros(elementCounts(i),nProperties);
                
                for j = 1:elementCounts(i)
                    for k = 1:nProperties
                        if isempty(type2{k})
                            rawData(j,k) = fread(fid,1,type{k});
                        else
                            tmp = fread(fid,1,type{k});
                            allData{k}{j} = fread(fid,[1,tmp],type2{k});
                        end
                    end
                end
            end
        end
    end
    
    % put data into 'elements' structure
    for k = 1:nProperties
        if (~dataFormat && ~type(k)) || (dataFormat && isempty(type2{k}))
            elements.(elementNames{i}).(currPropNames{k}) = rawData(:,k);
        else
            elements.(elementNames{i}).(currPropNames{k}) = allData{k};
        end
    end
end

clear rawData allData;
fclose(fid);


%% Post-processing

% find the index of the element corresponding to face vertex indices
possibleFacePropertyNames = ...
    {'vertex_indices', 'vertex_indexes', 'vertex_index', 'indices', 'indexes'};
facePropertyNameIdx = find(matches(possibleFacePropertyNames, fieldnames(elements.face)));
assert(isscalar(facePropertyNameIdx))

% retrieve face vertex data
faces = elements.face.(possibleFacePropertyNames{facePropertyNameIdx});

% convert face array from 0-indexing into 1-indexing,
% and attempt to convert cell array into numeric array,
lengths = cellfun(@length, faces);
maxLength = max(lengths);
if all(maxLength == lengths)
    faces = cell2mat(faces)+1;
else
    faces = cellfun(@(x) x+1, faces, 'uni', 0);
end

% retrieve vertex data
vertices = [elements.vertex.x, elements.vertex.y, elements.vertex.z];

% format output arguments
varargout = formatMeshOutput(nargout, vertices, faces);
if nargout == 1
    varargout{1}.comment = comments;
end
