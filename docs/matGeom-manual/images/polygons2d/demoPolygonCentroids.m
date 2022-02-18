%DEMOPOLYGONCENTROIDS  One-line description here, please.
%
%   output = demoPolygonCentroids(input)
%
%   Example
%   demoPolygonCentroids
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2022-02-16,    using Matlab 9.9.0.1570001 (R2020b) Update 4
% Copyright 2022 INRAE.


%% Demo polygon

% vertices of a "U"-shaped polygon
poly = [0 0;30 0;30 20;20 20;20 11;10 11;10 20;0 20];

% display the filled polygon and the open polyline
figure; hold on; axis equal; axis([-5 35 -5 30]);
fillPolygon(poly, 'c');
hPoly = drawPolygon(poly, 'linewidth', 2, 'color', 'k');
drawVertices(poly);


%% Computes various centroids

% computes the centroids
vxCentroid = centroid(poly);
lsCentroid = polylineCentroid(poly, 'closed');
pgCentroid = polygonCentroid(poly);

% display the centroids
hVxc = drawPoint(vxCentroid, 'marker', 'o', 'color', [0.8 0 0], 'linewidth', 2, 'MarkerFaceColor', 'w');
hLsc = drawPoint(lsCentroid, 'marker', 'o', 'color', [0 0.8 0], 'linewidth', 2, 'MarkerFaceColor', 'w');
hPgc = drawPoint(pgCentroid, 'marker', 'o', 'color', [0 0 0.8], 'linewidth', 2, 'MarkerFaceColor', 'w');

% decorate graph
legend([hPoly hVxc hLsc hPgc], ...
    {'Polygon', 'Vertex Centroid', 'Polyline Centroid', 'Polygon Centroid'}, ...
    'Location', 'NorthEast');

print(gcf, 'polygon_centroids.png', '-dpng');
