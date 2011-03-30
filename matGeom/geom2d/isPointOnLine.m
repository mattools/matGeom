function b = isPointOnLine(point, line, varargin)
%ISPOINTONLINE Test if a point belongs to a line
%
%   B = isPointOnLine(POINT, LINE)
%   with POINT being [xp yp], and LINE being [x0 y0 dx dy].
%   Returns 1 if point lies on the line, 0 otherwise.
%
%   If POINT is an N*2 array of points, B is a N*1 array of booleans.
%
%   If LINE is a N*4 array of line, B is a 1*N array of booleans.
%
%   See also: 
%   lines2d, points2d, isPointOnEdge, isPointOnRay, angle3Points
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

%   HISTORY
%   11/03/2004 support for multiple inputs
%   08/12/2004 complete implementation, add doc
%   22/05/2009 rename to isPointOnLine, add psb to specify tolerance

% extract computation tolerance
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% number of lines and of points
Nl = size(line, 1);
Np = size(point, 1);

% adapt the size of inputs
x0 = repmat(line(:,1)', Np, 1);
y0 = repmat(line(:,2)', Np, 1);
dx = repmat(line(:,3)', Np, 1);
dy = repmat(line(:,4)', Np, 1);
xp = repmat(point(:,1), 1, Nl);
yp = repmat(point(:,2), 1, Nl);

% test if lines are colinear
b = abs((xp-x0).*dy-(yp-y0).*dx)./hypot(dx, dy) < tol;















