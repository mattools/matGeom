function drawPartialPatch(u, v, z, varargin)
%DRAWPARTIALPATCH Draw surface patch, with 2 parametrized surfaces.
%
%   usage:
%   drawSurfPatch(u, v, zuv)
%   where u, v, and zuv are three matrices the same size, u and
%   corresponding to each parameter, and zuv being equal to a function of u
%   and v.
%
%   drawSurfPatch(u, v, zuv, p0)
%   If p0 is specified, two lines with u(p0(1)) and v(p0(2)) are drawn on
%   the surface
%
%
%   See also 
%     drawPolyline3d
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-05-24
% Copyright 2005-2022 INRA - TPV URPOI - BIA IMASTE

% prepare figure
hold on;

% draw the surface interior
surf(u, v, z, 'FaceColor', 'g', 'EdgeColor', 'none');

% draw the surface boundaries
drawPolyline3d(u(1,:), v(1,:), z(1,:))
drawPolyline3d(u(end,:), v(end,:), z(end,:))
drawPolyline3d(u(:,end), v(:,end), z(:,end))
drawPolyline3d(u(:,1), v(:,1), z(:,1))

% eventually draw two perpendicular lines on the surface
if ~isempty(varargin)
    pos = varargin{1};
    drawPolyline3d(u(pos(1),:), v(pos(1),:), z(pos(1),:));
    drawPolyline3d(u(:,pos(2)), v(:,pos(2)), z(:,pos(2)));
end
