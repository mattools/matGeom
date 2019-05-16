function [vertices, faces] = removeInvalidBorderFaces(varargin)
%REMOVEINVALIDBORDERFACES Remove faces whose edges are connected to 3, 3, and 1 faces.
%
%   [V2, F2] = removeInvalidBorderFaces(V, F)
%
%   Example
%   removeInvalidBorderFaces
%
%   See also
%     isManifoldMesh, collapseEdgesWithManyFaces
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2019-01-31,    using Matlab 9.5.0.944444 (R2018b)
% Copyright 2019 INRA - Cepia Software Platform.

vertices = varargin{1};
faces = varargin{2};

% compute edge to vertex array
if nargin == 3
    edges = faces;
    faces = varargin{3};
else
    % compute edge to vertex array
    edges = meshEdges(faces);
end

% compute face to edge indices array
% as a nFaces-by-3 array (each face connected to exactly three edges)
faceEdgeInds = meshFaceEdges(vertices, edges, faces);

% compute number of faces incident each edge
edgeFaces = trimeshEdgeFaces(faces);
edgeFaceDegrees = sum(edgeFaces > 0, 2);

% for each face, concatenate the face degree of each edge
faceEdgeDegrees = zeros(size(faces, 1), 3);
for iFace = 1:size(faces, 1)
    edgeInds = faceEdgeInds{iFace};
    faceEdgeDegrees(iFace, :) = edgeFaceDegrees(edgeInds);
end

% remove faces containing edges connected to 1 face and edges connected to
% 3 faces
inds = sum(faceEdgeDegrees == 1, 2) > 0 & sum(faceEdgeDegrees == 3, 2);
% inds = sum(ismember(faceEdgeDegrees, [1 3 4]), 2) == 3;
faces(inds, :) = [];
