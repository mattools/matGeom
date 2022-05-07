%DEMO_SMOOTHPOLYGON  One-line description here, please.
%
%   output = demo_smoothPolygon(input)
%
%   Example
%   demo_smoothPolygon
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2022-02-18,    using Matlab 9.10.0.1739362 (R2021a) Update 5
% Copyright 2022 INRAE.

% read data
poly = load('leaf_poly.txt');

% display polygon
figure; axis equal; axis([0 600 0 450]); hold on;
drawPolygon(poly, 'lineWidth', 3, 'color', 'k');

% smooth strongly
polyM11 = smoothPolygon(poly, 11);
drawPolygon(polyM11, 'color', 'g', 'linewidth', 2);
polyM31 = smoothPolygon(poly, 31);
drawPolygon(polyM31, 'color', 'r', 'linewidth', 2);
axis([0 200 150 300]);

% print(gcf, 'leafPoly_smoothM31.png', '-dpng');

legend({'Original polygon', 'Smoothed polygon (M=11)', 'Smoothed polygon (M=31)'}, 'Location', 'NorthEast');
print(gcf, 'leafPoly_smoothM31_annot.png', '-dpng');

