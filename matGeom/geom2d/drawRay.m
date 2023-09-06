function varargout = drawRay(varargin)
%DRAWRAY Draw a ray on the current axis.
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
%   See also 
%     rays2d, drawLine, clipRay
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-10-31
% Copyright 2003-2023 INRA - TPV URPOI - BIA IMASTE

% extract handle of axis to draw on
[ax, varargin] = parseAxisHandle(varargin{:});

% extract shape primitive
ray = varargin{1};
varargin(1) = [];

% get bounding box limits
box = axis(ax);

% compute clipped shapes
[clipped, isInside] = clipRay(ray, box);

% allocate memory for handle
h = -ones(size(ray, 1), 1);

% draw visible rays
h(isInside) = drawEdge(ax, clipped(isInside, :), varargin{:});

% process output
if nargout > 0
    varargout = {h};
end
