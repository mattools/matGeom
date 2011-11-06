function [inter inside]= intersectLinePolygon3d(line, poly)
%INTERSECTLINEPOLYGON3D Intersection point of a 3D line and a 3D polygon
%
%   INTER = intersectLinePolygon3d(LINE, POLY)
%   Compute coordinates of intersection point between the 3D line LINE and
%   the 3D polygon POLY. LINE is a 1-by-6 row vector containing origin and
%   direction vector of the line, POLY is a Np-by-3 array containing
%   coordinates of 3D polygon vertices.
%   INTER is a 1-by-3 row vector containing coordinates of intersection
%   point, or [NaN NaN NaN] if line and polygon do not intersect.
%
%   INTERS = intersectLinePolygon3d(LINES, POLY)
%   If LINES is a N-by-6 array representing several lines, the result
%   INTERS is a N-by-3 array containing coordinates of intersection of each
%   line with the polygon.
%
%   [INTER INSIDE] = intersectLinePolygon3d(LINE, POLY)
%   Also return a N-by-1 boolean array containing TRUE if the corresponding
%   polygon contains the intersection point.
%
%   Example
%     % Compute intersection between a 3D line and a 3D triangle
%     pts3d = [3 0 0; 0 6 0;0 0 9];
%     line1 = [0 0 0 3 6 9];
%     inter = intersectLinePolygon3d(line1, pts3d)
%     inter =
%           1   2   3
%
%     % keep only valid intersections with several lines
%     pts3d = [3 0 0; 0 6 0;0 0 9];
%     lines = [0 0 0 1 2 3;10 0 0 1 2 3];
%     [inter inside] = intersectLinePolygon3d(line1, pts3d);
%     inter(inside, :)
%     ans = 
%           1   2   3
%
%   See Also
%   intersectLinePlane, intersectRayPolygon3d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% supporting plane of polygon vertices
plane = createPlane(poly(1:3, :));

% intersection of 3D line with the plane
inter = intersectLinePlane(line, plane);

% project all points on reference plane
pts2d = planePosition(poly, plane);
pInt2d = planePosition(inter, plane);

% need to check polygon orientation
inside = xor(isPointInPolygon(pInt2d, pts2d), polygonArea(pts2d) < 0);

% intersection points outside the polygon are set to NaN
inter(~inside, :) = NaN;
