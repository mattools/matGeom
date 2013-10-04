function varargout = distancePointPolygon(point, poly)
%DISTANCEPOINTPOLYGON Shortest distance between a point and a polygon
%
%   DIST = distancePointPolygon(POINT, POLYGON)
%   Computes the shortest distance between the point POINT and the polygon
%   given by POLYGON. POINT is a 1-by-2 row vector, and POLYGON is a N-by-2
%   array containing vertex coordinates.
%   The distance is computed as the minimal distance to the boundary edges.
%
%   Example
%     % Computes the distance between a point and a square
%     square = [0 0; 10 0;10 10;0 10];
%     p0 = [16 3];
%     distancePointPolygon(p0, square)
%     ans =
%          6
%
%   See also
%   polygons2d, points2d, distancePointPolyline, distancePointEdge,
%   projPointOnPolyline
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-30,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

% eventually copy first point at the end to ensure closed polygon
if sum(poly(end, :) == poly(1,:)) ~= 2
    poly = [poly; poly(1,:)];
end

% call to distancePointPolyline 
minDist = distancePointPolyline(point, poly);

% process output arguments
if nargout <= 1
    varargout{1} = minDist;
end
