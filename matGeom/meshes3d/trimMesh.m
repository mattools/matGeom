function varargout = trimMesh(varargin)
%TRIMMESH Reduce memory footprint of a polygonal mesh.
%
%   [V2, F2] = trimMesh(V, F)
%   Unreferenced vertices are removed.
%   Following functions are implemented only for numeric faces:
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
% E-mail: david.legland@inrae.fr
% Created: 2014-08-01, using Matlab 8.3.0.532 (R2014a)
% Copyright 2014-2023 INRA - Cepia Software Platform

% parse input data
[vertices, faces] = parseMeshData(varargin{:});

if isnumeric(faces)
    % Process meshes with faces given as Nf-by-3 or Nf-by-4 numeric arrays

    % Delete duplicate vertices
    [tempVertices, tempFaces] = removeDuplicateVertices(vertices, faces);
    % Delete unindexed/unreferenced vertices
    [tempVertices2, tempFaces2] = removeUnreferencedVertices(tempVertices, tempFaces);
    % Delete duplicate faces
    [~, uniqueFaceIdx, ~] = unique(tempFaces2, 'rows');
    duplicateFaceIdx = ~ismember(1:size(tempFaces2,1), uniqueFaceIdx);
    [vertices2, faces2] = removeMeshFaces(tempVertices2, tempFaces2, duplicateFaceIdx);

elseif iscell(faces)
    % Process meshes with faces given as cell array of row vectors

    nVertices = size(vertices, 1);
    nFaces = length(faces);

    % identify vertices referenced by at least one face
    vertexUsed = false(nVertices, 1);
    for iFace = 1:nFaces
        face = faces{iFace};
        vertexUsed(face) = true;
    end
    vertices2 = vertices(vertexUsed, :);

    % compute map from old index to new index
    inds = find(vertexUsed);
    newInds = zeros(nVertices, 1);
    for iIndex = 1:length(inds)
        newInds(inds(iIndex)) = iIndex;
    end
    
    % change labels of vertices referenced by faces
    faces2 = cell(1, nFaces);
    for iFace = 1:nFaces
        faces2{iFace} = newInds(faces{iFace})';
    end
    
else
    error('matGeom:trimMesh', ...
        'Unsupported representation for mesh faces');
end

% format output arguments
varargout = formatMeshOutput(nargout, vertices2, faces2);
