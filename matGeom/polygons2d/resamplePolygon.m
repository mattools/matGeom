function poly2 = resamplePolygon(poly, n)
%RESAMPLEPOLYGON  Distribute N points equally spaced on a polygon
%
%   POLY2 = resamplePolygon(POLY, N)
%   Resample the input polygon POLY such that the resulting polygon POLY2
%   has N vertices. All points of POLY2 belong to the initial polygon, but
%   are not necessarily vertices of the original polygon.
%
%
%   Example
%     % creates a polygon from an ellipse
%     elli = [20 30 40 20 30];
%     poly = ellipseToPolygon(elli, 500);
%     figure; drawPolygon(poly, 'b');
%     % resample the polygon with a fixed number of vertices
%     poly2 = resamplePolygon(poly, 20);
%     drawPolygon(poly2, 'm');
%     drawPoint(poly2, 'mo');
%     axis equal; axis([-20 60 0 60]);
%
%   See also
%     polygons2d, resamplePolygonByLength, smoothPolygon, resamplePolyline
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-12-09,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

poly2 = resamplePolyline(poly([1:end 1],:), n+1);
poly2(end, :) = [];
