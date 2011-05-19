function [nodes, edges2] = grRemoveEdge(nodes, edges, edge)
%GRREMOVEEDGE Remove an edge in a graph.
%
%   [NODES2 EDGES2] = grRemoveEdge(NODES, EDGES, EDGE2REMOVE)
%   Remove an edge in the edges list, and return the modified graph.
%   The NODES array is not modified.
%
%   -----
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 13/08/2003.
%

%   HISTORY
%   10/02/2004 doc


dim = size(edges);
edges2 = zeros(dim(1)-1, 2);
edges2(1:edge-1, :) = edges(1:edge-1, :);
edges2(edge:dim(1)-1, :) = edges(edge+1:dim(1), :);
