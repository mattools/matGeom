%CREATESAMPLEMESHES  One-line description here, please.
%
%   output = createSampleMeshes(input)
%
%   Example
%   createSampleMeshes
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2025-12-03,    using Matlab 25.1.0.2973910 (R2025a) Update 1
% Copyright 2025 INRAE.

%% Sphere
figure(1); clf; hold on; axis equal;
sphere = [10 20 30 40];
[v, f] = sphereMesh(sphere);
drawMesh(v, f, 'linewidth', 2);
view(3); axis('vis3d'); axis off;
print(gcf, 'sphereMesh.png', '-dpng');


%% Ellipsoid
figure(1); clf; hold on; axis equal;
elli = [50 50 50   50 30 10   30 20 10];
[v, f] = ellipsoidMesh(elli);
drawMesh(v, f, 'linewidth', 2);
view(3); axis('vis3d'); axis off;
print(gcf, 'ellipsoidMesh.png', '-dpng');


%% Torus
figure(1); clf; hold on; axis equal;
torus = [50 50 50  30 10  30 45];
[v, f] = torusMesh(torus);
drawMesh(v, f, 'linewidth', 2);
view(3); axis('vis3d'); view([150 -5]); axis off;
print(gcf, 'torusMesh.png', '-dpng');

 %% 3D curve
figure(1); clf; hold on; axis equal;
t = linspace(0, 2*pi, 200)';
x = sin(t) + 2 * sin(2 * t);
y = cos(t) - 2 * cos(2 * t);
z = -sin(3 * t);
curve = [x, y, z];
[v, f] = curveToMesh(curve, 0.5, 16);
drawMesh(v, f, 'linewidth', 2);
view(3); axis('vis3d');  axis off;
print(gcf, 'curveToMesh.png', '-dpng');


