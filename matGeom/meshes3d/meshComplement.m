function varargout = meshComplement(varargin)
% Reverse the normal of each face in the mesh.
%
%   [V2, F2] = meshComplement(V, F)
%
%   Example
%     [v, f] = createOctahedron;
%     meshVolume(v, f)
%     ans =
%         1.3333
%     [v2, f2] = meshComplement(v, f);
%     meshVolume(v2, f2)
%     ans =
%        -1.3333
%
%   See also
%     meshes3d, meshVolume
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-01-22,    using Matlab 9.7.0.1247435 (R2019b) Update 2
% Copyright 2020 INRAE.

% extract mesh data
mesh = parseMeshData(varargin{:});
faces = mesh.faces;

% iterate over faces to invert order of vertex indices
if isnumeric(faces)
    for i = 1:size(faces, 1)
        faces(i,:) = faces(i, end:-1:1);
    end
else
    for i = 1:size(faces, 1)
        faces{i} = faces{i}(end:-1:1);
    end
end

% create new mesh data
varargout = formatMeshOutput(nargout, mesh.vertices, faces);
