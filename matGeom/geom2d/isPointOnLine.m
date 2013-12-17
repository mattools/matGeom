function b = isPointOnLine(point, line, varargin)
%ISPOINTONLINE Test if a point belongs to a line
%
%   B = isPointOnLine(POINT, LINE)
%   with POINT being [xp yp], and LINE being [x0 y0 dx dy].
%   Returns 1 if point lies on the line, 0 otherwise.
%
%   If POINT is an N-by-2 array of points, B is a N-by-1 array of booleans.
%
%   If LINE is a N-by-4 array of line, B is a 1-by-N array of booleans.
%
%   B = isPointOnLine(POINT, LINE, TOL)
%   Specifies the tolerance used for testing location on 3D line.
%
%   See also: 
%   lines2d, points2d, isPointOnEdge, isPointOnRay, angle3Points
%
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
%   17/12/2013 replace repmat by bsxfun (faster)

% extract computation tolerance
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% test if lines are colinear, using third coordinate of 3D cross-product
% same test as:
% b = abs((xp-x0).*dy-(yp-y0).*dx)./hypot(dx, dy) < tol;
b = bsxfun(...
    @rdivide, abs(...
    bsxfun(@times, bsxfun(@minus, point(:,1), line(:,1)'), line(:,4)') - ...
    bsxfun(@times, bsxfun(@minus, point(:,2), line(:,2)'), line(:,3)')), ...
    hypot(line(:,3)', line(:,4)')) < tol;

