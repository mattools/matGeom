function varargout = prim_mst(edges, vals)
%PRIM_MST Minimal spanning tree by Prim's algorithm.
%
%   EDGES2 = prim_mst(EDGES, WEIGHTS)
%   Compute the minimal spanning tree (MST) of the graph with edges given
%   by EDGES, and using the specified edge weights.
%   The nodes of the resulting tree are the same as the nodes of the
%   original graph. Therefore, the function requires only to specify edges.
%
%   Example
%     pts = load('sedgewick_points.txt');
%     [nodes, edges] = delaunayGraph(pts);
%     figure; drawGraphEdges(nodes, edges, 'color', 'k');
%     axis equal; axis([10 27 10 27]); hold on;
%     weights = grEdgeLengths(nodes, edges);
%     edges2 = prim_mst(edges, weights);
%     drawGraphEdges(nodes, edges2, 'linewidth', 2, 'color', 'b');
%   
%   See also 
%     euclideanMST, grEdgeLengths
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2007-07-27, using Matlab 7.4.0.287 (R2007a)
% Copyright 2007-2024 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas

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
    [tmp, ind2] = min(vals(ind)); %#ok<ASGLU>
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
