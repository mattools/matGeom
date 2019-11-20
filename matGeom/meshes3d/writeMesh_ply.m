function writeMesh_ply(fileName, vertices, faces)
%WRITEMESH_PLY Writes a mesh into a text file in PLY format.
%
%   writeMesh_ply(FNAME, VERTS, FACES)
%
%   Example
%   writeMesh_ply
%
%   See also
%   meshes3d, readMesh_ply, writeMesh_off
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-04-26,    using Matlab 9.4.0.813654 (R2018a)
% Copyright 2018 INRA - Cepia Software Platform.


%% Check inputs

if ~ischar(fileName)
    error('First argument must contain the name of the file');
end

% optionnaly parses data
if isstruct(vertices)
    faces = vertices.faces;
    vertices = vertices.vertices;
end


%% Initializations

% number of vertices and faces
nVertices = size(vertices, 1);
nFaces = size(faces, 1);
if iscell(faces)
    nFaces = length(faces);
end

% open file for writing text
f = fopen(fileName, 'wt');
if (f == -1)
	error('Couldn''t open the file %s', fileName);
end


%% Write Header 

% write the header line
fprintf(f, 'ply\n');

% write format (only ASCII supported)
fprintf(f, 'format ascii 1.0\n');

% some comments
fprintf(f, 'comment created by MatGeom for Matlab\n');

% write declaration for vertices
fprintf(f, 'element vertex %d\n', nVertices);
fprintf(f, 'property float x\n');
fprintf(f, 'property float y\n');
fprintf(f, 'property float z\n');

% write declaration for faces
fprintf(f, 'element face %d\n', nFaces);
fprintf(f, 'property list uchar int vertex_index\n');

% end of header
fprintf(f, 'end_header\n');

%% Write vertex info

format = '%g %g %g\n';
for iv = 1:nVertices
    fprintf(f, format, vertices(iv, :));
end


%% Write face info
if isnumeric(faces)
    % simply write face vertex indices
    ns = size(faces, 2);
    format = ['%d' repmat(' %d', 1, ns) '\n'];
    for iFace = 1:nFaces
        fprintf(f, format, ns, faces(iFace, :) - 1);
    end
else
    % if faces are stored in a cell array, the number of vertices in each
    % face may be different, and we need to process each face individually
    for iFace = 1:nFaces
        ns = length(faces{iFace});
        format = ['%d' repmat(' %d', 1, ns) '\n'];
        fprintf(f, format, ns, faces{iFace} - 1);
    end
end

% close the file
fclose(f);
