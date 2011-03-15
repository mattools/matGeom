function b = isPointOnCircle(point, circle, varargin)
%ISPOINTONCIRCLE Test if a point is located on a given circle.
%
%   B = isPointOnCircle(POINT, CIRCLE) 
%   return true if point is located on the circle, i.e. if the distance to
%   the circle center equals the radius up to an epsilon value.
%
%   B = isPointOnCircle(POINT, CIRCLE, TOL) 
%   Specifies the tolerance value.
%
%   Example:
%   isPointOnCircle([1 0], [0 0 1])
%   returns true, whereas
%   isPointOnCircle([1 1], [0 0 1])
%   return false
%
%   See also:
%   circles2d, isPointInCircle
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 07/04/2004.
%

%   HISTORY
%   22/05/2009 rename to isPointOnCircle, add psb to specify tolerance

tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

d = sqrt(sum(power(point - circle(:,1:2), 2), 2));
b = abs(d-circle(:,3))<tol;
    