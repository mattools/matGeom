function b = isPointInPolygon(point, poly)
%ISPOINTINPOLYGON Test if a point is located inside a polygon
%
%   B = isPointInPolygon(POINT, POLYGON)
%   Returns true if the point is located within the given polygon.
%
%   This function is simply a wrapper for the function inpolygon, to avoid
%   decomposition of point and polygon coordinates.
%
%   Example
%   pt1 = [30 20];
%   pt2 = [30 5];
%   poly = [10 10;50 10;50 50;10 50];
%   isPointInPolygon([pt1;pt2], poly)
%   ans =
%        1
%        0
%
%   See also
%   points2d, polygons2d, inpolygon, isPointInTriangle

%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-19,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

b = inpolygon(point(:,1), point(:,2), poly(:,1), poly(:,2));