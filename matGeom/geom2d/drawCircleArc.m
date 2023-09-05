function varargout = drawCircleArc(varargin)
%DRAWCIRCLEARC Draw a circle arc on the current axis.
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
%   See also 
%     circles2d, drawCircle, drawEllipse, circleArcToPolyline
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-12-12
% Copyright 2003-2023 INRA - TPV URPOI - BIA IMASTE

%% Parse input arguments

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


%% Pre-processing

% convert angles in radians
t0  = deg2rad(start);
t1  = t0 + deg2rad(extent);

% number of line segments
N = 60;

% initialize handles vector
h   = zeros(length(x0), 1);

% save hold state
holdState = ishold(ax);
hold(ax, 'on');


%% Display each circle arc

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


%% post-processing

% restore hold state
if ~holdState
    hold(ax, 'off');
end

if nargout > 0
    varargout = {h};
end
