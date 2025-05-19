function varargout = readMesh_off(fileName)
%READMESH_OFF Read mesh data stored in OFF format.
%
%   [VERTICES, FACES] = readMesh_off(FILENAME)
%   Read the data stored in file FILENAME and return the vertex and face
%   arrays as NV-by-3 array and NF-by-N array respectively, where NV is the
%   number of vertices and NF is the number of faces.
%
%   MESH = readMesh_off(FILENAME)
%   Read the data stored in file FILENAME and return the mesh into a struct
%   with fields 'vertices' and 'faces'.
%
%   Example
%     [v, f] = readMesh_off('mushroom.off');
%     figure; drawMesh(v, f, 'faceColor', [0 1 0], 'edgeColor', 'none')
%     view([5 80]); light; lighting gouraud
%
%   See also 
%     meshes3d, readMesh, writeMesh_off, readMesh_obj, drawMesh
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2011-12-20, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2024 INRA - Cepia Software Platform

%% Read header 

% open file
f = fopen(fileName, 'r');
if f == -1 
    error('matGeom:readMesh_off:FileNotFound', ...
        ['Could not open input file: ' fileName]);
end

try
    % check format signature
    line = fgetl(f);   % -1 if eof
    if ~strcmp(line(1:3), 'OFF')
        error('matGeom:readMesh_off:FileFormatError', ...
            'Not a valid OFF file');
    end

    % read number of faces and vertices
    line = fgetl(f);
    vals = sscanf(line, '%d %d');
    nVertices = vals(1);
    nFaces = vals(2);

    % Read vertex data
    [vertices, count] = fscanf(f, '%f ', [3 nVertices]);
    if count ~= nVertices * 3
        error('matGeom:readMesh_off:FileFormatError', ...
            ['Could not read all the ' num2str(nVertices) ' vertices']);
    end
    vertices = vertices';


    % Read Face data
    % First try to read faces as an homogeneous array. It if fails, start from
    % face offset and parse each face individually. In the latter case, faces
    % can have different number of vertices.

    % keep position of face info within file
    faceOffset = ftell(f);

    % read first face to assess number of vertices per face
    line = fgetl(f);
    if line == -1
        error('matGeom:readMesh_off:FileFormatError', ...
            'Unexpected end of file');
    end
    tokens = split(line);
    face1 = str2double(tokens(2:end))' + 1;
    nv = length(face1);

    % attempt to read the remaining faces assuming they all have the same
    % number of vertices
    try 
        pattern = ['%d' repmat(' %d', 1, nv) '\n'];
        [faces, count] = fscanf(f, pattern, [(nv+1) (nFaces-1)]);
    catch
        count = 0;
    end

    % Check if (at least some) faces could be read
    if count > 0
        % check that we could read the right number of  faces
        if count ~= (nFaces-1) * (nv+1)
            error('matGeom:readMesh_off:FileFormatError', ...
                'Could not read all the %d faces', nFaces);
        end

        % transpose, remove first column, use 1-indexing, and concatenate
        % with first face
        faces = [face1 ; faces(2:end,:)'+1];

    else
        % if could not read all faces at once, switch to slower
        % face-by-face parsing 
        disp('readMesh_off: Inhomogeneous number of vertices per face, switching to face-per-face parsing');

        fseek(f, faceOffset, 'bof');

        % allocate cell array
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
            faces{iFace} = str2double(tokens(2:end))' + 1;
        end
    end

    % close the file
    fclose(f);

catch ME
    % close the file
    fclose(f);
    rethrow(ME);
end


%% Post-processing

% format output arguments
if nargout < 2
    mesh.vertices = vertices;
    mesh.faces = faces;
    varargout = {mesh};
else
    varargout = {vertices, faces};
end
