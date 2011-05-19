function node2 = grOppositeNode(edges, node)
%GROPPOSITENODE Return opposite node in an edge
%
%   NODE2 = grOppositeNode(EDGE, NODE);
%   Return the index of the node opposite to NODE in EDGE.
%   If the edge does not contain node NODE, result is 0.
%
%   Works also if EDGE is a N-by-2 array of source and target vertex
%   indices, in this case the result NODE2 has as many rows as the number
%   of edges.
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-09-07
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

%   HISTORY

% allocate memory for result
Ne = size(edges, 1);
node2 = zeros(Ne, 1);

% iterate on edges
for i = 1:Ne
    if edges(i,1) == node
        node2(i) = edges(i,2);        
    elseif edges(i,2) == node
        node2(i) = edges(i,1);
    end
end
