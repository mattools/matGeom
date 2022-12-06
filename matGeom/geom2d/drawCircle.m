function varargout = drawCircle(varargin)
%DRAWCIRCLE Draw a circle on the current axis.
%
%   drawCircle(X0, Y0, R);
%   Draw the circle with center (X0,Y0) and the radius R. If X0, Y0 and R
%   are column vectors of the same length, draw each circle successively.
%
%   drawCircle(CIRCLE);
%   Concatenate all parameters in a Nx3 array, where N is the number of
%   circles to draw.
%
%   drawCircle(CENTER, RADIUS);
%   Specify CENTER as Nx2 array, and radius as a Nx1 array.
%
%   drawCircle(..., NSTEP);
%   Specify the number of edges that will be used to draw the circle.
%   Default value is 72, creating an approximation of one point for each 5
%   degrees.
%
%   drawCircle(..., NAME, VALUE);
%   Specifies plotting options as pair of parameters name/value. See plot
%   documentation for details.
%
%   drawCircle(AX, ...)
%   Specifies the handle of the axis to draw on.
%
%   H = drawCircle(...);
%   return handles to each created curve.
%
%   Example
%     figure;
%     hold on;
%     drawCircle([10 20 30]);
%     drawCircle([15 15 40], 'color', 'r', 'linewidth', 2);
%     axis equal;
%
%   See also 
%   circles2d, drawCircleArc, drawEllipse, circleToPolygon
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-10-31
% Copyright 2003-2022 INRA - TPV URPOI - BIA IMASTE

% extract handle of axis to draw on
if isAxisHandle(varargin{1})
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% process input parameters
var = varargin{1};
if size(var, 2) == 1
    x0 = varargin{1};
    y0 = varargin{2};
    r  = varargin{3};
    varargin(1:3) = [];
    
elseif size(var, 2) == 2
    x0 = var(:,1);
    y0 = var(:,2);
    r  = varargin{2};
    varargin(1:2) = [];
    
elseif size(var, 2) == 3
    x0 = var(:,1);
    y0 = var(:,2);
    r  = var(:,3);
    varargin(1) = [];
else
    error('bad format for input in drawCircle');
end

% ensure each parameter is column vector
x0 = x0(:);
y0 = y0(:);
r = r(:);

% default number of discretization steps
N = 72;

% check if discretization step is specified
if ~isempty(varargin)
    var = varargin{1};
    if isnumeric(var) && isscalar(var)
        N = round(var);
        varargin(1) = [];
    end
end

% parametrization variable for circle (use N+1 as first point counts twice)
t = linspace(0, 2*pi, N+1);
cot = cos(t);
sit = sin(t);

% empty array for graphic handles
h = zeros(size(x0));

% compute discretization of each circle
for i = 1:length(x0)
    xt = x0(i) + r(i) * cot;
    yt = y0(i) + r(i) * sit;

    h(i) = plot(ax, xt, yt, varargin{:});
end

if nargout > 0
    varargout = {h};
end
