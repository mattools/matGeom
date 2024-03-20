% Demonstration to mesh a 3D square to a parallel 3D pentagonal star.
%
%   output = demoTriangulatePolygonPair3d_SquareStar(input)
%
%   Example
%   demoTriangulatePolygonPair3d_SquareStar
%
%   See also
%     triangulatePolygonPair3d
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2022-01-24,    using Matlab 9.10.0.1739362 (R2021a) Update 5
% Copyright 2022 INRAE.


%% Generate input data

% generate a square centered on the origin
square = [-10 -10; 10 -10; 10 10;-10 10];

% generate two circles
star = circleToPolygon([0 0 10 0.1], 10);
star(1:2:end-1,:) = 1.5 * star(1:2:end-1,:);
star(2:2:end,:) = 1.0 * star(2:2:end,:);

% display as 2D polygons
figure; axis equal; axis([-15 15 -15 15]); hold on;
drawPolygon(square, 'b');
drawPolygon(star, 'm');

% convert to 3D polygons
poly1 = [square zeros(size(square, 1), 1)];
poly2 = [star 10*ones(size(star, 1), 1)];

% display as 2D polygons
figure; axis equal; axis([-15 15 -15 15 -10 30]); hold on; view(3);
drawPolygon3d(poly1, 'b');
drawPolygon3d(poly2, 'm');


%% Compute triangulation

[tri, weight] = triangulatePolygonPair3d(poly1, poly2);

% display trimesh
figure; axis equal; axis([-15 15 -15 15 -10 30]); hold on; view(3);
drawMesh([poly1;poly2], tri);
drawPolygon3d(poly1, 'linewidth', 2, 'color', 'b');
drawPolygon3d(poly2, 'linewidth', 2, 'color', [0 0.8 0]);
