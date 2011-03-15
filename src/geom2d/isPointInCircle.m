function b = isPointInCircle(point, circle, varargin)
%ISPOINTINCIRCLE Test if a point is located inside a given circle
%
%   B = isPointInCircle(POINT, CIRCLE) 
%   Returns true if point is located inside the circle, i.e. if distance to
%   circle center is lower than the circle radius.
%
%   B = isPointInCircle(POINT, CIRCLE, TOL) 
%   Specifies the tolerance value
%
%   Example:
%   isPointInCircle([1 0], [0 0 1])
%   isPointInCircle([0 0], [0 0 1])
%   returns true, whereas
%   isPointInCircle([1 1], [0 0 1])
%   return false
%
%   See also:
%   circles2d, isPointOnCircle
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 07/04/2004.
%

%   HISTORY
%   22/05/2009 rename to isPointInCircle, add psb to specify tolerance

% extract computation tolerance
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

d = sqrt(sum(power(point - circle(:,1:2), 2), 2));
b = d-circle(:,3)<=tol;
    