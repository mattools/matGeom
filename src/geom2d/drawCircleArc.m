function varargout = drawCircleArc(varargin)
%DRAWCIRCLEARC draw a circle arc on the current axis
%
%   drawCircleArc(XC, YC, R, START, EXTENT);
%   Draws circle with center (XC, YC), with radius R, starting from angle
%   START, and with angular extent given by EXTENT.
%
%   drawCircleArc(PARAM);
%   Puts all parameters into one single array.
%
%   H = drawCircleArc(...);
%   Returns a handle to the created line object.
%
%   See also:
%   circles2d, drawCircle, drawEllipse
%
%   --------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 12/12/2003.
%

%   HISTORY
%   03/05/2004: angles are given as radians
%   27/06/2007: Now uses angle extent


if length(varargin)==1
    circle = varargin{1};
    x0 = circle(1);
    y0 = circle(2);
    r  = circle(3);
    t1 = circle(4);
    t2 = circle(5);
elseif length(varargin)==5
    x0 = varargin{1};
    y0 = varargin{2};
    r  = varargin{3};
    t1 = varargin{4};
    t2 = varargin{5};
else
    error('drawCircleArc : please specify center (x and y), radius, start angle and extent');
end

% initialize handles vector and position array
h   = zeros(length(x0), 1);
t   = linspace(t1, t1+t2, 60);

for i=1:length(x0)
    xt = x0(i) + r(i)*cos(t);
    yt = y0(i) + r(i)*sin(t);
    
    h(i) = line(xt, yt);
end

if nargout>0
    varargout{1}=h;
end