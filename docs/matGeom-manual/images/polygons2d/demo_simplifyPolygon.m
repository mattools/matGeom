%DEMO_SIMPLIFYPOLYGON  One-line description here, please.
%
%   output = demo_simplifyPolygon(input)
%
%   Example
%   demo_simplifyPolygon
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
drawPolygon(poly, 'lineWidth', 2, 'color', 'b');

% print(gcf, 'leafPoly.png', '-dpng');

% simplify with 
poly5 = simplifyPolygon(poly, 5);
drawPolygon(poly5, 'color', 'r', 'linewidth', 1);
drawPoint(poly5, 'marker', 's', 'color', 'r', 'markerFaceColor', 'w', 'linewidth', 1);

% print(gcf, 'leafPoly_simplifiedD5.png', '-dpng');

legend({'Original polygon', 'Simplified polygon'}, 'Location', 'NorthEast');
print(gcf, 'leafPoly_simplifiedD5_annot.png', '-dpng');

