function edges = adjacencyListToEdges(adjList)
% Convert an adjacency list to an edge array.
%
%   EDGES = adjacencyListToEdges(ADJ)
%   Converts the adjacency list ADJ, given as a cell array of adjacent
%   indices, to an edge array. 
%
%   Example
%     % create adjacency list for a simple graph
%     adj = {[2 3], [1 4 5], [1 4], [2 3 5], [2 4]};
%     edges = adjacencyListToEdges(adj)
%     edges =
%          1     2
%          1     3
%          2     4
%          2     5
%          3     4
%          4     5
%
%   See also
%     graphs, polygonSkeletonGraph
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-06-02,    using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2020 INRAE.

% TODO: allocate memory

% create the connectivity array
edges = zeros([0 2]);
for iVertex = 1:length(adjList)
    neighs = adjList{iVertex};
    for iNeigh = 1:length(neighs)
        edge = sort([iVertex neighs(iNeigh)]);
        edges = [edges ; edge]; %#ok<AGROW>
    end
end
edges = unique(edges, 'rows');
