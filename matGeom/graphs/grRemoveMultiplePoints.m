function varargout = grRemoveMultiplePoints(nodes, edges)
%GRREMOVEMULTIPLEPOINTS Remove groups of close nodes in a graph
%
%   grRemoveMultiplePoints(nodes, edges)
%   Detects groups of nodes that belongs to the same global node.
%   This function is intended to be used as filter after a binary image
%   skeletonization and vectorization.
%
%   -----
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 13/08/2003.
%

%   HISTORY
%   10/02/2004 doc
%   27/04/2005 function was not working, due to mergeNode modification.


% TODO: accelerate function, by limiting action on nodes with degree>2
% TODO: algo does not work, it can forget some groups.

n = 1;
while n <= length(nodes)
    
    x = nodes(n, 1);
    y = nodes(n, 2);
    
    p1 = findPoint([x-1, y], nodes);
    p2 = findPoint([x+1, y], nodes);
    p3 = findPoint([x, y-1], nodes);
    p4 = findPoint([x, y+1], nodes);
    
    p = [p1 p2 p3 p4];
    p = p(p ~= 0);
        
    if length(p) > 1
        [nodes edges] = grMergeNodes(nodes, edges, [n p]);
    end
    
    n = n+1;
end

% renumerate edges
b = unique(edges(:));
for i = 1:length(b)
    edges(edges == b(i)) = i;
end

% remove extra nodes
nodes = nodes(b, :);


% process output depending on how many arguments are needed
if nargout == 1
    out{1} = nodes;
    out{2} = edges;
    varargout{1} = out;
end

if nargout == 2
    varargout{1} = nodes;
    varargout{2} = edges;
end

