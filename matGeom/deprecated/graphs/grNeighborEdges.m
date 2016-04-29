function neigh = grNeighborEdges(edges, node)
%GRNEIGHBOREDGES Find adjacent edges of a given node
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

%   -----
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 13/08/2003.
%

%   HISTORY
%   10/02/2004 : documentation
%   13/07/2004 : faster algorithm
%   17/01/2006 : rename and change implementation

warning('MatGeom:graphs:deprecated', ...
    'function grNeighborEdges is obsolete, use grAdjacentEdges instead');

neigh = find(edges(:,1) == node | edges(:,2) == node);
