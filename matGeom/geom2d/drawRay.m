function varargout = drawRay(ray, varargin)
%DRAWRAY Draw a ray on the current axis
%
%   drawRay(RAY)
%   With RAY having the syntax: [x0 y0 dx dy], draws the ray starting from
%   point (x0 y0) and going to direction (dx dy), clipped with the current
%   window axis.
%
%   drawRay(RAY, PARAMS, VALUE)
%   Can specify param-pair values.
%
%   H = drawRay(...)
%   Returns handle on line object
%
%   See also:
%   rays2d, drawLine
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

%   HISTORY
%   2005-07-06 add support for multiple rays
%   2007-10-18 add support for drawing options
%   2011-03-12 rewrite using clipRay
%   2011-10-11 add management of axes handle

% extract handle of axis to draw in
if isAxisHandle(ray)
    ax = ray;
    ray = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% get bounding box limits
box = axis(ax);

% compute clipped shapes
[clipped isInside] = clipRay(ray, box);

% allocate memory for handle
h = -ones(size(ray, 1), 1);

% draw visible rays
h(isInside) = drawEdge(ax, clipped(isInside, :), varargin{:});

% process output
if nargout > 0
    varargout = {h};
end
