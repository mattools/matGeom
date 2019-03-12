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
%       trimMesh, isManifoldMesh
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2019-01-31,    using Matlab 9.5.0.944444 (R2018b)
% Copyright 2019 INRA - Cepia Software Platform.

verbose = false;
while length(varargin) > 1 && ischar(varargin{1})
    name = varargin{1};
    if strcmpi(name, 'verbose')
        verbose = varargin{2};
    else
        error(['Unknown optional argument: ' name]);
    end
    varargin(1:2) = [];
end

while true
    % compute edge to vertex mapping
    edges = meshEdges(faces);
    
    % compute number of faces incident to each edge
    edgeFaces = trimeshEdgeFaces(faces);
    edgeFaceDegrees = sum(edgeFaces > 0, 2);
    
    inds = find(edgeFaceDegrees > 2);
    
    if isempty(inds)
        break;
    end
    
    edge = edges(inds(1), :);
    if verbose
        fprintf('remove edge with index %d: (%d, %d)\n', inds(1), edge);
    end
    [vertices, faces] = mergeMeshVertices(vertices, faces, edge);
end

% trim
[vertices, faces] = trimMesh(vertices, faces);
