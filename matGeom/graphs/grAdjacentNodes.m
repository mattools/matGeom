function nodes2 = grAdjacentNodes(edges, node)
%GRADJACENTNODES Find list of nodes adjacent to a given node.
%
%   NEIGHS = grAdjacentNodes(EDGES, NODE)
%   EDGES: the complete edges list (containing indices of neighbor nodes)
%   NODE: index of the node
%   NEIGHS: the nodes adjacent to the given node.
%
%   NODE can also be a vector of node indices, in this case the result is
%   the set of neighbors of any input node, excluding the input nodes.
%
%   Example
%     % create a basic graph and display it
%     nodes = [10 10;20 10;10 20;20 20;27 15];
%     edges = [1 2;1 3;2 4;2 5;3 4;4 5];
%     figure; drawGraph(nodes, edges);
%     hold on; drawNodeLabels(nodes, 1:5)
%     axis equal; axis([0 40 0 30]);
%     % compute list of nodes adjacent to node with index 2
%     grAdjacentNodes(edges, 2)
%     ans =
%         1
%         4
%         5
%
%   See Also
%     grAdjacentEdges

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2004-08-16
% Copyright 2004 INRA - TPV URPOI - BIA IMASTE

[i, j] = find(ismember(edges, node)); %#ok<ASGLU> 
nodes2 = edges(i,1:2);
nodes2 = unique(nodes2(:));
nodes2 = sort(nodes2(~ismember(nodes2, node)));
