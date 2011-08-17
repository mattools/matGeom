function poly2 = clipConvexPolygon3dHP(poly, plane)
%CLIPCONVEXPOLYGON3DHP Clip a convex 3D polygon with Half-space
%
%   POLY2 = clipConvexPolygon3dHP(POLY, PLANE)
%   POLY is a N-by-3 array of points, and PLANE is given as:
%   [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2].
%   The result POLY2 is also an array of 3d points, sometimes smaller than
%   poly, and that can be 0-by-3 (empty polygon).
%
%   POLY2 = clipConvexPolygon3dHP(POLY, PT0, NORMAL)
%   uses plane with normal NORMAL and containing point PT0.
%
%
%   See also:
%   polygons3d, polyhedra
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-01-05
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

%   HISTORY
%   2007/14/09 fix postprocessing of last point

% ensure last point is the same as the first one
if sum(poly(end, :) == poly(1,:)) ~= 3
    poly = [poly; poly(1,:)];
end

% initialize empty polygon
poly2 = zeros(0, 2);

% compute visible points
below = isBelowPlane(poly, plane);

% case of empty polygon
if sum(below) == 0
    return;
end

% case of totally clipped polygon
if sum(below) == length(below)
    poly2 = poly;
    return;
end

% indices of edges intersecting the plane
ind = find(below ~= below([2:end 1]));

% compute intersection points: they are 2 for a convex polygon
lines = createLine3d(poly(ind, :), poly(ind+1, :));
pInt = intersectLinePlane(lines, plane);

% insert intersection points and remove invisible points
if below(1)
    poly2 = [poly(1:ind(1), :); pInt; poly(ind(2)+1:end, :)];
else
    poly2 = [pInt(1, :); poly(ind(1)+1:ind(2), :); pInt(2, :)];
end

% remove last point if it is the same as the first one
if sum(poly2(end, :) == poly2(1,:)) == 3
    poly2(end, :) = [];
end

