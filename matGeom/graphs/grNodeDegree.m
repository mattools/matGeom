function degree = grNodeDegree(node, edges)
%GRNODEDEGREE Degree of a node in a (undirected) graph
%
%   DEG = grNodeDegree(NODE_INDEX, EDGES);
%   return the degree of a node in the given edge list, that is the number
%   of edges connected to it.
%   NODE_INDEX is the index of the node, and EDGES is a liste of couples of
%   indices (origin and destination node).   
%   This degree is the sum of inner degree (number of edges arriving on the
%   node) and the outer degree (number of emanating edges).
%  
%   Note: Also works when NODE_INDEX is a vector of indices
%
%   To get degrees of all nodes:
%   grNodeDegree(1:size(nodes, 1), edges)
%
%   See Also: grNodeInnerDegree, grNodeOuterDegree
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2003-08-13
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

%   HISTORY
%   10/02/2004 documentation
%   17/01/2006 change name, reimplement, and rewrite doc.

degree = zeros(size(node));

for i = 1:length(node(:))
    degree(i) = sum(edges(:,1) == node(i)) + sum(edges(:,2) == node(i));
end
