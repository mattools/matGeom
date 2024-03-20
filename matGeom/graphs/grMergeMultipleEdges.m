function varargout = grMergeMultipleEdges(nodes, edges)
%GRMERGEMULTIPLEEDGES Remove all edges sharing the same extremities.
%
%   [NODES2, EDGES2] = grMergeMultipleEdges(NODES, EDGES)
%   Remove configuration with two edges sharing the same 2 nodes.
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-08-13
% Copyright 2003-2023 INRA - TPV URPOI - BIA IMASTE

rmedge = [];
for e = 1:length(edges)
    edge = edges(e, :);
    for e2 = e+1:length(edges)
        if (edge(1) == edges(e2, 1) && edge(2) == edges(e2, 2)) || ...
           (edge(1) == edges(e2, 2) && edge(2) == edges(e2, 1))
                rmedge(length(rmedge)+1) = e2; %#ok<AGROW>
        end
    end
end

[nodes, edges] = grRemoveEdges(nodes, edges, rmedge);

% process output depending on how many arguments are needed
if nargout == 1
    out{1} = nodes;
    out{2} = edges;
    varargout{1} = out;
end

if nargout == 2
    varargout = {nodes, edges};
end

