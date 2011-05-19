function nodes2 = grNeighborNodes(edges, node)
%GRNEIGHBORNODES Find adjacent nodes of a given node
%
%   NEIGHS = grNeighborNodes(EDGES, NODE)
%   EDGES: the complete edges list
%   NODE: index of the node
%   NEIGHS: the nodes adjacent to the given node.
%
%   NODE can also be a vector of node indices, in this case the result is
%   the set of neighbors of any input node.
%
%   -----
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 16/08/2004.
%

%   HISTORY
%   10/02/2004 documentation
%   13/07/2004 faster algorithm
%   03/10/2007 can specify several input nodes

[i, j] = find(ismember(edges, node)); %#ok<NASGU>
nodes2 = edges(i,1:2);
nodes2 = unique(nodes2(:));
nodes2 = sort(nodes2(~ismember(nodes2, node)));