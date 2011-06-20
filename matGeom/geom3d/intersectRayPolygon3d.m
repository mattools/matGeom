function [inter inside]= intersectRayPolygon3d(ray, poly)
%INTERSECTRAYPOLYGON3D Intersection point of a 3D ray and a 3D polygon
%
%   INTER = intersectRayPolygon3d(RAY, POLY)
%   Compute coordinates of intersection point between the 3D ray RAY and
%   the 3D polygon POLY. RAY is a 1-by-6 row vector containing origin and
%   direction vector of the ray, POLY is a Np-by-3 array containing
%   coordinates of 3D polygon vertices.
%   INTER is a 1-by-3 row vector containing coordinates of intersection
%   point, or [NaN NaN NaN] if ray and polygon do not intersect.
%
%   INTERS = intersectRayPolygon3d(RAYS, POLY)
%   If RAYS is a N-by-6 array representing several rays, the result
%   INTERS is a N-by-3 array containing coordinates of intersection of each
%   ray with the polygon.
%
%   [INTER INSIDE] = intersectRayPolygon3d(RAY, POLY)
%   Also return a N-by-1 boolean array containing TRUE if both the polygon
%   and the corresponding ray contain the intersection point.
%
%   Example
%     % Compute intersection between a 3D ray and a 3D triangle
%     pts3d = [3 0 0; 0 6 0;0 0 9];
%     ray1 = [0 0 0 3 6 9];
%     inter = intersectRayPolygon3d(ray1, pts3d)
%     inter =
%           1   2   3
%
%     % keep only valid intersections with several rays
%     pts3d = [3 0 0; 0 6 0;0 0 9];
%     rays = [0 0 0 3 6 9;10 0 0 1 2 3;3 6 9 3 6 9];
%     [inter inside] = intersectRayPolygon3d(rays, pts3d);
%     inter(inside, :)
%     ans = 
%           1   2   3
%
%   See Also
%   intersectLinePlane, intersectLinePolygon3d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% supporting plane of polygon vertices
plane   = createPlane(poly(1:3, :));

% intersection of 3D ray with the plane
inter   = intersectLinePlane(ray, plane);

% project all points on reference plane
pts2d   = projPointOnPlane(poly, plane);
pInt2d  = projPointOnPlane(inter, plane);

% need to check polygon orientation
inPoly  = xor(isPointInPolygon(pInt2d, pts2d), polygonArea(pInt2d) < 0);
onRay   = linePosition3d(inter, ray) >= 0;
inside  = inPoly & onRay;

% intersection points outside the polygon are set to NaN
inter(~inside, :) = NaN;
