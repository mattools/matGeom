function varargout = drawParabola(varargin)
%DRAWPARABOLA Draw a parabola on the current axis
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
%   figure(1); clf; hold on;
%   drawParabola([50 50 .2 30]);
%   drawParabola([50 50 .2 30], [-1 1], 'color', 'r', 'linewidth', 2);
%   axis equal;
%
%   See Also:
%   drawCircle, drawEllipse
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 02/06/2006.
%

%   HISTORY
%   2010-11-17 rewrite, change parametrisation, update doc
%   2011-03-30 use degrees for angle
%   2011-10-11 add management of axes handle

% Extract parabola
if nargin < 1
    error('geom2d:drawParabola:IllegalArgument', ...
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
    [xt yt] = transformPoint(t(:), t(:).^2, trans);

    % draw it
    h(i) = plot(ax, xt, yt, varargin{:});
end

% process output arguments
if nargout > 0
    varargout = {h};
end

