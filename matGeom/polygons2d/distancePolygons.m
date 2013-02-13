function dist = distancePolygons(poly1, poly2)
%DISTANCEPOLYGONS Compute the shortest distance between 2 polygons
%
%   DIST = distancePolygons(POLY1, POLY2)
%   Computes the shortest distance between the boundaries of the two
%   polygons. Each polygon is given by a N-by-2 array containing the vertex
%   coordinates.
%
%   Example
%     % Computes the distance between a square and a triangle
%     poly1 = [10 10;20 10;20 20;10 20];
%     poly2 = [30 20;50 20;40 45];
%     distancePolygons(poly1, poly2)
%     ans =
%         10
%
%   See also
%   polygons2d, distancePolylines, distancePointPolygon
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-17,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

% compute distance of each vertex of a polygon to the other polygon
dist1   = min(distancePointPolygon(poly1, poly2));
dist2   = min(distancePointPolygon(poly2, poly1));

% keep the minimum of the two distances
dist = min(dist1, dist2);