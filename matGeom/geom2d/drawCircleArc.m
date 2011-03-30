function varargout = drawCircleArc(varargin)
%DRAWCIRCLEARC Draw a circle arc on the current axis
%
%   drawCircleArc(XC, YC, R, START, EXTENT);
%   Draws circle with center (XC, YC), with radius R, starting from angle
%   START, and with angular extent given by EXTENT. START and EXTENT angles
%   are given in degrees.
%
%   drawCircleArc(CIRCLE);
%   Puts all parameters into one single array.
%
%   H = drawCircleArc(...);
%   Returns a handle to the created line object.
%
%   See also:
%   circles2d, drawCircle, drawEllipse
%
%   --------
%   author: David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 12/12/2003.
%

%   HISTORY
%   2004-05-03 angles are given as radians
%   2007-06-27 Now uses angle extent
%   2011-03-30 use angles in degrees

if length(varargin)==1
    circle = varargin{1};
    x0 = circle(1);
    y0 = circle(2);
    r  = circle(3);
    start   = circle(4);
    extent  = circle(5);
    
elseif length(varargin)==5
    x0 = varargin{1};
    y0 = varargin{2};
    r  = varargin{3};
    start   = varargin{4};
    extent  = varargin{5};
    
else
    error('drawCircleArc: please specify center (x and y), radius, start angle and extent');
end

% convert angles in radians
t0 = deg2rad(start);
t1 = start + deg2rad(extent);

% initialize handles vector
h   = zeros(length(x0), 1);

% draw each circle arc individually
N = 60;
for i=1:length(x0)
    % compute basis
    t = linspace(t0(i), t1(i), N+1)';

    % compute vertices coordinates
    xt = x0(i) + r(i)*cos(t);
    yt = y0(i) + r(i)*sin(t);
    
    % draw the circle arc
    h(i) = line(xt, yt);
end

if nargout > 0
    varargout = {h};
end