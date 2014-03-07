function [nodes2, edges2] = grRemoveNodes(nodes, edges, rmNodes)
%GRREMOVENODES Remove several nodes in a graph
%
%   usage:
%   [NODES2 EDGES2] = grRemoveNodes(NODES, EDGES, NODES2REMOVE)
%   remove the nodes with indices NODE2REMOVE from array NODES, and also
%   remove edges containing the nodes NODE2REMOVE.
%
%   Example
%     nodes = [...
%         10 10; 20 10; 30 10; ...
%         10 20; 20 20; 30 20];
%     edges = [...
%         1 2; 1 4; 1 5; ...
%         2 3; 2 5; 2 6; ...
%         3 6; 4 5; 5 6];
%     toRemove = [3 4];
%     [nodes2 edges2] = grRemoveNodes(nodes, edges, toRemove);
%     drawGraph(nodes2, edges2);
%     axis equal; axis([0 40 0 30]);
%
%   See also
%     grRemoveEdges
%

%   -----
%   author: David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 13/08/2003.
%

%   HISTORY
%   10/02/2004 doc
%   07/03/2014 rewrite using clearer algorithm


%% edges processing

% remove all edges connected to one of the nodes to remove
edges2 = edges(~any(ismember(edges, rmNodes), 2), :);

% change edges information, due to the node index shift
for i = 1:length(rmNodes)
    inds = edges2 > (rmNodes(i) - i + 1);
    edges2(inds) = edges2(inds) - 1;
end


%% nodes processing

% number of nodes
N   = size(nodes, 1);
NR  = length(rmNodes);
N2  = N-NR;

% allocate memory
nodes2 = zeros(N2, 2);

% process the first node
nodes2(1:rmNodes(1)-1,:) = nodes(1:rmNodes(1)-1,:);

for i = 2:NR
    inds = rmNodes(i-1)+1:rmNodes(i)-1;
    if isempty(inds)
        continue;
    end
    nodes2(inds - i + 1, :) = nodes(inds, :);
end

% process the last node
nodes2(rmNodes(NR)-NR+1:N2, :) = nodes(rmNodes(NR)+1:N, :);
