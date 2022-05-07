%DEMO_POLYGONSKELETON  One-line description here, please.
%
%   output = demo_polygonSkeleton(input)
%
%   Example
%   demo_polygonSkeleton
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2022-02-18,    using Matlab 9.10.0.1739362 (R2021a) Update 5
% Copyright 2022 INRAE.

% Note: this example require the "matGraphs" toolbox
% (https://github.com/mattools/matGraphs)

% read polygon data
poly = load('leaf_poly.txt');

% compute a smooth contour
poly2 = smoothPolygon(poly, 15);

% draw the polygon
figure; axis equal; axis([0 600 0 450]); hold on;
drawPolygon(poly2, 'color', 'k', 'linewidth', 2);

% compute skeleton
[vertices, adjList] = polygonSkeleton(poly2);
% convert adjacency list to an edge array
edges = adjacencyListToEdges(adjList);
% draw the skeleton graph
drawGraphEdges(vertices, edges, 'color', 'b');

print(gcf, 'demo_polygonSkeleton_leaf.png', '-dpng');
