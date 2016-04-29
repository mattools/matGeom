function lengths = grEdgeLength(nodes, edges, varargin)
%GREDGELENGTH  Compute length of edges in a geometric graph
%
%   Deprecated, use 'grEdgeLengths' instead.
%
%   LENGTHS = grEdgeLength(NODES, EDGES)
%
%   Example
%   grEdgeLength
%
%   See also
%     grEdgeLenghts

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2014-01-13,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2014 INRA - Cepia Software Platform.

warning('MatGeom:graphs:deprecated', ...
    'function grEdgeLength is obsolete, use grEdgeLengths instead');

nEdges = size(edges, 1);
lengths = zeros(nEdges, 1);


for iEdge = 1:nEdges
    ed = edges(iEdge, :);
    node1 = nodes(ed(1),:);
    node2 = nodes(ed(2),:);
    lengths(iEdge) = sqrt(sum((node1 - node2).^2));
end
