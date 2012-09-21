function varargout = drawCircleArc(varargin)
%DRAWCIRCLEARC Draw a circle arc on the current axis
%
%   drawCircleArc(ARC);
%   Draws circle arc defined by ARC = [XC YC R START EXTENT], with (XC, YC)
%   being the circle center, R being the circle radius, starting from angle 
%   START, and with angular extent given by EXTENT. START and EXTENT angles
%   are given in degrees.
%
%   drawCircleArc(XC, YC, R, START, EXTENT);
%   Alternative syntax that seperates inputs.
%
%   drawCircleArc(..., PARAM, VALUE);
%   specifies plot properties by using one or several parameter name-value
%   pairs.
%
%   drawCircleArc(AX, ...);
%   Specifies handle of the axis to draw on.
%
%   H = drawCircleArc(...);
%   Returns a handle to the created line object.
%
%   Example
%     % Draw a red thick circle arc
%     arc = [10 20 30 -120 240];
%     figure;
%     axis([-50 100 -50 100]);
%     hold on
%     drawCircleArc(arc, 'LineWidth', 3, 'Color', 'r')
%
%   See also:
%   circles2d, drawCircle, drawEllipse, circleArcToPolyline
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
%   2011-06-09 add support for line styles
%   2011-10-11 add management of axes handle

if nargin == 0
    error('Need to specify circle arc');
end


% extract handle of axis to draw on
if isAxisHandle(varargin{1})
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

circle = varargin{1};
if size(circle, 2) == 5
    x0  = circle(:,1);
    y0  = circle(:,2);
    r   = circle(:,3);
    start   = circle(:,4);
    extent  = circle(:,5);
    varargin(1) = [];
    
elseif length(varargin) >= 5
    x0  = varargin{1};
    y0  = varargin{2};
    r   = varargin{3};
    start   = varargin{4};
    extent  = varargin{5};
    varargin(1:5) = [];
    
else
    error('drawCircleArc: please specify center, radius and angles of circle arc');
end

% convert angles in radians
t0  = deg2rad(start);
t1  = t0 + deg2rad(extent);

% number of line segments
N = 60;

% initialize handles vector
h   = zeros(length(x0), 1);

% draw each circle arc individually
for i = 1:length(x0)
    % compute basis
    t = linspace(t0(i), t1(i), N+1)';

    % compute vertices coordinates
    xt = x0(i) + r(i)*cos(t);
    yt = y0(i) + r(i)*sin(t);
    
    % draw the circle arc
    h(i) = plot(ax, xt, yt, varargin{:});
end

if nargout > 0
    varargout = {h};
end
