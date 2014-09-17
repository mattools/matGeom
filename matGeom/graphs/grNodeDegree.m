function [degree, node] = grNodeDegree(node, edges)
%GRNODEDEGREE Degree of a node in a (undirected) graph
%
%   DEGREE = grNodeDegree(NODE_INDEX, EDGES);
%   return the degree of a node in the given edge list, that is the number
%   of edges connected to it.
%   NODE_INDEX is the index of the node, and EDGES is a liste of couples of
%   indices (origin and destination node).   
%   This degree is the sum of inner degree (number of edges arriving on the
%   node) and the outer degree (number of emanating edges).
%  
%   Note: Also works when NODE_INDEX is a vector of indices
%
%   DEGREE = grNodeDegree(EDGES);
%   Return the degree of each node references by the array EDGES. DEGREE is
%   a column vector with as many rows as the number of nodes referenced by
%   edges.
%
%   [DEG, INDS] = grNodeDegree(EDGES);
%   Also returns the indices of the nodes that were referenced.
%   
%   Example
%     edges = [1 2;1 3;2 3;2 4;3 4];
%     grNodeDegree(2, edges)
%     ans =
%          3
%     grNodeDegree(edges)'
%     ans =
%          2     3     3     2
%
%   See Also: grNodeInnerDegree, grNodeOuterDegree
%

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2003-08-13
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

%   HISTORY
%   10/02/2004 documentation
%   17/01/2006 change name, reimplement, and rewrite doc.
%   13/01/2014 add psb to compute degree of all nodes

% If only edge array is given, assume we want the degree of each node
if nargin == 1
    edges = node;
    node = unique(edges(:));
end

% allocate array for result
degree = zeros(size(node));

% for each node ID, count the number of edges containing it
for i = 1:length(node(:))
    degree(i) = sum(edges(:,1) == node(i)) + sum(edges(:,2) == node(i));
end
