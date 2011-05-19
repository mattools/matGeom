function varargout = prim_mst(edges, vals)
%PRIM_MST Minimal spanning tree by Prim's algorithm
%
%   EDGES2 = prim_mst(EDGES, VALUES)
%   Compute the minimal spanning tree (MST) of the graph with edges given
%   by EDGES, and whose edges are valuated by VALUES.
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-07-27,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% isolate vertices index
nodes   = unique(edges(:));
N       = length(nodes);

% initialize memory
nodes2  = zeros(N, 1);
edges2  = zeros(N-1, 2);
vals2   = zeros(N-1, 1);

% initialize with a first node
nodes2(1)   = nodes(1);
nodes       = nodes(2:end);

% iterate on edges
for i = 1:N-1
    % find all edges from nodes2 to nodes
    ind = unique(find(...
        (ismember(edges(:,1), nodes2(1:i)) & ismember(edges(:,2), nodes)) | ...
        (ismember(edges(:,1), nodes) & ismember(edges(:,2), nodes2(1:i))) ));
    
    % choose edge with lowest value
    [tmp ind2] = min(vals(ind)); %#ok<ASGLU>
    ind = ind(ind2(1));
    vals2(i) = vals(ind);
    
    % index of other vertex
    edge    = edges(ind, :);
    neigh   = edge(~ismember(edge, nodes2));
    
    % add to list of nodes and list of edges
    nodes2(i+1) = neigh;
    edges2(i,:) = edge;
    
    % remove current node from list of old nodes
    nodes   = nodes(~ismember(nodes, neigh));
end


% process output arguments
if nargout == 1
    varargout{1} = edges2;
elseif nargout==2
    varargout{1} = edges2;
    varargout{2} = vals2;
end
