function varargout = rectToPolygon(rect)
%RECTTOPOLYGON Convert a rectangle into a polygon (set of vertices)
%
%   POLY = rectToPolygon(RECT);
%   Converts rectangle given as [x0 y0 w h] or [x0 y0 w h theta] into a
%   4*2 array double, containing coordinate of rectangle vertices.
%
%   See also:
%   orientedBoxToPolygon, ellipseToPolygon, drawRect, drawPolygon
%
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/04/2005.
%

%   HISTORY

% extract rectangle parameters
theta = 0;
x0  = rect(1);
y0  = rect(2);
w   = rect(3);
h   = rect(4);
if length(rect) > 4
    theta = rect(5);
end

% precompute angular quantities
cot = cosd(theta);
sit = sind(theta);

% compute vertex coordinates
tx = zeros(4, 1);
ty = zeros(4, 1);
tx(1) = x0;
ty(1) = y0;
tx(2) = x0 + w * cot;
ty(2) = y0 + w * sit;
tx(3) = x0 + w * cot - h * sit;
ty(3) = y0 + w * sit + h * cot;
tx(4) = x0 - h * sit;
ty(4) = y0 + h * cot;

% format output
if nargout <= 1
    varargout = {[tx ty]};
else
    varargout = {tx, ty};
end
