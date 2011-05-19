function degree = grNodeInnerDegree(node, edges)
%GRNODEINNERDEGREE Inner degree of a node in a graph
%
%   DEG = grNodeInnerDegree(NODE, EDGES);
%   Returns the inner degree of a node in the given edge list, i.e. the
%   number of edges arriving to it.
%   NODE is the index of the node, and EDGES is a liste of couples of
%   indices (origin and destination node).   
% 
%   Note: Also works when node is a vector of indices
%
%   See Also:
%   grNodeDegree, grNodeOuterDegree
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2006-01-17
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).
%

%   HISTORY
%   2008-08-07 pre-allocate memory, update doc

% allocate memory
N = size(node, 1);
degree = zeros(N, 1);

% compute inner degree of each vertex
for i=1:length(node)
    degree(i) = sum(edges(:,2)==node(i));
end
