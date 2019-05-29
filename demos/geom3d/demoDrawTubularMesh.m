function demoDrawTubularMesh
%DEMODRAWTUBULARMESH Draw a tubular mesh using matGeom library
%
%   Example
%     demoDrawTubularMesh
%
%   See also
%     drawSoccerBall, demoRevolutionSurface, demoInertiaEllipsoid
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2012-04-25,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

%% Initialisation

% extract vertices, edges, and faces of soccerball polyhedron
[vertices, edges, faces] = createSoccerBall;

% prepare figure
figure(1); clf; hold on;
axis equal;
view(3);

% draw the polyhedron as basis
drawPolyhedron(vertices, faces);


%% Draw each edge as a green cylinder

figure; hold on;
axis equal;
view(3);

width = .05;
radius = .1;

for i = 1:size(edges, 1)
    p1 = vertices(edges(i, 1), :);
    p2 = vertices(edges(i, 2), :);

    drawCylinder([p1 p2 width], 'FaceColor', 'g');
end


%% Draw each vertex as a blue ball

for i = 1:size(vertices, 1)
    drawSphere([vertices(i, :) radius], 'FaceColor', 'b');
end


%% More setup on display

set(gcf, 'renderer', 'opengl')
light;
view([10 30]);
