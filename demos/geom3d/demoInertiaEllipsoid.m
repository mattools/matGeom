function demoInertiaEllipsoid
%DEMOINERTIAELLIPSOID Demo program for the use of ellipsoids
%
%   Example
%     demoInertiaEllipsoid
%
%   See also
%     demoRevolutionSurface, demoDrawTubularMesh

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-06-21,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


%% Data generation

% Generate gaussian 3D data
nPoints = 1000;
points = randn(nPoints, 3);

% point clouds parameters
center = [20 30 40];
sizes  = [70 40 10];
orient = [50 30 30];

% transform points to make a gaussian cloud
transfo = composeTransforms3d(...
    createScaling3d(sizes), ...
    eulerAnglesToRotation3d(orient), ...
    createTranslation3d(center));
points = transformPoint3d(points, transfo);

% display data
figure;
drawPoint3d(points, '.');
hold on;
axis equal;
view([80 -10]);


%% Inertia ellipsoid computation and display

% Fit a 3D inertia ellipsoid to data
elli = inertiaEllipsoid(points);

% draw the ellipsoid with transparency
drawEllipsoid(elli, 'FaceColor', 'g', 'FaceAlpha', .5);


%% Add ellipses and main axes

drawEllipsoid(elli, 'FaceColor', 'g', 'FaceAlpha', .5, ...
          'drawEllipses', true, 'EllipseColor', 'b', 'EllipseWidth', 2, ...
          'drawAxes', true);
      