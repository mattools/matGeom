function h = drawRay3d(ray, varargin)
% Draw a 3D ray on the current axis.
%
%   drawRay3d(RAY)
%   With RAY having the syntax: [x0 y0 z0 dx dy dz], draws the ray starting
%   from point (x0 y0 z0) and going to direction (dx dy dz), clipped with
%   the current window axis.
%
%   drawRay3d(RAY, PARAMS, VALUE)
%   Can specify parameter name-value pairs to change draw style.
%
%   H = drawRay3d(...)
%   Returns handle on line object
%
%   See also:
%   rays2d, drawLine
%
%   Example
%     % generate 50 random 3D rays
%     origin = [29 28 27];
%     v = rand(50, 3);
%     v = v - centroid(v);
%     ray = [repmat(origin, size(v,1),1) v];
%     % draw the rays in the current axis
%     figure; axis equal; axis([0 50 0 50 0 50]); hold on; view(3);
%     drawRay3d(ray);
%
%   See also
%     drawLine3d, clipRay3d
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-05-25,    using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2020 INRAE.

% extract handle of axis to draw in
if isAxisHandle(ray)
    hAx = ray;
    ray = varargin{1};
    varargin(1) = [];
else
    hAx = gca;
end

% get bounding box limits
box = axis(hAx);

% clip the ray(s) with the limits of the current axis
edge = clipLine3d(ray, box);

% identify valid edges
inds = sum(isnan(edge), 2) == 0;

% draw the clipped line
hh = [];
if any(inds)
    edge = edge(inds, :);
    hh = drawEdge3d(hAx, edge);
    if ~isempty(varargin)
        set(hh, varargin{:});
    end
end

% process output
if nargout > 0
    h = hh;
end
