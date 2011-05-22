function path = grFindGeodesicPath(nodes, edges, ind0, ind1, edgeWeights)
%GRFINDGEODESICPATH Find a geodesic path between two nodes in the graph
%
%   PATH = grFindGeodesicPath(NODES, EDGES, NODE1, NODE2, WEIGHTS)
%   NODES and EDGES defines the graph, NODE1 and NODE2 are indices of the
%   node extremities, and WEIGHTS is the set of weights associated to each
%   edge.
%   The function returns a set of edge indices.
%
%
%   See also
%   grFindMaximalLengthPath
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

% check indices limits
nNodes = size(nodes, 1);
if max(ind0) > nNodes
    error('Start index exceed number of nodes in the graph');
end
if max(ind1) > nNodes
    error('End index exceed number of nodes in the graph');
end

% find a vertex opposite to the first extremity
dists = grPropagateDistance(nodes, edges, ind0, edgeWeights);

% iterate on neighbors of current node: choose next neighbor with smallest
% cumulated weight, until we are back on source node
path = [];
while true
    % find neighbor with lowest cumulated distance
    neighs = grNeighborNodes(edges, ind1);
    neighDists = dists(neighs);
    indN = find(neighDists == min(neighDists), 1);
    ind2 = neighs(indN);

    if isempty(ind2)
        warning('graphs:grFindGeodesicPath', ...
            'No neighbor node found for node %d, graph may be not connected', ind1);
        break;
    end

    % add edge index to the path
    indE = find(sum(ismember(edges, [ind1 ind2]), 2) == 2, 1);
    path = [path indE]; %#ok<AGROW>
    
    % test if path is finished or not
    if ind2 == ind0
        break;
    end
    ind1 = ind2;
end

% reverse path direction
path = path(end:-1:1);
