function varargout = readMesh(filePath, varargin)
%READMESH Read a 3D mesh by inferring the format from the file extension.
%
%   [V, F] = readMesh(FILEPATH)
%   Read the data stored in file FILEPATH and return the vertex and face
%   arrays as NV-by-3 array and NF-by-N array respectively, where NV is the
%   number of vertices and NF is the number of faces.
%
%   MESH = readMesh(FILEPATH)
%   Read the data stored in file FILEPATH and return the mesh into a struct
%   with the fields 'vertices' and 'faces'.
%   In addition, the struct contains the fields 'name' and 'filePath':
%       'name' corresponds to the base name of the file (without path and
%              extension)
%       'filePath' corresponds to the full (relative) path of the file
%
%   Example
%     mesh = readMesh('apple.ply');
%     figure; drawMesh(mesh);
%     view([180 -70]); axis equal;
%
%   See also 
%     meshes3d, writeMesh, readMesh_off, readMesh_ply, readMesh_stl
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2020-11-20, using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2020-2024 INRAE - BIA Research Unit - BIBS Platform (Nantes)

% extract base name and file extension
[~, baseName, ext] = fileparts(filePath);
switch lower(ext)
    case '.off'
        mesh = readMesh_off(filePath);
    case '.ply'
        mesh = readMesh_ply(filePath);
    case '.stl'
        mesh = readMesh_stl(filePath);
    case '.obj'
        mesh = readMesh_obj(filePath);
    otherwise
        error('readMesh.m function does not support %s files.', upper(ext(2:end)));
end

% format output arguments
varargout = formatMeshOutput(nargout, mesh.vertices, mesh.faces);

% in case of mesh returned as a struct, also include the file name as field
if isstruct(varargout{1})
    varargout{1}.name = baseName;
    varargout{1}.filePath = filePath;
end
