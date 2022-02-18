%POINTS2D_DEMO  One-line description here, please.
%
%   output = points2d_demo(input)
%
%   Example
%   points2d_demo
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2020-01-08,    using Matlab 9.7.0.1247435 (R2019b) Update 2
% Copyright 2020 INRA - Cepia Software Platform.

%% generate data

rng(42);
pts = randn([100 2]) * 15 + 50;

figure; hold on; axis([0 100 0 100]);
drawPoint(pts, 'k+');
print(gcf, 'points2d.png', '-dpng');

centPts = centroid(pts);


%% bounding box

bbox = boundingBox(pts);

figure; hold on; axis([0 100 0 100]);
drawPoint(pts, 'k+');
drawBox(bbox, 'color', 'b', 'linewidth', 2);
print(gcf, 'points2d_bbox.png', '-dpng');


%% equivalent ellipse

elli = equivalentEllipse(pts);

figure; hold on; axis([0 100 0 100]);
drawPoint(pts, 'k+');
drawEllipse(elli, 'color', 'b', 'linewidth', 2);
print(gcf, 'points2d_ellipse.png', '-dpng');


%% equivalent ellipse

hull = convexHull(pts);

figure; hold on; axis([0 100 0 100]);
drawPoint(pts, 'k+');
drawPolygon(hull, 'color', 'b', 'linewidth', 2);
print(gcf, 'points2d_hull.png', '-dpng');


%% everything together

figure; hold on; axis([0 100 0 100]);
hp = drawPoint(pts, 'color', 'k', 'marker', 'o', 'linewidth', 2);
hc = drawPoint(centPts, 'color', 'b', 'marker', '*', 'linewidth', 2, 'MarkerSize', 10);
hb = drawBox(bbox, 'color', [0 0 .7], 'linewidth', 2);
he = drawEllipse(elli, 'color', [.7 0 0], 'linewidth', 2);
hh = drawPolygon(hull, 'color', [0 .7 0], 'linewidth', 2);
legend({'Points', 'Centroid', 'BoundingBox', 'Equiv. Ellipse', 'Conv. Hull'}, 'Location', 'NorthEast');
print(gcf, 'points2d_demo.png', '-dpng');
