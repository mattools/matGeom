function varargout = trimMesh(varargin)
%TRIMMESH Reduce memory footprint of a polygonal mesh
%
%   [V2, F2] = trimMesh(V, F)
%   Reduces the size occupied by mesh, by keeping only vertices that are
%   referenced by at least one face, and relabel face indices.
%
%   Example
%     [V, F] = createIcosahedron;
%     F(13:20, :) = [];
%     [V2, F2] = trimMesh(V, F);
%     figure; drawMesh(V2, F2)
%     view(3); axis equal;
%     axis([-1 1 -1 1 0 2])
%
%   See also
%     meshes3d, clipMeshVertices
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2014-08-01,    using Matlab 8.3.0.532 (R2014a)
% Copyright 2014 INRA - Cepia Software Platform.

% parse input data
[vertices, faces] = parseMeshData(varargin{:});

% identify vertices referenced by a face
vertexUsed = false(size(vertices, 1), 1);
if isnumeric(faces)
    vertexUsed(unique(faces(:))) = true;
elseif iscell(faces)
    for iFace = 1:length(faces)
        face = faces{iFace};
        vertexUsed(face) = true;
    end
end
vertices2 = vertices(vertexUsed, :);

% compute map from old index to new index
inds = find(vertexUsed);
newInds = zeros(size(vertices, 1), 1);
for iIndex = 1:length(inds)
    newInds(inds(iIndex)) = iIndex;
end

% change labels of vertices referenced by faces
if isnumeric(faces)
    faces2 = newInds(faces);
elseif iscell(faces)
    faces2 = cell(1, length(faces));
    for iFace = 1:length(faces)
        faces2{iFace} = newInds(faces{iFace});
    end
end

% format output arguments
varargout = formatMeshOutput(nargout, vertices2, faces2);
