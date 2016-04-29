function b = onEdge(point, edge)
%ONEDGE test if a point belongs to an edge
%
%   B = onEdge(POINT, EDGE)
%   with POINT being [xp yp], and EDGE being [x1 y1 x2 y2].
%
%   See also:
%   edges2d, points2d, onLine
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

% HISTORY
% 11/03/2004 : change input format : edge is [x1 y1 x2 y2].
% 17/01/2005 : if test N edges with N points, return N boolean.
% 21/01/2005 : normalize test for colinearity, so enhance precision
%   22/05/2009 deprecate

% deprecation warning
warning('geom2d:deprecated', ...
    '''onEdge'' is deprecated, use ''isPointOnEdge'' instead');

Np = size(point, 1);
Ne = size(edge, 1);

if Np==1 || Ne==1
    x0 = repmat(edge(:,1)', Np, 1);
    y0 = repmat(edge(:,2)', Np, 1);
    dx = repmat(edge(:,3)', Np, 1)-x0;
    dy = repmat(edge(:,4)', Np, 1)-y0;
    xp = repmat(point(:,1), 1, Ne);
    yp = repmat(point(:,2), 1, Ne);
elseif Np==Ne
    x0 = edge(:,1);
    y0 = edge(:,2);
    dx = edge(:,3)-x0;
    dy = edge(:,4)-y0;
    xp = point(:,1);
    yp = point(:,2);
    
end


% test if lines are colinear
b1 = abs((xp-x0).*dy - (yp-y0).*dx)./(dx.*dx+dy.*dy)<1e-13;

ind  = abs(dx)>abs(dy);
t = zeros(max(Np, Ne), 1);
t(ind) = (xp(ind)-x0(ind))./dx(ind);
t(~ind) = (yp(~ind)-y0(~ind))./dy(~ind);
b = t>-1e-14 & t-1<1e-14 & b1;




