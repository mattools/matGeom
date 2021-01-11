function varargout = readMesh(fileName)
% Read a 3D mesh by inferring format from file name.
%
%   Usage:
%   [V, F] = readMesh(FILENAME)
%   Read the data stored in file FILENAME and return the vertex and face
%   arrays as NV-by-3 array and NF-by-N array respectively, where NV is the
%   number of vertices and NF is the number of faces.
%
%   MESH = readMesh(FILENAME)
%   Read the data stored in file FILENAME and return the mesh into a struct
%   with fields 'vertices' and 'faces'.
%
%   Example
%     mesh = readMesh('apple.ply');
%     figure; drawMesh(mesh);
%     view([180 -70]); axis equal;
%
%   See also
%     meshes3d, writeMesh, readMesh_off, readMesh_ply
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-11-20,    using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2020 INRAE.

[~, ~, ext] = fileparts(fileName);
switch lower(ext)
    case '.off'
        mesh = readMesh_off(fileName);
    case '.ply'
        mesh = readMesh_ply(fileName);
    otherwise
        error('Unrecognized file format for rezading mesh: %s', ext);
end

% format output arguments
if nargout < 2
    varargout = {mesh};
else
    varargout = {mesh.vertices, mesh.faces};
end
