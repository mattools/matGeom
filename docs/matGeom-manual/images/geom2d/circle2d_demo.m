%CIRCLE2D_DEMO  One-line description here, please.
%
%   output = circle2d_demo(input)
%
%   Example
%   circle2d_demo
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-01-09,    using Matlab 9.7.0.1247435 (R2019b) Update 2
% Copyright 2020 INRAE.


pA = [30 20];
pB = [80 40];
pC = [20 70];

circ = circumCircle(pA, pB, pC);

figure; set(gca, 'fontsize', 14); axis equal; axis([0 100 0 100]); hold on;
drawCircle(circ, 'color', 'b', 'linewidth', 2);
drawPoint([pA ; pB; pC], 'color', 'k', 'markerfacecolor', 'w', 'marker', 'o', 'markersize', 6);

print(gcf, 'circle.png', '-dpng');

poly = circleToPolygon(circ, 12);
drawPolygon(poly, 'color', [0 .7 0], 'linestyle', '-', 'linewidth', 2);

line = [60 70 5 2];
inters = intersectLineCircle(line, circ);
drawLine(line, 'color', 'k');
drawPoint(inters, 'marker', '*', 'color', 'k', 'markersize', 8, 'linewidth', 2);

print(gcf, 'circle_demo.png', '-dpng');