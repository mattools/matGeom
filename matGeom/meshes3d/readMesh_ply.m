function varargout = readMesh_ply(fileName)
%READMESH_PLY  Read mesh data stored in PLY (Stanford triangle) format.
%
%   [V, F] = readMesh_ply(FNAME)
%
%   Example
%   readMesh_ply
%
%   References
%   * http://paulbourke.net/dataformats/ply/ 
%
%   See also
%   meshes3d, readMesh_off
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-04-26,    using Matlab 9.4.0.813654 (R2018a)
% Copyright 2018 INRA - Cepia Software Platform.


%% open file
f = fopen(fileName, 'r');
if f == -1 
    error('matGeom:readMesh_ply:FileNotFound', ...
        ['Could not find file: ' fileName]);
end

%% Read Header

% check file format
line = fgetl(f);   % -1 if eof
if ~strcmpi(strtrim(line), 'PLY')
    error('matGeom:readMesh_ply:FileFormatError', ...
        'Not a valid PLY file');
end

% one line for ascii / binary
line = fgetl(f);
tokens = split(line);
if ~strcmpi(tokens{1}, 'format')
    error('matGeom:readMesh_ply:FileFormatError', ...
        'Second line must specify PLY format');
end
if ~strcmpi(tokens{2}, 'ascii')
    error('matGeom:readMesh_ply:FileFormatError', ...
        'Does not support binary PLY file');
end

% initialize element types
typeCount = 0;
elementNames = {};
elementNumbers = [];
elementProperties = {};
elementPropertyNames = {};
elementPropertyTypes = {};

% read the header elements
while true
    % read next line
    line = fgetl(f);
    if line == -1
        error('matGeom:readMesh_ply:FileFormatError', ...
            'Unexpected end of file');
    end
    
    % check end of header items
    if strcmpi(strtrim(line), 'end_header')
        break;
    end

    % extract tokens
    tokens = split(line);
    
    % switch processing depending on first token
    switch lower(tokens{1})
        case 'comment'
            % nothing to do...
            continue;
            
        case 'element'
            % switch to the definition of a new element
            typeCount = typeCount + 1;
            elementNames = [elementNames tokens(2)]; %#ok<AGROW>
            count = str2double(tokens{3});
            elementNumbers = [elementNumbers count]; %#ok<AGROW>
            elementProperties{typeCount} = {}; %#ok<AGROW>
            elementPropertyNames{typeCount} = {}; %#ok<AGROW>
            elementPropertyTypes{typeCount} = {}; %#ok<AGROW>
            
        case 'property'
            % add a property to the current element
            if typeCount < 1
                error('matGeom:readMesh_ply:FileFormatError', ...
                    'No element was defined before specifying a property');
            end
            
            % nale is the last token
            names = elementPropertyNames{typeCount};
            names = [names tokens(end)]; %#ok<AGROW>
            elementPropertyNames{typeCount} = names; %#ok<AGROW>
            
            types = elementPropertyTypes{typeCount};
            typeString = tokens{2};
            for i = 3:length(tokens)-1
                typeString = [typeString ' ' tokens{i}]; %#ok<AGROW>
            end
            types = [types {typeString}]; %#ok<AGROW>
            elementPropertyTypes{typeCount} = types; %#ok<AGROW>
            
        otherwise
            error('matGeom:readMesh_ply:FileFormatError', ...
                ['Unknown keyword: ' tokens{1}]);
            
    end

end


%% Read Vertices

% read vertex data
nVertices = elementNumbers(1);
[vertices, count] = fscanf(f, '%f ', [3 nVertices]);
if count ~= nVertices * 3
    error('matGeom:readMesh_ply:FileFormatError', ...
        ['Could not read all the ' num2str(nVertices) ' vertices']);
end
vertices = vertices';


%% Read Faces

% allocate memory
nFaces = elementNumbers(2);
faces = cell(1, nFaces);

% iterate over faces
for iFace = 1:nFaces
    % read next line
    line = fgetl(f);
    if line == -1
        error('matGeom:readMesh_ply:FileFormatError', ...
            'Unexpected end of file');
    end
    
    % parse vertex indices for current face
    tokens = split(line);
    nv = str2double(tokens{1});
    face = zeros(1,nv);
    for iv = 1:nv
        face(iv) = str2double(tokens{iv+1}) + 1;
    end
    faces{iFace} = face;
end

% close the file
fclose(f);


%% Post-process faces

% if faces all have same number of vertices, convert to Nf-by-N array
nv = cellfun(@length, faces);
if all(nv == nv(1))
    faces = cell2mat(faces(:));
end


%% Format mesh output

% format output arguments
if nargout < 2
    mesh.vertices = vertices;
    mesh.faces = faces;
    varargout = {mesh};
else
    varargout = {vertices, faces};
end
