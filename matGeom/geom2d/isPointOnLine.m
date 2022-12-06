function b = isPointOnLine(point, line, varargin)
%ISPOINTONLINE Test if a point belongs to a line.
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
%   Specifies the tolerance used for testing location on 3D line. Default value is 1e-14.
%
%   See also 
%   lines2d, points2d, isPointOnEdge, isPointOnRay, isLeftOriented
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-10-31
% Copyright 2003-2022 INRA - TPV URPOI - BIA IMASTE

% extract computation tolerance
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% test if lines are colinear, using third coordinate of 3D cross-product
% same test as:
% b = abs((xp-x0).*dy-(yp-y0).*dx)./hypot(dx, dy).^2 < tol;
b = bsxfun(...
    @rdivide, abs(...
    bsxfun(@times, bsxfun(@minus, point(:,1), line(:,1)'), line(:,4)') - ...
    bsxfun(@times, bsxfun(@minus, point(:,2), line(:,2)'), line(:,3)')), ...
    (line(:,3).^2 + line(:,4).^2)') < tol;

