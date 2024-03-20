function drawSurfPatch(varargin)
%DRAWSURFPATCH Draw a 3D surface patch, with 2 parametrized surfaces.
%
%   usage:
%   drawSurfPatch(u, v, zuv)
%   where u, v, and zuv are three matrices the same size, u and
%   corresponding to each parameter, and zuv being equal to a function of u
%   and v.
%
%   drawSurfPatch(u, v, zuv, p0)
%   If p0 is specified, two lines with u(p0(1)) and v(p0(2)) are drawn on
%   the surface, and corresponding tangent are also shown.
%
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-05-24
% Copyright 2005-2023 INRA - TPV URPOI - BIA IMASTE

% extract handle of axis to draw on
[hAx, varargin] = parseAxisHandle(varargin{:});

u = varargin{1};
v = varargin{2};
z = varargin{3};
varargin(1:3) = [];

% prepare figure
hold(hAx, 'on');

% draw the surface interior
surf(hAx, u, v, z, 'FaceColor', 'g', 'EdgeColor', 'none');

% draw the surface boundaries
drawPolyline3d(hAx, u(1,:), v(1,:), z(1,:))
drawPolyline3d(hAx, u(end,:), v(end,:), z(end,:))
drawPolyline3d(hAx, u(:,end), v(:,end), z(:,end))
drawPolyline3d(hAx, u(:,1), v(:,1), z(:,1))

% eventually draw two perpendicular lines on the surface
if ~isempty(varargin)
    pos = varargin{1};
    drawPolyline3d(hAx, u(pos(1),:), v(pos(1),:), z(pos(1),:));
    drawPolyline3d(hAx, u(:,pos(2)), v(:,pos(2)), z(:,pos(2)));
end
