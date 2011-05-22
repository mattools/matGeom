function path = grFindMaximalLengthPath(nodes, edges, edgeWeights)
%GRFINDMAXIMALLENGTHPATH Find a path that maximizes sum of edge weights
%
%   PATH = grFindMaximalLengthPath(NODES, EDGES, EDGE_WEIGHTS);
%   Finds a greatest geodesic path in the graph. A path between two nodes
%   is a succession of adjacent edges that link the first and last nodes.
%   the length of the path is the sum of weights of edges that constitute
%   the path.
%   A geodesic path is a path that minimizes the length of the path among
%   the set of paths between the nodes.
%   A maximal length path maximizes the length of the geodesic path between
%   couples of nodes in the graph
%
%   The result PATH is the list of edge indices that constitutes the path.
%
%   PATH = grFindMaximalLengthPath(NODES, EDGES);
%   Assumes each edge has a weight equal to 1.
%
%   See Also
%   grFindGeodesicPath
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% ensure weights are defined
if ~exist('edgeWeights', 'var')
    edgeWeights = ones(size(edges, 1), 1);
end

% find an extremity vertex
inds = graphPeripheralVertices(nodes, edges, edgeWeights);
ind0 = inds(end);

% find a vertex opposite to the first extremity
dists = grPropagateDistance(nodes, edges, ind0, edgeWeights);
ind1 = find(dists == max(dists), 1, 'first');

% iterate on neighbors of current node: choose next neighbor with smallest
% cumulated weight, until we are back on source node
path = [];
while true
    % find neighbor with lowest cumulated distance
    neighs = grNeighborNodes(edges, ind1);
    neighDists = dists(neighs);
    indN = find(neighDists == min(neighDists), 1);
    ind2 = neighs(indN);
    
    % add edge index to the path
    indE = find(sum(ismember(edges, [ind1 ind2]), 2) == 2, 1);
    path = [path indE]; %#ok<AGROW>
    
    % test if path is finished or not
    if ind2 == ind0
        break;
    end
    ind1 = ind2;
end
