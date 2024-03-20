function varargout = drawEllipse(varargin)
%DRAWELLIPSE Draw an ellipse on the current axis.
%
%   drawEllipse(ELLI);
%   Draws the ellipse ELLI in the form [XC YC RA RB THETA], with center
%   (XC, YC), with main axis of half-length RA and RB, and orientation
%   THETA in degrees counted counter-clockwise.
%
%   drawEllipse(XC, YC, RA, RB);
%   drawEllipse(XC, YC, RA, RB, THETA);
%   Specifies ellipse parameters as separate arguments (old syntax).
%
%   drawEllipse(..., NAME, VALUE);
%   Specifies drawing style of ellipse, see the help of plot function.
%
%   H = drawEllipse(...);
%   Also returns handles to the created line objects.
%
%   -> Parameters can also be arrays. In this case, all arrays are supposed 
%   to have the same size.
%
%   Example:
%   % Draw an ellipse centered in [50 50], with semi major axis length of
%   % 40, semi minor axis length of 20, and rotated by 30 degrees.
%     figure(1); clf; hold on;
%     drawEllipse([50 50 40 20 30]);
%     axis equal; axis([0 100 10 90])
%
%   % add another ellipse with different orientation and style
%     drawEllipse([50 50 40 20 -10], 'LineWidth', 2, 'Color', 'g');
%
%
%   See also 
%     ellipses2d, drawCircle, drawEllipseArc, drawEllipseAxes
%     fitEllipse, ellipseToPolygon, ellipsePoint, transformEllipse
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-12-11
% Copyright 2003-2023 INRA - TPV URPOI - BIA IMASTE

%% Extract input arguments

% extract handle of axis to draw on
if isAxisHandle(varargin{1})
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% extract dawing style strings
styles = {};
for i = 1:length(varargin)
    if ischar(varargin{i})
        styles = varargin(i:end);
        varargin(i:end) = [];
        break;
    end
end

% extract ellipse parameters
if length(varargin) == 1
    % ellipse is given in a single array
    ellipse = varargin{1};
    x0 = ellipse(:, 1);
    y0 = ellipse(:, 2);
    a  = ellipse(:, 3);
    b  = ellipse(:, 4);
    if length(ellipse) > 4
        theta = ellipse(:, 5);
    else
        theta = zeros(size(x0));
    end
    
elseif length(varargin) >= 4
    % ellipse parameters given as separate arrays
    x0 = varargin{1};
    y0 = varargin{2};
    a  = varargin{3};
    b  = varargin{4};
    if length(varargin) > 4
        theta = varargin{5};
    else
        theta = zeros(size(x0));
    end
    
else
    error('drawEllipse: incorrect input arguments');
end


%% Process drawing of a set of ellipses

% angular positions of vertices
t = linspace(0, 2*pi, 145);

% empty array for graphic handles
h = zeros(length(x0), 1);

% save hold state
holdState = ishold(ax);
hold(ax, 'on');


%% Display each ellipse

for i = 1:length(x0)
    % pre-compute rotation angles (given in degrees)
    cot = cosd(theta(i));
    sit = sind(theta(i));
    
    % compute position of points used to draw current ellipse
    xt = x0(i) + a(i) * cos(t) * cot - b(i) * sin(t) * sit;
    yt = y0(i) + a(i) * cos(t) * sit + b(i) * sin(t) * cot;
    
    % stores handle to graphic object
    h(i) = plot(ax, xt, yt, styles{:});
end


%% post-processing

% restore hold state
if ~holdState
    hold(ax, 'off');
end

% return handles if required
if nargout > 0
    varargout = {h};
end

