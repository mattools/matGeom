function [nodes2, edges2] = pruneGraph(nodes, edges)
%PRUNEGRAPH Remove all edges with a terminal vertex
%
%   [NODES2, EDGES2] = pruneGraph(NODES, EDGES)
%
%   Example
%     nodes = [...
%         10 30; 30 30; 20 45; 50 30; 40 15; 70 30; 90 30; 80 15; 100 45];
%     edges = [1 2;2 3;2 4;4 5;4 6;6 7;6 8;7 8;7 9];
%     figure; 
%     subplot(2, 1, 1); drawGraph(nodes, edges); 
%     axis equal; axis([0 110 10 50]);
%     [nodes2, edges2] = pruneGraph(nodes, edges);
%     subplot(2, 1, 2); drawGraph(nodes2, edges2); 
%     axis equal; axis([0 110 10 50]);
%
%   See also
%   graphs
 
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2015-02-19,    using Matlab 8.4.0.150421 (R2014b)
% Copyright 2015 INRA - Cepia Software Platform.

nNodes = size(nodes, 1);
degs = grNodeDegree(1:nNodes, edges)';

termNodeInds = find(degs == 1);

[nodes2, edges2] = grRemoveNodes(nodes, edges, termNodeInds);
