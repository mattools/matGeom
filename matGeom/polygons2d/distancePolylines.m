function dist = distancePolylines(poly1, poly2)
%DISTANCEPOLYLINES Compute the shortest distance between 2 polylines
%
%   DIST = distancePolylines(POLY1, POLY2)
%   POLY1 and POLY2 should be two polylines represented by their list of
%   vertices.
%
%
%   See also
%   polygons2d, distancePolygons, distancePointPolyline
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-17,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

% compute distance of each vertex of a polyline to the other polyline
dist1   = min(distancePointPolyline(poly1, poly2));
dist2   = min(distancePointPolyline(poly2, poly1));

% keep the minimum of the two distances
dist = min(dist1, dist2);
