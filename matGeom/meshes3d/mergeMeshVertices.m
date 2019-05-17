function [vertices, faces] = mergeMeshVertices(vertices, faces, vertexInds, varargin)
%MERGEMESHVERTICES Merge two vertices and removes eventual degenerated faces.
%
%   output = mergeMeshVertices(input)
%
%   Example
%   mergeMeshVertices
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2019-01-31,    using Matlab 9.5.0.944444 (R2018b)
% Copyright 2019 INRA - Cepia Software Platform.

newPos = vertices(vertexInds(1), :);
if nargin > 3
    newPos = varargin{1};
end

vertices(vertexInds(1), :) = newPos;
vertices(vertexInds(2:end), :) = NaN;

% replace face-vertex indices by index of first vertex
faces(ismember(faces, vertexInds)) = vertexInds(1);

% need to check existence of degenerated faces with same vertex twice
nFaces = size(faces, 1);
dgnFaces = false(nFaces, 1);
dims = [1 2;1 3;2 3];
for i = 1:3
    dgnFaces = dgnFaces | faces(:,dims(i,1)) == faces(:,dims(i,2));
end

% remove degenerated faces
faces(dgnFaces, :) = [];
