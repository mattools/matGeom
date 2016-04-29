function b = inCircle(point, circle)
%INCIRCLE test if a point is located inside a given circle.
%
%   B = inCircle(POINT, CIRCLE) 
%   return true if point is located inside the circle
%
%   Example:
%   inCircle([1 0], [0 0 1])
%   inCircle([0 0], [0 0 1])
%   returns true, whereas
%   inCircle([1 1], [0 0 1])
%   return false
%
%   See also:
%   circles2d, onCircle
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 07/04/2004.
%

%   HISTORY
%   22/05/2009 deprecate

% deprecation warning
warning('geom2d:deprecated', ...
    '''inCircle'' is deprecated, use ''isPointInCircle'' instead');

d = sqrt(sum(power(point - circle(:,1:2), 2), 2));
b = d-circle(:,3)<=1e-12;
    