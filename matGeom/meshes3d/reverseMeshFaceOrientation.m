function varargout = reverseMeshFaceOrientation(varargin)
%REVERSEMESHFACEORIENTATION Reverse the normal of each face in the mesh.
%
%   [V2, F2] = reverseMeshFaceOrientation(V, F)
%   Computes new face vertex indices such that the volume enclosed by the
%   mesh becomes the opposite of that of the original mesh. The vertex
%   position of the two meshes are the same.
%
%   Example
%     [v, f] = createOctahedron;
%     meshVolume(v, f)
%     ans =
%         1.3333
%     [v2, f2] = reverseMeshFaceOrientation(v, f);
%     meshVolume(v2, f2)
%     ans =
%        -1.3333
%
%   See also 
%     meshes3d, meshVolume
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2024-07-15, using Matlab 24.1.0.2628055 (R2024a) Update 4
% Copyright 2024 INRAE - BIA Research Unit - BIBS Platform (Nantes)

% extract mesh data
mesh = parseMeshData(varargin{:});
faces = mesh.faces;

% iterate over faces to invert order of vertex indices
if isnumeric(faces)
    faces = faces(:, [1 end:-1:2]);
else
    for i = 1:size(faces, 1)
        faces{i} = faces{i}([1 end:-1:2]);
    end
end

% create new mesh data
varargout = formatMeshOutput(nargout, mesh.vertices, faces);
