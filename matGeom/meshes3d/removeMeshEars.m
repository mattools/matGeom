function [vertices2, faces2] = removeMeshEars(vertices, faces, varargin)
%REMOVEMESHEARS Remove vertices that are connected to only one face.
%
%   [V, F] = removeMeshEars(V, F)
%
%   Example
%   removeMeshEars
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2019-01-08,    using Matlab 8.6.0.267246 (R2015b)
% Copyright 2019 INRA - Cepia Software Platform.

nVertices = size(vertices, 1);

% for each vertex, determine the number of faces it belongs to
vertexDegree = zeros(nVertices, 1);
for iv = 1:nVertices
    vertexDegree(iv) = sum(sum(faces == iv, 2) > 0);
end

% remove vertices with degree 1
inds = find(vertexDegree == 1);
[vertices2, faces2] = removeMeshVertices(vertices, faces, inds);

