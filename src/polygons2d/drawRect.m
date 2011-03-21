function varargout = drawRect(varargin)
%DRAWRECT Draw rectangle on the current axis
%   
%   r = DRAWRECT(x, y, w, h) draw rectangle with width W and height H, at
%   position (X, Y).
%   the four corners of rectangle are then :
%   (X, Y), (X+W, Y), (X, Y+H), (X+W, Y+H).
%
%   r = DRAWRECT(x, y, w, h, theta) also specifies orientation for
%   rectangle. Theta is given in degrees.
%
%   r = DRAWRECT(coord) is the same as DRAWRECT(X,Y,W,H), but all
%   parameters are packed into one array, whose dimensions is 4*1 or 5*1.
%
%
%   See Also:
%   drawRect2, drawBox
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 10/12/2003.
%

% HISTORY :
% 12/12/2003 : add support for multiple rectangles


% default values
theta = 0;

% get entered values
if length(varargin)>3
    x = varargin{1};
    y = varargin{2};
    w = varargin{3};
    h = varargin{4};
    if length(varargin)>4
        theta = varargin{5}*pi/180;
    end
else
    coord = varargin{1};
    x = coord(1);
    y = coord(2);
    w = coord(3);
    h = coord(4);
    if length(coord)>4
        theta = coord(5)*pi/180;
    end
end

r = zeros(size(x));
for i=1:length(x)
    tx = zeros(5, 1);
    ty = zeros(5, 1);
    tx(1) = x(i);
    ty(1) = y(i);
    tx(2) = x(i) + w(i)*cos(theta(i));
    ty(2) = y(i) + w(i)*sin(theta(i));
    tx(3) = x(i) + w(i)*cos(theta(i)) - h(i)*sin(theta(i));
    ty(3) = y(i) + w(i)*sin(theta(i)) + h(i)*cos(theta(i));
    tx(4) = x(i) - h(i)*sin(theta(i));
    ty(4) = y(i) + h(i)*cos(theta(i));
    tx(5) = x(i);
    ty(5) = y(i);

    r(i) = line(tx, ty);
end

if nargout>0
    varargout{1}=r;
end