function b = isLeftOriented(point, line)
%ISLEFTORIENTED Test if a point is on the left side of a line
%
%   B = isLeftOriented(POINT, LINE);
%   Returns TRUE if the point lies on the left side of the line with
%   respect to the line direction.
%
%   See also:
%   lines2d, points2d, isCounterClockwise, isPointOnLine, distancePointLine
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/07/2005.
%

Nl = size(line, 1);
Np = size(point, 1);

x0 = repmat(line(:,1)', Np, 1);
y0 = repmat(line(:,2)', Np, 1);
dx = repmat(line(:,3)', Np, 1);
dy = repmat(line(:,4)', Np, 1);
xp = repmat(point(:,1), 1, Nl);
yp = repmat(point(:,2), 1, Nl);


b = (xp-x0).*dy-(yp-y0).*dx < 0;