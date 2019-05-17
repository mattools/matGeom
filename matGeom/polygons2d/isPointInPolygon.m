function b = isPointInPolygon(point, poly)
%ISPOINTINPOLYGON Test if a point is located inside a polygon.
%
%   B = isPointInPolygon(POINT, POLYGON)
%   Returns true if the point is located within the given polygon.
%
%   This function is simply a wrapper for the function inpolygon, to avoid
%   decomposition of point and polygon coordinates.
%
%   Example
%     pt1 = [30 20];
%     pt2 = [30 5];
%     poly = [10 10;50 10;50 50;10 50];
%     isPointInPolygon([pt1;pt2], poly)
%     ans =
%          1
%          0
%
%     poly = [0 0; 10 0;10 10;0 10;NaN NaN;3 3;3 7;7 7;7 3];
%     pts = [5 1;5 4];
%     isPointInPolygon(pts, poly);
%     ans =
%          1
%          0
%
%
%   See also
%   points2d, polygons2d, inpolygon, isPointInTriangle

%
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2009-06-19,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

%   HISTORY
%   2013-04-24 add support for multiply connected polygons

% In case of a multiple polygon, decompose into a set of contours, and
% performs test for each contour
if iscell(poly) || any(isnan(poly(:)))
    % transform as a cell array of simple polygons
    polygons = splitPolygons(poly);
    N = length(polygons);
    Np = size(point, 1);
    
    % compute orientation of polygon, and format to have Np*N matrix
    areas = zeros(N, 1);
    for i = 1:N
        areas(i) = polygonArea(polygons{i});
    end
    ccw = areas > 0;
    ccw = repmat(ccw', Np, 1);
    
    % test if point inside each polygon
    in = false(size(point, 1), N);
    for i = 1:N
        poly = polygons{i};
        in(:, i) = inpolygon(point(:,1), point(:,2), poly(:,1), poly(:,2));
    end
    
    % count polygons containing point, weighted by polygon orientation
    b = sum(in.*(ccw==1) - in.*(ccw==0), 2) > 0;

else
    % standard test for simple polygons
    b = inpolygon(point(:,1), point(:,2), poly(:,1), poly(:,2));
end
