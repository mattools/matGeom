function [nodes, edges] = grMergeNodes(nodes, edges, mnodes)
%GRMERGENODES Merge two (or more) nodes in a graph.
%
% usage:
%   [NODES2 EDGES2] = grMergeNodes(NODES, EDGES, NODE_INDS)
%   NODES and EDGES are wo arrays representing a graph, and NODE_INDS is
%   the set of indices of the nodes to merge.
%   The nodes corresponding to indices in NODE_INDS are removed from the
%   list, and edges between two nodes are removed.
%
%   Example: merging of lables 1 and 2
%   Edges:         Edges2:
%   [1 2]           [1 3]
%   [1 3]           [1 4]
%   [1 4]           [3 4]
%   [2 3]
%   [3 4]
%   
%
%   -----
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 30/06/2004.
%

refNode = mnodes(1);
mnodes = mnodes(2:length(mnodes));

% replace merged nodes references by references to refNode
edges(ismember(edges, mnodes))=refNode;

% remove "loop edges" from and to reference node
edges = edges(edges(:,1) ~= refNode | edges(:,2) ~= refNode, :);

% format output
edges = sortrows(unique(sort(edges, 2), 'rows'));

