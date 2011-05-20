function [nodes2 edges2] = grMergeNodeClusters(nodes, edges)
%GRMERGENODECLUSTERS Merge cluster of connected nodes in a graph
%
%   grMergeNodeClusters(nodes, edges)
%   Detects groups of nodes that belongs to the same global node, and
%   replace them by a unique node. Coordinates of reference node is given
%   by the median coordinates of cluster nodes.
%
%   This function is intended to be used as filter after a binary image
%   skeletonization and vectorization.
%
%
%   See Also
%   grMergeNodesMedian
%
%   -----
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 13/08/2003.
%

%   HISTORY


%% Initialization

% intialize result 
nodes2 = nodes;
edges2 = edges;

% compute degree of each node
degrees = grNodeDegree(1:size(nodes, 1), edges)';

% find index of multiple nodes
indMul = find(degrees > 2);

% indices of edges that link several multiple nodes
indEdges = sum(ismember(edges, indMul), 2) == 2;

% associate a label to each cluster
labels = grLabel(nodes, edges(indEdges, :));
clusterLabels = unique(labels(indMul));


%% Replace each cluster by median point

% iterate on clusters
for i = 1:length(clusterLabels)
    % indices of nodes of the current cluster
    inds = find(labels == clusterLabels(i));
    
    % coordinates of new reference node
    clusterNodes = nodes(inds, :);
    medianNode = median(clusterNodes, 1);
    
    % replace coordinates of reference node
    refNode = min(inds);
    nodes2(refNode, :) = medianNode;
    
    % replace node indices in edge array
    edges2(ismember(edges2, inds)) = refNode;
end


%% Clean up

% keep only relevant nodes
inds = unique(edges2(:));
nodes2 = nodes2(inds, :);

% relabeling of edges
for i = 1:length(inds)
    edges2(edges2 == inds(i)) = i;
end

% remove double edges
edges2 = unique(sort(edges2, 2), 'rows');

% remove 'loops'
edges2(edges2(:,1) == edges2(:,2), :) = [];
