function writeMesh(fileName, vertices, faces, varargin)
%WRITEMESH Write 3D mesh data by inferring format from file name.
%
%   Usage:
%   writeMesh(FNAME, V, F)
%   writeMesh(FNAME, MESH)
%
%   Example
%     [v, f] = createCubeOctahedron;
%     writeMesh('myMesh.off', v, f);
%
%   See also 
%     meshes3d, readMesh, writeMesh_off, writeMesh_ply, writeMesh_stl
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2020-11-20, using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2020-2024 INRAE - BIA Research Unit - BIBS Platform (Nantes)

% check inputs
if ~ischar(fileName)
    error('First argument must contain the name of the file');
end

% optionaly parses data
if isstruct(vertices)
    if nargin > 2
        varargin = [{faces} varargin{:}];
    end
    faces = vertices.faces;
    vertices = vertices.vertices;
end

[~, ~, ext] = fileparts(fileName);
switch lower(ext)
    case '.off'
        writeMesh_off(fileName, vertices, faces);
    case '.ply'
        writeMesh_ply(fileName, vertices, faces, varargin{:});
    case '.stl'
        writeMesh_stl(fileName, vertices, faces, varargin{:});
    otherwise
        error('Unrecognized file format for reading mesh: %s', ext);
end
