function [nodes2, edges2] = grRemoveNodes(nodes, edges, rmNodes)
%GRREMOVENODES Remove several nodes in a graph
%
%   usage:
%   [NODES2 EDGES2] = grRemoveNodes(NODES, EDGES, NODES2REMOVE)
%   remove the nodes with indices NODE2REMOVE from array NODES, and also
%   remove edges containing the nodes NODE2REMOVE.
%
%   -----
%
%   author: David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 13/08/2003.
%

%   HISTORY
%   10/02/2004 doc


%% edges processing

% remove all edges connected to each node
for i = 1:length(rmNodes)
    neighbours = grNeighborNodes(edges, rmNodes(i));
    if ~isempty(neighbours)
        [nodes, edges] = grRemoveEdges(nodes, edges, neighbours);
    end
end

% change edges information, due to the node index shift
for n = 1:length(rmNodes)
    for i = 1:length(edges)
        if edges(i,1) > rmNodes(n)-n+1
            edges(i,1) = edges(i,1) - 1;
        end
        if edges(i,2) > rmNodes(n)-n+1
            edges(i,2) = edges(i,2) - 1;
        end
    end 
end

edges2 = edges;


%% nodes processing

% number of nodes
N   = size(nodes, 1);
NR  = length(rmNodes);
N2  = N-NR;

% allocate memory
nodes2 = zeros(N2, 2);

% process the first node
nodes2(1:rmNodes(1)-1,:) = nodes(1:rmNodes(1)-1,:);

% process the classical nodes
for i = 2:NR
    nodes2(rmNodes(i-1)-i+2:rmNodes(i)-i, :) = nodes(rmNodes(i-1)+1:rmNodes(i)-1, :);
end

% process the last node
nodes2(rmNodes(NR)-NR+1:N2, :) = nodes(rmNodes(NR)+1:N, :);
