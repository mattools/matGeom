function varargout = removeMeshVertices(vertices, faces, indsToRemove)
%REMOVEMESHVERTICES Remove vertices and associated faces from a mesh
%
%   [V2, F2] = removeMeshVertices(VERTS, FACES, VERTINDS)
%   Removes the vertices specified by the vertex indices VERTINDS, and
%   remove the faces containing one of the removed vertices.
%
%   Example
%     % remove some vertices from a soccerball polyhedron
%     [v, f] = createSoccerBall; 
%     plane = createPlane([.6 0 0], [1 0 0]);
%     indAbove = find(~isBelowPlane(v, plane));
%     [v2, f2] = removeMeshVertices(v, f, indAbove);
%     drawMesh(v2, f2);
%     axis equal; hold on;
%
%   See also
%     meshes3d, trimMesh
 
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2016-02-03,    using Matlab 8.6.0.267246 (R2015b)
% Copyright 2016 INRA - Cepia Software Platform.

% parse inputs
if nargin == 2
    indsToRemove = faces;
    [vertices, faces] = parseMeshData(vertices);
end

% create array of indices to keep
nVertices = size(vertices, 1);
newInds = (1:nVertices)';
newInds(indsToRemove) = [];

% create new vertex array
vertices2 = vertices(newInds, :);

% compute map from old indices to new indices
oldNewMap = zeros(nVertices, 1);
for iIndex = 1:size(newInds, 1)
   oldNewMap(newInds(iIndex)) = iIndex; 
end

% change labels of vertices referenced by faces
if isnumeric(faces)
    faces2 = oldNewMap(faces);
    if size(faces2,2)==1; faces2=faces2'; end
    % keep only faces with valid vertices
    faces2 = faces2(sum(faces2 == 0, 2) == 0, :);
elseif iscell(faces)
    faces2 = cell(1, length(faces));
    for iFace = 1:length(faces)
         newFace = oldNewMap(faces{iFace});
         % add the new face only if all vertices are valid
         if ~any(newFace == 0)
             faces2{iFace} = newFace;
         end
    end
    
    % remove empty faces
    faces2 = faces2(~cellfun(@isempty, faces2));
end

% format output arguments
varargout = formatMeshOutput(nargout, vertices2, faces2);
