function h = drawPlane3d(plane, varargin)
%DRAWPLANE3D Draw a plane clipped by the current axes.
%
%   drawPlane3d(PLANE) draws a plane of the format:
%       [x0 y0 z0  dx1 dy1 dz1  dx2 dy2 dz2]
%
%   drawPlane3d(..., 'PropertyName', PropertyValue,...)
%   Sets the value of the specified patch property. Multiple property
%   values can be set with a single statement. See the function "patch" for
%   details. 
%
%   drawPlane3d(AX,...) 
%   plots into AX instead of GCA.
%
%   H = drawPlane3d(...) 
%   returns a handle H to the patch object.
%
%   Example
%     % Draw a plane, its main axes, and its normal vector
%     p0 = [1 2 3];
%     v1 = [1 0 1];
%     v2 = [0 -1 1];
%     plane = [p0 v1 v2];
%     figure; axis([-10 10 -10 10 -10 10]); hold on; view(3);
%     drawPlane3d(plane);
%     drawLine3d([p0 v1]);
%     drawLine3d([p0 v2]);
%     set(gcf, 'renderer', 'zbuffer');
%     vn = crossProduct3d(v1, v2);
%     drawVector3d(p0, vn);
%
%   See also 
%     planes3d, createPlane, clipPlane, patch

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2005-02-17
% Copyright 2005-2023 INRA - TPV URPOI - BIA IMASTE

% add support for drawing multiple planes at once
if size(plane, 1) > 1
    nPlanes = size(plane, 1);
    hp = zeros(nPlanes, 1);
    for iPlane = 1:nPlanes
        hp(iPlane) = drawPlane3d(plane(iPlane, :), varargin{:});
    end
    
    if nargout > 0
        h = hp;
    end
    
    return;
end

% Parse and check inputs
valFun = @(x) size(x,1)==1 && isPlane(x);
defOpts.FaceColor = 'm';
[hAx, plane, varargin] = ...
    parseDrawInput(plane, valFun, 'patch', defOpts, varargin{:});

% extract axis bounds to crop plane
lim = get(hAx, 'xlim');
xmin = lim(1);
xmax = lim(2);
lim = get(hAx, 'ylim');
ymin = lim(1);
ymax = lim(2);
lim = get(hAx, 'zlim');
zmin = lim(1);
zmax = lim(2);

% allocate array of handles
nPlanes = size(plane, 1);
hp = gobjects(1, nPlanes);

% save hold state
holdState = ishold(hAx);
hold(hAx, 'on');

% iterate over planes
for iPlane = 1:nPlanes
    % clip plane with current axis bounds
    poly = clipPlane(plane(iPlane,:), [xmin xmax ymin ymax zmin zmax]);
    
    % draw only non-empty intersections
    if ~isempty(poly)
        hp(iPlane) = patch( ...
            'XData', poly(:, 1), ...
            'YData', poly(:, 2), ...
            'ZData', poly(:, 3), ...
            'Parent', hAx, varargin{:});
    end
end

% restore hold state
if ~holdState
    hold(hAx, 'off');
end

% Do not return axis if not requested
% avoids output when called without semicolon
if nargout > 0
    h = hp;
end
