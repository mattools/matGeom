function neigh = grAdjacentEdges(edges, node)
%GRADJACENTEDGES Find list of edges adjacent to a given node.
%
%   NEIGHS = grAdjacentEdges(EDGES, NODE)
%   EDGES  the complete edges list (containing indices of neighbor nodes)
%   NODE   index of the node
%   NEIGHS the indices of edges containing the node index
%
%   See also 
%     grAdjacentNodes

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-08-13
% Copyright 2003-2023 INRA - TPV URPOI - BIA IMASTE

neigh = find(edges(:,1) == node | edges(:,2) == node);
