function b = isPointInTriangle(point, p1, p2, p3)
%ISPOINTINTRIANGLE Test if a point is located inside a triangle
%
%   B = isPointInTriangle(POINT, V1, V2, V3)
%   POINT is a 1-by-2 row vector containing coordinates of the test point,
%   V1, V2 and V3 are 1-by-2 row vectors containing coordinates of triangle
%   vertices. The function returns 1 is the point is inside or on the
%   boundary of the triangle, and 0 otherwise.
%
%   B = isPointInTriangle(POINT, VERTICES)
%   Specifiy the coordinates of vertices as a 3-by-2 array.
%
%   If POINT contains more than one row, the result B has as many rows as
%   the input POINT.
%
%
%   Example
%     % vertices of the triangle
%     p1 = [0 0];
%     p2 = [10 0];
%     p3 = [5 10];
%     tri = [p1;p2;p3];
%     % check if points are inside
%     isPointInTriangle([0 0], tri)
%     ans =
%         1
%     isPointInTriangle([5 5], tri)
%     ans =
%         1
%     isPointInTriangle([10 5], tri)
%     ans =
%         0
%     % check for an array of points
%     isPointInTriangle([0 0;1 0;0 1], tri)
%     ans =
%         1
%         1
%         0
%
%   See also
%   polygons2d, isPointInPolygon, isCounterClockwise
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-16,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% if triangle vertices are given as a single array, extract vertices
if nargin == 2
    p2 = p1(2, :);
    p3 = p1(3, :);
    p1 = p1(1, :);
end

% check triangle orientation
isDirect = isCounterClockwise(p1, p2, p3);

% check location of point with respect to each side
if isDirect
    b12 = isCounterClockwise(p1, p2, point) >= 0;
    b23 = isCounterClockwise(p2, p3, point) >= 0;
    b31 = isCounterClockwise(p3, p1, point) >= 0;
else
    b12 = isCounterClockwise(p1, p2, point) <= 0;
    b23 = isCounterClockwise(p2, p3, point) <= 0;
    b31 = isCounterClockwise(p3, p1, point) <= 0;
end

% combines the 3 results
b = b12 & b23 & b31;

