%SPHERE_INTERSECTIONS  One-line description here, please.
%
%   output = sphere_intersections(input)
%
%   Example
%   sphere_intersections
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2020-01-09,    using Matlab 9.7.0.1247435 (R2019b) Update 2
% Copyright 2020 INRA - Cepia Software Platform.

%% demo sphere

sphere = [50 50 50 30];

figure; hold on; axis equal; axis([0 100 0 100 0 100]); view(3);
drawSphere(sphere, 'faceAlpha', .9);
print(gcf, 'sphere.png', '-dpng');

drawCircle3d([50 50 50 30 0 0], 'linewidth', 1, 'color', 'k');
drawCircle3d([50 50 50 30 90 0], 'linewidth', 1, 'color', 'k');
drawCircle3d([50 50 50 30 90 90], 'linewidth', 1, 'color', 'k');
print(gcf, 'sphere_circles.png', '-dpng');

plane = createPlane([40 40 40], [-1 1 5]);
drawPlane3d(plane, 'facecolor', 'm', 'faceAlpha', .9);

circ = intersectPlaneSphere(plane, sphere);
drawCircle3d(circ, 'linewidth', 3, 'color', 'b');

line = [50 50 70   3 2 1];
drawLine3d(line, 'color', 'k', 'linewidth', 2);

pts = intersectLineSphere(line, sphere);
drawPoint3d(pts, 'color', 'k', 'marker', '*', 'linewidth', 2, 'markersize', 8);
print(gcf, 'sphere_intersections.png', '-dpng');
