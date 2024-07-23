%DEMOSHAPES3D Display a selection of 3D shapes.
%
%   output = demoShapes3d(input)
%
%   Example
%   demoShapes3d
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2024-07-23,    using Matlab 24.1.0.2628055 (R2024a) Update 4
% Copyright 2024 INRAE.

%% Torus

torus = [50 50 50 30 10 30 45];
fig1 = figure(1); clf; axis equal; hold on;
drawTorus(torus);
view([95 10]); light;
axis('vis3d'); 
title('Torus');
print(fig1, 'torus.png', '-dpng');


%% Ellipsoid

elli = [10 20 30   50 30 10   10 20 30];
fig1 = figure(1); clf; axis equal; hold on;
drawEllipsoid(elli); light;
view([20 10]);
title('Ellipsoid');
print(fig1, 'ellipsoid.png', '-dpng');


%% Capsule

caps = [20 30 40 80 70 60 10];
fig1 = figure(1); clf; axis equal; hold on;
drawCapsule(caps); light;
view([20 10]);
title('Capsule');
print(fig1, 'capsule.png', '-dpng');


%% Dome

% dome = [20 30 40 80 70 60 10];
fig1 = figure(1); clf; axis equal; hold on;
drawDome([10 20 30 10], [1 2 5]); light;
view([20 10]);
title('Dome');
print(fig1, 'dome.png', '-dpng');

