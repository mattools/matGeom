function varargout = drawRect2(varargin)
%DRAWRECT2 Draw centered rectangle on the current axis
%   
%   r = drawRect2(x, y, w, h) draw rectangle with width W and height H,
%   whose center is located at (x, y);
%
%   The four corners of rectangle are then :
%   (X-W/2, Y-H/2), (X+W/2, Y-H/2), (X+W/2, Y+H/2), (X-W/2, Y+H/2).
%
%   r = drawRect2(x, y, w, h, theta) also specifies orientation for
%   rectangle. Theta is given in radians.
%
%   r = drawRect2(coord) is the same as DRAWRECT2(X,Y,W,H), but all
%   parameters are packed into one array, whose dimensions is 4*1 or 5*1.
%
%   deprecated: use 'drawOrientedBox' instead
%
%   See Also :
%   drawRect
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 04/05/2004.
%

warning('polygons2d:deprecated', ...
    'This function is deprecated, use "drawOrientedBox" instead');

% default values
theta = 0;

% get entered values
if length(varargin)>3
    x = varargin{1};
    y = varargin{2};
    w = varargin{3};
    h = varargin{4};
    if length(varargin)>4
        theta = varargin{5};
    end
else
    coord = varargin{1};
    x = coord(:, 1);
    y = coord(:, 2);
    w = coord(:, 3);
    h = coord(:, 4);
    
    if length(coord)>4
        theta = coord(:, 5);
    else
        theta = zeros(size(x));
    end
end

% use only the half length of each rectanhle
w = w/2;
h = h/2;

hr = zeros(length(x), 1);
for i=1:length(x)
    tx = zeros(5, 1);
    ty = zeros(5, 1);
    
    tx(1) = x(i) - w(i)*cos(theta(i)) + h(i)*sin(theta(i));
    ty(1) = y(i) - w(i)*sin(theta(i)) - h(i)*cos(theta(i));
    
    tx(2) = x(i) + w(i)*cos(theta(i)) + h(i)*sin(theta(i));
    ty(2) = y(i) + w(i)*sin(theta(i)) - h(i)*cos(theta(i));
    
    tx(3) = x(i) + w(i)*cos(theta(i)) - h(i)*sin(theta(i));
    ty(3) = y(i) + w(i)*sin(theta(i)) + h(i)*cos(theta(i));
    
    tx(4) = x(i) - w(i)*cos(theta(i)) - h(i)*sin(theta(i));
    ty(4) = y(i) - w(i)*sin(theta(i)) + h(i)*cos(theta(i));
    
    tx(5) = x(i) - w(i)*cos(theta(i)) + h(i)*sin(theta(i));
    ty(5) = y(i) - w(i)*sin(theta(i)) - h(i)*cos(theta(i));
    
    hr(i) = line(tx, ty);
end

if nargout > 0
    varargout{1} = hr;
end
