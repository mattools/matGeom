function varargout = grSimplifyBranches_old(nodes, edges)
%GRSIMPLIFYBRANCHES_OLD Replace branches of a graph by single edges
%
%   [NODES2 EDGES2] = grSimplifyBranches(NODES, EDGES)
%   Replaces each branch (composed of a series of edges connected only by
%   2-degree nodes) by a single edge, whose extremities are nodes with
%   degree >= 3.
%
%   -----
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 13/08/2003.
%

%   HISTORY
%   10/02/2004 doc

n = 1;
while n < length(nodes)
    neigh = grNeighborNodes(edges, n);
    if length(neigh) == 2
        % find other node of first edge
        edge = edges(neigh(1), :);
        if edge(1) == n
            node1 = edge(2);
        else
            node1 = edge(1);
        end

        % replace current node in the edge by the other node
        % of first edge
        edge = edges(neigh(2), :);
        if edge(1) == n
            edges(neigh(2), 1) = node1;
        else
            edges(neigh(2), 2) = node1;
        end
        
        [nodes edges] = grRemoveNode(nodes, edges, n);
        continue
    end
    
    n = n + 1;
end

% process output depending on how many arguments are needed
if nargout == 1
    out{1} = nodes;
    out{2} = edges;
    varargout = {out};
end

if nargout == 2
    varargout = {nodes, edges};
end
