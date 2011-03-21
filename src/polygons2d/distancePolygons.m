function dist = distancePolygons(poly1, poly2)
%DISTANCEPOLYGONS Compute the shortest distance between 2 polygons
%   DIST = distancePolygons(POLY1, POLY2)
%
%   Example
%   distancePolygons
%
%   See also
%
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