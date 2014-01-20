function lengths = grEdgeLengths(nodes, edges, varargin)
%GREDGELENGTHS  Compute length of edges in a geometric graph
%
%   LENGTHS = grEdgeLengths(NODES, EDGES)
%
%   Example
%     % create a basic graph and display it
%     nodes = [10 10;20 10;10 20;20 20;27 15];
%     edges = [1 2;1 3;2 4;2 5;3 4;4 5];
%     figure; drawGraph(nodes, edges);
%     hold on; drawNodeLabels(nodes, 1:5)
%     axis equal; axis([0 40 0 30]);
%     % compute list of nodes adjacent to node with index 2
%     grEdgeLengths(nodes, edges)'
%     ans =
%          10.0000   10.0000   10.0000    8.6023   10.0000    8.6023
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2014-01-13,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2014 INRA - Cepia Software Platform.

nEdges = size(edges, 1);
lengths = zeros(nEdges, 1);


for iEdge = 1:nEdges
    ed = edges(iEdge, :);
    node1 = nodes(ed(1),:);
    node2 = nodes(ed(2),:);
    lengths(iEdge) = sqrt(sum((node1 - node2).^2));
end
