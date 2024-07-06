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
numComments = 0;
comments = {};      % for storing any file comments
numElements = 0;
numProperties = 0;
elements = [];      % structure for holding the element data
elementCount = [];  % number of each type of element in file
propertyTypes = []; % corresponding structure recording property types
elementNames = {};  % list of element names in the order they are stored in the file
propertyNames = [];	% structure of lists of property names

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
            numComments = numComments + 1;
            comments{numComments} = ''; %#ok<AGROW>
            for i = 2:nToks
                comments{numComments} = [comments{numComments}, tokens{i}, ' '];
            end

        case 'element'
            % element name
            if nToks >= 3
                % check element was not already initialized
                if isfield(elements,tokens{2})
                    fclose(fid);
                    error(['Duplicate element name, ''',tokens{2},'''.']);
                end

                numElements = numElements + 1;
                numProperties = 0;
                elements.(tokens{2}) = [];
                propertyTypes.(tokens{2}) =[];
                elementNames{numElements} = tokens{2}; %#ok<AGROW>
                propertyNames.(tokens{2}) = {};
                CurElement = tokens{2};
                elementCount(numElements) = str2double(tokens{3}); %#ok<AGROW>

                if isnan(elementCount(numElements))
                    fclose(fid);
                    error(['Bad element definition: ', buf]);
                end
            else
                error(['Bad element definition: ', buf]);
            end

        case 'property'
        	% element property
            if ~isempty(CurElement) && nToks >= 3
                numProperties = numProperties + 1;

                if isfield(elements.(CurElement), tokens{nToks})
                    fclose(fid);
                    error(['Duplicate property name, ''',CurElement,'.',tokens{2},'''.']);
                end

                % add property subfield to Elements
                elements.(CurElement).(tokens{nToks}) = [];
                % add property subfield to PropertyTypes and save type
                propertyTypes.(CurElement).(tokens{nToks}) = tokens(2:nToks-1);
                % record property name order
                propertyNames.(CurElement){numProperties} = tokens{nToks};
            else
                fclose(fid);
                if isempty(CurElement)
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
    BufOff = 1;
else
    % reopen the file in read binary mode
    fclose(fid);
    
    if dataFormat == 1
        fid = fopen(fileName, 'r', 'ieee-le.l64'); % little endian
    else
        fid = fopen(fileName, 'r', 'ieee-be.l64'); % big endian
    end
    
    % find the end of the header again (using ftell on the old handle doesn't give the correct position)
    BufSize = 8192;
    buf = [blanks(10),char(fread(fid,BufSize,'uchar')')];
    i = [];
    tmp = -11;
    
    while isempty(i)
        i = strfind(buf,['end_header',13,10]);              % look for end_header + CR/LF
        i = [i,strfind(buf,['end_header',10])]; %#ok<AGROW> % look for end_header + LF
        
        if isempty(i)
            tmp = tmp + BufSize;
            buf = [buf(BufSize+1:BufSize+10),char(fread(fid,BufSize,'uchar')')];
        end
    end
    
    % seek to just after the line feed
    fseek(fid,i + tmp + 11 + (buf(i + 10) == 13),-1);
end


%% Read element data

% PLY and MATLAB data types (for fread)
plyTypeNames = {'char','uchar','short','ushort','int','uint','float','double', ...
    'char8','uchar8','short16','ushort16','int32','uint32','float32','double64'};
matlabTypeNames = {'schar','uchar','int16','uint16','int32','uint32','single','double'};
dataTypeSizes = [1,1,2,2,4,4,4,8];	% size in bytes of each type

% iterate over element types
for i = 1:numElements
    % get current element property information
    CurPropertyNames = propertyNames.(elementNames{i});
    CurPropertyTypes = propertyTypes.(elementNames{i});
    numProperties = size(CurPropertyNames,2);
    
    % fprintf('Reading %s...\n',ElementNames{i});
    
    if dataFormat == 0
        % read ASCII data
        type = zeros(1, numProperties);
        for j = 1:numProperties
            tokens = CurPropertyTypes.(CurPropertyNames{j});
            
            if strcmpi(tokens{1},'list')
                type(j) = 1;
            end
        end
        
        % parse buffer
        if ~any(type)
            % no list types
            rawData = reshape(buf(BufOff:BufOff+elementCount(i)*numProperties-1),numProperties,elementCount(i))';
            BufOff = BufOff + elementCount(i)*numProperties;
        else
            ListData = cell(numProperties,1);
            
            for k = 1:numProperties
                ListData{k} = cell(elementCount(i),1);
            end
            
            % list type
            for j = 1:elementCount(i)
                for k = 1:numProperties
                    if ~type(k)
                        rawData(j,k) = buf(BufOff);
                        BufOff = BufOff + 1;
                    else
                        tmp = buf(BufOff);
                        ListData{k}{j} = buf(BufOff+(1:tmp))';
                        BufOff = BufOff + tmp + 1;
                    end
                end
            end
        end
    else
        % read binary data
        % translate PLY data type names to MATLAB data type names
        listFlag = 0; % = 1 if there is a list type
        sameFlag = 1; % = 1 if all types are the same
        
        type = cell(1,numProperties);
        type2 = type;
        typeSize = zeros(1,numProperties);
        typeSize2 = typeSize;
        for j = 1:numProperties
            tokens = CurPropertyTypes.(CurPropertyNames{j});
            
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
                        elementNames{i},'.',CurPropertyNames{j},'.']);
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
                            elementNames{i},'.',CurPropertyNames{j},'.']);
                    end
                else
                    fclose(fid);
                    error(['Invalid list syntax in ',elementNames{i},'.',CurPropertyNames{j},'.']);
                end
            end
        end
        
        % read file
        if ~listFlag
            if sameFlag
                % no list types, all the same type (fast)
                rawData = fread(fid,[numProperties,elementCount(i)],type{1})';
            else
                % no list types, mixed type
                rawData = zeros(elementCount(i),numProperties);
                
                for j = 1:elementCount(i)
                    for k = 1:numProperties
                        rawData(j,k) = fread(fid,1,type{k});
                    end
                end
            end
        else
            ListData = cell(numProperties,1);
            
            for k = 1:numProperties
                ListData{k} = cell(elementCount(i),1);
            end
            
            if numProperties == 1
                BufSize = 512;
                numSkip = 4;
                j = 0;
                
                % list type, one property (fast if lists are usually the same length)
                while j < elementCount(i)
                    Position = ftell(fid);
                    % read in BufSize count values, assuming all counts = SkipNum
                    [buf,BufSize] = fread(fid,BufSize,type{1},numSkip*typeSize2(1));
                    miss = find(buf ~= numSkip); % find first count that is not SkipNum
                    fseek(fid,Position + typeSize(1),-1); % seek back to after first count
                    
                    if isempty(miss) % all counts are SkipNum
                        buf = fread(fid,[numSkip,BufSize],[int2str(numSkip),'*',type2{1}],typeSize(1))';
                        fseek(fid,-typeSize(1),0); % undo last skip
                        
                        for k = 1:BufSize
                            ListData{1}{j+k} = buf(k,:);
                        end
                        
                        j = j + BufSize;
                        BufSize = floor(1.5*BufSize);
                    else
                        if miss(1) > 1 % some counts are numSkip
                            Buf2 = fread(fid,[numSkip,miss(1)-1],[int2str(numSkip),'*',type2{1}],typeSize(1));
                            Buf2 = Buf2';
                            
                            for k = 1:miss(1)-1
                                ListData{1}{j+k} = Buf2(k,:);
                            end
                            
                            j = j + k;
                        end

                        % Alec: check if done and rewind one step
                        if j >= elementCount(i)
                            fseek(fid,-1,0);
                            break;
                        end
                        
                        % read in the list with the missed count
                        numSkip = buf(miss(1));
                        j = j + 1;
                        ListData{1}{j} = fread(fid,[1,numSkip],type2{1});
                        BufSize = ceil(0.6*BufSize);
                    end
                end
            else
                % list type(s), multiple properties (slow)
                rawData = zeros(elementCount(i),numProperties);
                
                for j = 1:elementCount(i)
                    for k = 1:numProperties
                        if isempty(type2{k})
                            rawData(j,k) = fread(fid,1,type{k});
                        else
                            tmp = fread(fid,1,type{k});
                            ListData{k}{j} = fread(fid,[1,tmp],type2{k});
                        end
                    end
                end
            end
        end
    end
    
    % put data into Elements structure
    for k = 1:numProperties
        if (~dataFormat && ~type(k)) || (dataFormat && isempty(type2{k}))
            elements.(elementNames{i}).(CurPropertyNames{k}) = rawData(:,k);
        else
            elements.(elementNames{i}).(CurPropertyNames{k}) = ListData{k};
        end
    end
end

clear rawData ListData;
fclose(fid);


%% Post-processing

% find the index of the element corresponding to face vertex indices
possibleFacePropertyNames = ...
    {'vertex_indices', 'vertex_indexes', 'vertex_index', 'indices', 'indexes'};
facePropertyNameIdx = find(matches(possibleFacePropertyNames, fieldnames(elements.face)));
assert(length(facePropertyNameIdx) == 1)

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
