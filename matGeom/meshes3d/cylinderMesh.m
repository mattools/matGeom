function varargout = cylinderMesh(cyl, varargin)
%CYLINDERMESH  Create a 3D mesh representing a cylinder.
%
%   [V F] = cylinderMesh(CYL)
%   Computes vertex coordinates and face vertex indices of a mesh
%   representing a 3D cylinder given as [X1 Y1 Z1 X2 Y2 Z2 R].
%
%   Example
%     % Draw a rotated cylinder
%     cyl = [0 0 0 10 20 30 5];
%     [v f] = cylinderMesh(cyl);
%     figure;drawMesh(v, f, 'FaceColor', 'r');
%     view(3); axis equal;
%
%     % Draw three mutually intersecting cylinders
%       p0 = [30 30 30];
%       p1 = [90 30 30];
%       p2 = [30 90 30];
%       p3 = [30 30 90];
%       [v1 f1] = cylinderMesh([p0 p1 25]);
%       [v2 f2] = cylinderMesh([p0 p2 25]);
%       [v3 f3] = cylinderMesh([p0 p3 25]);
%       figure; hold on;
%       drawMesh(v1, f1, 'FaceColor', 'r');
%       drawMesh(v2, f2, 'FaceColor', 'g');
%       drawMesh(v3, f3, 'FaceColor', 'b');
%       view(3); axis equal
%       set(gcf, 'renderer', 'opengl')
%  
%   See also
%     drawCylinder, torusMesh, sphereMesh

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-10-25,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% extract cylinder data
p1 = cyl(:, 1:3);
p2 = cyl(:, 4:6);
r  = cyl(:, 7);

% compute length and orientation
[theta, phi, rho] = cart2sph2d(p2 - p1);

% parametrisation on x
t = linspace(0, 2*pi, 20);
lx = r * cos(t);
ly = r * sin(t);

% parametrisation on z
lz = linspace(0, rho, 10);

% generate surface grids
x = repmat(lx, [length(lz) 1]);
y = repmat(ly, [length(lz) 1]);
z = repmat(lz', [1 length(t)]);

% transform points 
trans   = localToGlobal3d(p1, theta, phi, 0);
[x, y, z] = transformPoint3d(x, y, z, trans);

% convert to FV mesh
[vertices, faces] = surfToMesh(x, y, z, 'xPeriodic', true);

% format output
varargout = formatMeshOutput(nargout, vertices, faces);
