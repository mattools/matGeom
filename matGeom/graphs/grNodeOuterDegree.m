function degree = grNodeOuterDegree(node, edges)
%GRNODEOUTERDEGREE Outer degree of a node in a graph.
%
%   DEG = grNodeOuterDegree(NODE, EDGES);
%   Returns the outer degree of a node in the given edge list, i.e. the
%   number of edges emanating from it.
%   NODE is the index of the node, and EDGES is a liste of couples of
%   indices (origin and destination node).   
% 
%   Note: Also works when node is a vector of indices
%
%   See also 
%   grNodeDegree, grNodeInnerDegree
%

% ------
% Author: David Legland
% E-mail: david.legland@grignon.inra.fr
% Created: 2006-01-17
% Copyright 2006-2022 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas)

% allocate memory
N = size(node, 1);
degree = zeros(N, 1);

% compute outer degree of each vertex
for i=1:N
    degree(i) = sum(edges(:,1)==node(i));
end
