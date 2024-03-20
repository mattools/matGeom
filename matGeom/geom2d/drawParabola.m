function varargout = drawParabola(varargin)
%DRAWPARABOLA Draw a parabola on the current axis.
%
%   drawParabola(PARABOLA);
%   Draws a vertical parabola, defined by its vertex and its parameter.
%   Such a parabola admits a vertical axis of symetry.
%
%   The algebraic equation of parabola is given by:
%      (Y - YV) = A * (X - VX)^2
%   Where XV and YV are vertex coordinates and A is parabola parameter.
%
%   A parametric equation of parabola is given by:
%      x(t) = t + VX;
%      y(t) = A * t^2 + VY;
%
%   PARABOLA can also be defined by [XV YV A THETA], with theta being the
%   angle of rotation of the parabola (in degrees and Counter-Clockwise).
%
%   drawParabola(PARABOLA, T);
%   Specifies which range of 't' are used for drawing parabola. If T is an
%   array with only two values, the first and the last values are used as
%   interval bounds, and several values are distributed within this
%   interval.
%
%   drawParabola(..., NAME, VALUE);
%   Can specify one or several graphical options using parameter name-value
%   pairs.
%
%   drawParabola(AX, ...);
%   Specifies handle of the axis to draw on.
%
%   H = drawParabola(...);
%   Returns an handle to the created graphical object.
%
%
%   Example:
%     figure(1); clf; hold on;
%     axis equal; axis([0 100 0 100])
%     % draw parabola with default parameterization bounds 
%     drawParabola([50 50 .2 30]);
%     % draw parabola with more specific bounds and drawing style
%     drawParabola([50 50 .2 30], [-3 3], 'color', 'r', 'linewidth', 2);
%   
%
%   See also 
%   drawCircle, drawEllipse
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2006-06-02
% Copyright 2006-2023 INRA - TPV URPOI - BIA IMASTE

% Extract parabola
if nargin < 1
    error('MatGeom:geom2d:drawParabola:IllegalArgument', ...
        'Please specify parabola representation');
end

% extract handle of axis to draw on
if isAxisHandle(varargin{1})
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% input parabola is given as a packed array
parabola = varargin{1};
varargin(1) = [];
x0 = parabola(:,1);
y0 = parabola(:,2);
a  = parabola(:,3);

% check if parabola orientation is specified
if size(parabola, 2) > 3
    theta = parabola(:, 4);
else
    theta = zeros(length(a), 1);
end

% extract parametrisation bounds
bounds = [-100 100];
if ~isempty(varargin)
    var = varargin{1};
    if isnumeric(var)
        bounds = var;
        varargin(1) = [];
    end
end

% create parametrisation array
if length(bounds) > 2
    t = bounds;
else
    t = linspace(bounds(1), bounds(end), 100);
end

% create handle array (in the case of several parabola)
h = zeros(size(x0));

% draw each parabola
for i = 1:length(x0)
    % compute transformation
    trans = ...
        createTranslation(x0(i), y0(i)) * ...
        createRotation(deg2rad(theta(i))) * ...
        createScaling(1, a);
    
	% compute points on the parabola
    [xt, yt] = transformPoint(t(:), t(:).^2, trans);

    % draw it
    h(i) = plot(ax, xt, yt, varargin{:});
end

% process output arguments
if nargout > 0
    varargout = {h};
end

