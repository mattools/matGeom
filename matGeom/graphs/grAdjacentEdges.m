function neigh = grAdjacentEdges(edges, node)
%GRADJACENTEDGES Find list of edges adjacent to a given node
%
%   NEIGHS = grAdjacentEdges(EDGES, NODE)
%   EDGES  the complete edges list (containing indices of neighbor nodes)
%   NODE   index of the node
%   NEIGHS the indices of edges containing the node index
%
%   See also
%     grAdjacentNodes

%   -----
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 13/08/2003.
%

%   HISTORY
%   10/02/2004 : documentation
%   13/07/2004 : faster algorithm
%   17/01/2006 : rename and change implementation

neigh = find(edges(:,1) == node | edges(:,2) == node);
