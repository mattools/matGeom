function varargout = projPointOnPolygon(point, poly, varargin)
%PROJPOINTONPOLYGON  Compute position of a point projected on a polygon
%
%   POS = projPointOnPolygon(POINT, POLYGON)
%   Compute the position of the orthogonal projection of a point on a
%   polygon.
%   POINT is a 1-by-2 row vector containing point coordinates
%   POLYGON is a N-by-2 array containing coordinates of polygon vertices
%
%   When POINT is an array of points, returns a column vector with as many
%   rows as the number of points. 
%
%   [POS, DIST] = projPointOnPolygon(...)
%   Also returns the distance between POINT and POLYGON. The distance is
%   negative if the point is located inside of the polygon.
%
%   Example
%     poly = [10 10; 20 10;20 20;10 20];
%     projPointOnPolygon([15 0], poly)
%     ans =
%         0.5000
%     projPointOnPolygon([0 16], poly)
%     ans =
%         3.4000
%
%   See also
%   points2d, polygons2d, polygonPoint, projPointOnPolyline
%   distancePointpolygon
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

% compute position wrt outline
[pos, minDist] = projPointOnPolyline(point, poly);

% process output arguments
if nargout <= 1
    varargout{1} = pos;
elseif nargout == 2
    varargout{1} = pos;
    if inpolygon(point(:,1), point(:,2), poly(:,1), poly(:,2))
        minDist = -minDist;
    end
    varargout{2} = minDist;
end