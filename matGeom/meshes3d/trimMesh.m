function varargout = trimMesh(varargin)
%TRIMMESH Reduce memory footprint of a polygonal mesh.
%
%   [V2, F2] = trimMesh(V, F)
%   Unreferenced vertices are removed.
%   Following functions are implemented for only numeric faces:
%       Duplicate vertices are removed.
%       Duplicate faces are removed.
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
% Author: David Legland, oqilipo
% e-mail: david.legland@inra.fr
% Created: 2014-08-01,    using Matlab 8.3.0.532 (R2014a)
% Copyright 2014 INRA - Cepia Software Platform.

% parse input data
[vertices, faces] = parseMeshData(varargin{:});

if isnumeric(faces)
    % Delete duplicate vertices
    [tempVertices, ~, tempFaceVertexIdx] = unique(vertices, 'rows');
    tempFaces = tempFaceVertexIdx(faces);
    % Delete unindexed/unreferenced vertices
    usedVertexIdx = ismember(1:length(tempVertices),unique(tempFaces(:)));
    newVertexIdx = cumsum(usedVertexIdx);
    faceVertexIdx = 1:length(tempVertices);
    faceVertexIdx(usedVertexIdx) = newVertexIdx(usedVertexIdx);
    faceVertexIdx(~usedVertexIdx) = nan;
    tempFaces2 = faceVertexIdx(tempFaces);
    tempVertices2 = tempVertices(usedVertexIdx,:);
    % Delete duplicate faces
    [~, uniqueFaceIdx, ~] = unique(tempFaces2, 'rows');
    duplicateFaceIdx=~ismember(1:size(tempFaces2,1),uniqueFaceIdx);
    [vertices2, faces2] = removeMeshFaces(tempVertices2, tempFaces2, duplicateFaceIdx);
elseif iscell(faces)
    % identify vertices referenced by a face
    vertexUsed = false(size(vertices, 1), 1);
    for iFace = 1:length(faces)
        face = faces{iFace};
        vertexUsed(face) = true;
    end
    vertices2 = vertices(vertexUsed, :);
    % compute map from old index to new index
    inds = find(vertexUsed);
    newInds = zeros(size(vertices, 1), 1);
    for iIndex = 1:length(inds)
        newInds(inds(iIndex)) = iIndex;
    end
    % change labels of vertices referenced by faces
    faces2 = cell(1, length(faces));
    for iFace = 1:length(faces)
        faces2{iFace} = newInds(faces{iFace});
    end
else
    error('Unsupported format!')
end

% format output arguments
varargout = formatMeshOutput(nargout, vertices2, faces2);
