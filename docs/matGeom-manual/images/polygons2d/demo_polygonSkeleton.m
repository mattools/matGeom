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
% start from a binary shape
img = imread('circles.png');
img = imfill(img, 'holes');
% figure; imshow(img); hold on;

% compute a smooth contour
cntList = bwboundaries(img);
poly = cntList{1}(2:end,:);
poly = smoothPolygon(poly, 5);

% draw the polygon
figure; hold on; axis equal; axis([0 250 0 250]);
drawPolygon(poly, 'color', 'k', 'linewidth', 1);

% compute skeleton
[vertices, adjList] = polygonSkeleton(poly);
% convert adjacency list to an edge array
edges = adjacencyListToEdges(adjList);
% draw the skeleton graph
drawGraphEdges(vertices, edges, 'color', 'b');

print(gcf, 'demo_polygonSkeleton.png', '-dpng');
