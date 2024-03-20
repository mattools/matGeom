function b = onCircle(point, circle)
%ONCIRCLE test if a point is located on a given circle.
%
%   B = onCircle(POINT, CIRCLE) 
%   return true if point is located on the circle
%
%   Example :
%   onCircle([1 0], [0 0 1])
%   returns true, whereas
%   onCircle([1 1], [0 0 1])
%   return false
%
%   See also:
%   circles2d, inCircle

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2004-04-07
% Copyright 2004 INRA - TPV URPOI - BIA IMASTE

% deprecation warning
warning('geom2d:deprecated', ...
    '''onCircle'' is deprecated, use ''isPointOnCircle'' instead');

d = sqrt(sum(power(point - circle(:,1:2), 2), 2));
b = abs(d-circle(:,3))<1e-12;
