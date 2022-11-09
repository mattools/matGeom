function varargout = drawEllipseAxes(varargin)
%DRAWELLIPSEAXES Draw the main axes of an ellipse as line segments.
%
%   drawEllipseAxes(ELLI)
%   drawEllipseAxes(..., STYLE)
%   drawEllipseAxes(..., NAME, VALUE)
%   Draw the axes of the ellipse given by ELLI onto the currrent axis.
%   STYLE specifies the drawing style using a short character array like
%   'b', 'k:', 'm-'...
%   More complex drawing style can be specified using plot-like parameter
%   name-value pairs.
%
%   drawEllipseAxes(AX, ELLI)
%   Specifies the axes to draw the ellipse on.
%
%   Example
%     elli = [50 50  40 20  30];
%     figure; hold on; axis equal; axis([0 100 0 100]);
%     drawEllipse(elli, 'LineWidth', 2, 'Color', 'b')
%     drawEllipseAxes(elli, 'k')
%
%   See also
%     ellipses2d, drawEllipse, drawEllipseArc
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2022-09-11,    using Matlab 9.9.0.1570001 (R2020b) Update 4
% Copyright 2022 INRAE.


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
for iElli = 1:length(varargin)
    if ischar(varargin{iElli})
        styles = varargin(iElli:end);
        varargin(iElli:end) = [];
        break;
    end
end

% retrieve ellipse parameters
ellipse = varargin{1};
x0 = ellipse(:, 1);
y0 = ellipse(:, 2);
a  = ellipse(:, 3);
b  = ellipse(:, 4);
theta = ellipse(:, 5);
nElli = length(x0);

%% Process drawing of a set of ellipses

% angular positions of edge extremities
ti = [0 pi  pi/2 3*pi/2];

% compute position of points to draw each ellipse
h = zeros(2 * nElli , 1);
for iElli = 1:nElli 
    % pre-compute rotation angles (given in degrees)
    cot = cosd(theta(iElli));
    sit = sind(theta(iElli));
    
    % compute position of points used to draw current ellipse
    xt = x0(iElli) + a(iElli) * cos(ti) * cot - b(iElli) * sin(ti) * sit;
    yt = y0(iElli) + a(iElli) * cos(ti) * sit + b(iElli) * sin(ti) * cot;
    
    % stores handle to graphic object
    h(2 * iElli - 1) = plot(ax, xt(1:2), yt(1:2), styles{:});
    h(2 * iElli)     = plot(ax, xt(3:4), yt(3:4), styles{:});
end

% return handles if required
if nargout > 0
    varargout = {h};
end

