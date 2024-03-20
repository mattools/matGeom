function neigh = grNeighborEdges(edges, node)
%GRNEIGHBOREDGES Find adjacent edges of a given node.
%
%   Deprecated, use 'grAdjacentEdges' instead.
%
%   NEIGHS = grNeighborEdges(EDGES, NODE)
%   EDGES  : the complete edges list
%   NODE   : index of the node
%   NEIGHS : the indices of edges containing the node index
%
%   See also
%     grAdjacentEdges

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2003-08-13
% Copyright 2003 INRA - TPV URPOI - BIA IMASTE

warning('MatGeom:graphs:deprecated', ...
    'function grNeighborEdges is obsolete, use grAdjacentEdges instead');

neigh = find(edges(:,1) == node | edges(:,2) == node);
