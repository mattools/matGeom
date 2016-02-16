function [tx, ty] = rectAsPolygon(rect)
%RECTASPOLYGON Convert a (centered) rectangle into a series of points
%
%   deprecated: replaced by rectToPolygon
%
%   POLY = rectAsPolygon(RECT);
%   Converts rectangle given as [X0 Y0 W H] or [X0 Y0 W H THETA] into a
%   4-by-2 array double, containing coordinate of rectangle vertices.
%   X0 and Y0 represents t
%
%   [PX, PY] = rectAsPolygon(RECT);
%   Returns the coordinates of the rectangle as two arrays.
%
%   See also:
%   polygons2d, drawRect, drawOrientedBox, drawPolygon
%

% ---------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% INRA - TPV URPOI - BIA IMASTE
% created the 06/04/2005.
%

%   HISTORY
%   2016: Simplify by JuanPi Carbajal

warning('matGeom:deprecated', ...
    'function "rectAsPolygon" is deprecated, use "orientedBoxToPolygon" instead');

theta = 0;
x     = rect(1);
y     = rect(2);
w     = rect(3) / 2;  % easier to compute with w and h divided by 2
h     = rect(4) / 2;
if length(rect) > 4
  theta = rect(5);
end

v = [cos(theta); sin(theta)];
M = bsxfun (@times, [-1 1; 1 1; 1 -1; -1 -1], [w h]);
tx  = x + M * v;
ty  = y + M(4:-1:1,[2 1]) * v;

if nargout <= 1
  tx = [tx ty];
end
