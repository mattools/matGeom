function varargout = readMesh_off(fileName)
%READMESH_OFF Read mesh data stored in OFF format.
%
%   [VERTICES FACES] = readMesh_off(FILNAME)
%
%   Example
%     [v, f] = readMesh_off('mushroom.off');
%     figure; drawMesh(v, f, 'faceColor', [0 1 0], 'edgeColor', 'none')
%     view([5 80]); light; lighting gouraud
%
%   See also
%     meshes3d, writeMesh_off, drawMesh

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-12-20,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% open file
f = fopen(fileName, 'r');
if f == -1 
    error('matGeom:readMesh_off:FileNotFound', ...
        ['Could not find file: ' fileName]);
end

% check format
line = fgetl(f);   % -1 if eof
if ~strcmp(line(1:3), 'OFF')
    error('matGeom:readMesh_off:FileFormatError', ...
        'Not a valid OFF file');    
end

% number of faces and vertices
line = fgetl(f);
vals = sscanf(line, '%d %d');
nVertices = vals(1);
nFaces = vals(2);


% read vertex data
[vertices, count] = fscanf(f, '%f ', [3 nVertices]);
if count ~= nVertices * 3
    error('matGeom:readMesh_off:FileFormatError', ...
        ['Could not read all the ' num2str(nVertices) ' vertices']);
end
vertices = vertices';

% % read face data (face start by index)
% [faces, count] = fscanf(f, '%d %d %d %d\n', [4 nf]);
% if count ~= nf * 4
%     error('matGeom:readMesh_off:FileFormatError', ...
%         ['Could not read all the ' num2str(nf) ' faces']);
% end

% allocate memory
faces = cell(1, nFaces);

% iterate over faces
for iFace = 1:nFaces
    % read next line
    line = fgetl(f);
    if line == -1
        error('matGeom:readMesh_off:FileFormatError', ...
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

% % clean up: remove index, and use 1-indexing
% faces = faces(2:4, :)' + 1;

% if faces all have same number of vertices, convert to Nf-by-N array
nVertices = cellfun(@length, faces);
if all(nVertices == nVertices(1))
    faces = cell2mat(faces(:));
end


% format output arguments
if nargout < 2
    mesh.vertices = vertices;
    mesh.faces = faces;
    varargout = {mesh};
else
    varargout = {vertices, faces};
end
