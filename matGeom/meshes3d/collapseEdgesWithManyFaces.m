function [vertices, faces] = collapseEdgesWithManyFaces(vertices, faces, varargin)
% removes mesh edges adjacent to more than two faces
%
%   [V2, F2] = collapseEdgesWithManyFaces(V, F)
%   Count the number of faces adjacent to each edge, and collapse the edges
%   adjacent to more than two faces. 
%
%
%   Example
%   collapseEdgesWithManyFaces
%
%   See also
%       trimMesh
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2019-01-31,    using Matlab 9.5.0.944444 (R2018b)
% Copyright 2019 INRA - Cepia Software Platform.

while true
    % compute edge to vertex mapping
    edges = meshEdges(faces);
    
    % compute number of faces incident each edge
    edgeFaces = trimeshEdgeFaces(faces);
    edgeFaceDegrees = sum(edgeFaces > 0, 2);
    
    inds = find(edgeFaceDegrees > 2);
    
    if isempty(inds)
        break;
    end
    
    [v2, f2] = mergeMeshVertices(vertices, faces, edges(inds(1),:));
end

% trim
[vertices, faces] = trimMesh(v2, f2);
