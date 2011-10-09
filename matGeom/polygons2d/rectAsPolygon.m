function varargout = rectAsPolygon(rect)
%RECTASPOLYGON Convert a (centered) rectangle into a series of points
%
%   P = rectAsPolygon(RECT);
%   Converts rectangle given as [x0 y0 w h] or [x0 y0 w h theta] into a
%   4*2 array double, containing coordinate of rectangle vertices.
%
%   See also:
%   polygons2d, drawRect, drawOrientedBox, drawPolygon
%
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/04/2005.
%

%   HISTORY

theta = 0;
x = rect(1);
y = rect(2);
w = rect(3)/2;  % easier to compute with w and h divided by 2
h = rect(4)/2;
if length(rect)>4
    theta = rect(5);
end

cot = cos(theta);
sit = sin(theta);

tx(1) = x - w*cot + h*sit;
ty(1) = y - w*sit - h*cot;
tx(2) = x + w*cot + h*sit;
ty(2) = y + w*sit - h*cot;
tx(3) = x + w*cot - h*sit;
ty(3) = y + w*sit + h*cot;
tx(4) = x - w*cot - h*sit;
ty(4) = y - w*sit + h*cot;


if nargout==1
    varargout{1}=[tx' ty'];
elseif nargout==2
    varargout{1}=tx';
    varargout{2}=ty';    
end