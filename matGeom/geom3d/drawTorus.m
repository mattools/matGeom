function varargout = drawTorus(torus, varargin)
%DRAWTORUS Draw a torus (3D ring)
%
%   drawTorus(TORUS)
%   Draws the torus on the current axis. TORUS is given by
%   [XC YC ZY R1 R2 THETA PHI]
%   where (XC YZ ZC) is the center of the torus, R1 is the main radius, R2
%   is the radius of the torus section, and (THETA PHI) is the angle of the
%   torus normal vector (both in degrees).
%
%   Example
%   figure;
%   drawTorus([50 50 50 30 10 30 45]);
%   axis equal;
%
%   See also
%   drawEllipsoid, revolutionSurface
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

center = torus(1:3);
r1 = torus(4);
r2 = torus(5);

if size(torus, 2) >= 7
    normal = torus(6:7);
end

% default drawing options
varargin = [{'FaceColor', 'g'}, varargin];

% create base torus
circle = circleAsPolygon([r1 0 r2], 60);
[x y z] = revolutionSurface(circle, linspace(0, 2*pi, 60));

% transform torus
trans = localToGlobal3d([center normal]);
[x y z] = transformPoint3d(x, y, z, trans);

% draw the surface
hs = surf(x, y, z, varargin{:});

if nargout > 0
    varargout = {hs};
end
