%DEMO_POLYGONCURVATURE Demo script for polygonCurvature.
%
%   output = demo_polygonCurvature(input)
%
%   Example
%   demo_polygonCurvature
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2026-09-29,    using Matlab 26.1.0.3251617 (R2026a) Update 2
% Copyright 2026 INRAE.


%% base polygon

% create a "smooth" polygon using Bezier interpolation
basePoly = [10 10; 30 10; 40 20; 30 40;20 20;10 30];
poly = BSplinePolygon(basePoly, 20);

% compute curvature
kappa = polygonCurvature(curve, 7);

% display
fig1 = figure; hold on; drawPolygon(poly, 'linewidth', 2, 'color', 'k');
axis equal; axis([5 40 7 37]);
fig2 = figure; hold on; plot(kappa, 'linewidth', 2, 'color', 'k');
xlabel('Curvilinear abscissa'); ylabel('Curvature');


%% Add reference points

refPosPos = [61 100];
refPosNeg = [83];
figure(fig1); 
drawPoint(poly(refPosPos, :), 'Marker', 'o', ...
    'Color', 'r', 'linewidth', 4, 'MarkerSize', 8, 'MarkerFaceColor', 'w');
drawPoint(poly(refPosNeg, :), 'Marker', 'o', ...
    'Color', 'b', 'linewidth', 4, 'MarkerSize', 8, 'MarkerFaceColor', 'w');
figure(fig2); 
drawPoint([refPosPos(:) kappa(refPosPos)], 'Marker', 'o', ...
    'Color', 'r', 'linewidth', 4, 'MarkerSize', 8, 'MarkerFaceColor', 'w');
drawPoint([refPosNeg(:) kappa(refPosNeg)], 'Marker', 'o', ...
    'Color', 'b', 'linewidth', 4, 'MarkerSize', 8, 'MarkerFaceColor', 'w');
