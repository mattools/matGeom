function writeMesh(fileName, vertices, faces)
% Write 3D mesh data by inferring format from file name.
%
%   writeMesh(FNAME, V, F)
%
%   writeMesh(FNAME, MESH)
%
%   Example
%   writeMesh
%
%   See also
%     meshes3d, readMesh, writeMesh_off, writeMesh_ply
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-11-20,    using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2020 INRAE.

% check inputs
if ~ischar(fileName)
    error('First argument must contain the name of the file');
end

% optionnaly parses data
if isstruct(vertices)
    faces = vertices.faces;
    vertices = vertices.vertices;
end

[~, ~, ext] = fileparts(fileName);
switch lower(ext)
    case '.off'
        writeMesh_off(fileName, vertices, faces);
    case '.ply'
        writeMesh_ply(fileName, vertices, faces);
    otherwise
        error('Unrecognized file format for rezading mesh: %s', ext);
end
