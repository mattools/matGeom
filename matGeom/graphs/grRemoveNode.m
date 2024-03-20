function [nodes2, edges2] = grRemoveNode(nodes, edges, node)
%GRREMOVENODE Remove a node in a graph.
% 
%   usage:
%   [NODES2 EDGES2] = grRemoveNode(NODES, EDGES, NODE2REMOVE)
%   remove the node with index NODE2REMOVE from array NODES, and also
%   remove edges containing the node NODE2REMOVE.

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-08-13
% Copyright 2003-2023 INRA - TPV URPOI - BIA IMASTE

% remove all edges connected to the node 
neighbours = grAdjacentEdges(edges, node);
[nodes2, edges2] = grRemoveEdges(nodes, edges, neighbours); %#ok<ASGLU>


% change edges information, due to the node index shift
for i = 1:length(edges2)
    if edges2(i,1) > node
        edges2(i,1) = edges2(i,1) - 1;
    end
    if edges2(i,2) > node
        edges2(i,2) = edges2(i,2) - 1;
    end
end

% allocate memory
dim = size(nodes);
nodes2 = zeros(dim(1)-1, 2);

% copy nodes information, except the undesired node
nodes2(1:node-1, :) = nodes(1:node-1, :);
nodes2(node:dim(1)-1, :) = nodes(node+1:dim(1), :);
