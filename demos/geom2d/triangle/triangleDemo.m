function triangleDemo(varargin)
%TRIANGLEDEMO Demo file of geom2d lib: lines and circles of a triangle
%
%   Usage:
%   triangleDemo
%
%   The macro run automatically, and draw several liens and circles
%   associated with a basic triangle.
%
%   Example
%   triangleDemo
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-11-04,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.


%% Triangle

% defines vertices
p1 = [2 4];
p2 = [18 6];
p3 = [4 16];

% concatenates vertices to form the polygon
triangle = [p1; p2; p3];

% draw the triangle
figure(1); clf;
hold on; 
axis([0 20 0 20]);
axis equal;
drawPolygon(triangle, 'linewidth', 3);
drawPoint(triangle, 'marker', 'o', 'markersize', 10, 'linewidth', 2, ...
    'markerFaceColor', 'w');


%% altitudes

% create lines associated with each triangle edge
edge1 = createLine(p2, p3);
edge2 = createLine(p1, p3);
edge3 = createLine(p1, p2);

% altitudes of the triangle
alt1 = orthogonalLine(edge1, p1);
alt2 = orthogonalLine(edge2, p2);
alt3 = orthogonalLine(edge3, p3);

% compute also feet
foot1 = intersectLines(edge1, alt1);
foot2 = intersectLines(edge2, alt2);
foot3 = intersectLines(edge3, alt3);

% draw altitudes
drawLine(alt1, 'color', [0 0 .8]);
drawLine(alt2, 'color', [0 0 .8]);
drawLine(alt3, 'color', [0 0 .8]);

% draw feet
feet = [foot1; foot2 ;foot3];
drawPoint(feet, 'marker', 's', 'color', [0 0 .8], 'linewidth', 2, 'markerFaceColor', 'w');

orthoCenter = intersectLines(alt1, alt2);
drawPoint(orthoCenter, ...
    'marker', 'o', 'color', [0 0 .8], 'linewidth', 2, 'markerfacecolor', 'w');


%% Median rays and inscribed circle

% compute rays emanating from each vertex
ray1 = bisector(p2, p1, p3);
ray2 = bisector(p3, p2, p1);
ray3 = bisector(p1, p3, p2);

% draw rays (all in one call)
drawRay([ray1 ; ray2 ; ray3], 'color', [0 .5 0]);

% center of inscribed circle (assimilates rays to lines)
innerCircleCenter = intersectLines(ray1, ray2);

% radius of iscribed circle is computed as the distance to one of the sides
innerRadius = distancePointLine(innerCircleCenter, edge1);

% create the circle
innerCircle = [innerCircleCenter innerRadius];

% draw the inner circle
drawCircle(innerCircle, 'color', [0 .5 0], 'linewidth', 2);
drawPoint(innerCircleCenter, ...
    'color',  [0 .5 0], 'markerFaceColor', 'w', 'linewidth', 2);


%% Circumscribed circle

% edges midpoints
mid12 = midPoint(p1, p2);
mid13 = midPoint(p1, p3);
mid23 = midPoint(p2, p3);

% draw midpoints
midPoints = [mid12 ; mid13; mid23];
drawPoint(midPoints, 'marker', 's', 'color', 'r', 'linewidth', 2, 'markerFaceColor', 'w');

% perpendicular bisectors associated with each side
perp1 = orthogonalLine(edge1, mid23);
perp2 = orthogonalLine(edge2, mid13);
perp3 = orthogonalLine(edge3, mid12);

% draw perpendicular bisectors
drawLine([perp1 ; perp2 ; perp3], 'color', 'r');

% compute orthogonal circle
orthoCenter = intersectLines(perp1, perp2);
orthoRadius = distancePoints(orthoCenter, p1);

% draw Orthogonal center
drawCircle([orthoCenter orthoRadius], 'color', 'r', 'linewidth', 2);
drawPoint(orthoCenter, 'color', 'r', 'markerFaceColor', 'w', 'linewidth', 2);
