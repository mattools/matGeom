function b = isLeftOriented(point, line)
%ISLEFTORIENTED Test if a point is on the left side of a line
%
%   B = isLeftOriented(POINT, LINE);
%   Returns TRUE if the point lies on the left side of the line with
%   respect to the line direction.
%   
%   If POINT is a NP-by-2 array, and/or LINE is a NL-by-4 array, the result
%   is a NP-by-NL array containing the result for each point-line
%   combination.
%
%   See also:
%   lines2d, points2d, isCounterClockwise, isPointOnLine, distancePointLine
%

%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/07/2005.

%   HISTORY
%   2017-09-04 uses bsxfun

% equivalent to:
% b = (xp-x0).*dy-(yp-y0).*dx < 0;
b = bsxfun(@minus, ...
    bsxfun(@times, bsxfun(@minus, point(:,1), line(:,1)'), line(:,4)'), ...
    bsxfun(@times, bsxfun(@minus, point(:,2), line(:,2)'), line(:,3)')) < 0;
    