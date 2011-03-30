function poly2 = polygonExpand(polygon, dist)
%POLYGONEXPAND 'expand' a polygon with a given distance
%
%   EXPOLY = polygonExpand(POLYGON, D);
%   Associates each edge of POLYGON to an edge located at distance D, and
%   computes polygon given by growing edges. 
%   This is a kind of dilatation, but behaviour on corners is different.
%   This function keeps angles of polygons, but there is no direct relation
%   between length of 2 polygons.
%
%   It works fine for convex polygons, or for polygons whose complexity is
%   not too high (self intersection of result polygon is not tested).
%
%   It is also possible to specify negative distance, and get all points
%   inside the polygon. If the polygon is convex, the result equals
%   morphological erosion of polygon by a ball with radius equal to the
%   given distance.
%
%   See also:
%   polygons2d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 14/05/2005.
%

%   HISTORY :
%   31/07/2005 : change algo for negative distance : use clipping of
%   polygon by half-planes
%   17/06/2009 deprecate

% deprecation warning
warning('geom2d:deprecated', ...
    '''polygonExpand'' is deprecated, use ''expandPolygon'' instead');

% eventually copy first point at the end
if sum(polygon(end, :)==polygon(1,:))~=2
    polygon = [polygon; polygon(1,:)];
end

% number of vertics of polygon
N = size(polygon, 1)-1;

% find lines parallel to polygon edges with distance DIST
line = zeros(N, 4);
for i=1:N
    side = createLine(polygon(i,:), polygon(i+1,:));
    %perp = orthogonalLine(side, polygon(i,:));
    %pts2 = pointOnLine(perp, -dist);
    line(i, 1:4) = parallelLine(side, -dist);
end


if dist>0
    % compute intersection points of consecutive lines
    line = [line;line(1,:)];
    poly2 = zeros(N, 2);
    for i=1:N
        poly2(i,1:2) = intersectLines(line(i,:), line(i+1,:));
    end
else
    poly2 = polygon;
    % clip polygon with all lines parallel to edges
    for i=1:N
        poly2 = clipPolygonHP(poly2, line(i,:));
    end
end
