% Demonstration of the intersectPlaneMesh function.
%
%   output = demoIntersectPlaneMesh(input)
%
%   Example
%   demoIntersectPlaneMesh
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2021-08-02,    using Matlab 9.10.0.1684407 (R2021a) Update 3
% Copyright 2021 INRAE.


%% Input mesh

% create the mesh
[v, f] = createOctahedron;
v = v * 10;

% draw the mesh
figure; hold on; axis equal; view(3); 
axis([-10 10 -10 10 -10 10]);
drawMesh(v, f, 'g');


%% Input planes
% create a collection of parallel planes

% planedirection is mostly horizontal
normal = [2 3 8];

% choose several origins for planes
origins = [zeros(5, 2) (-8:4:8)'];
nPlanes = size(origins, 1);

% create the planes
planes = zeros(nPlanes, 9);
for i = 1:nPlanes
    planes(i,:) = createPlane(origins(i,:), normal);
end

% draw the lines
drawPlane3d(planes, 'FaceColor', 'blue', 'FaceAlpha', .4);


%% Compute intersections

% allocate array
polySets = cell(1, nPlanes);

% compute intersections
for i = 1:nPlanes
    polys = intersectPlaneMesh(planes(i,:), v, f);
    polySets{i} = polys;
end

% draw intersection points
drawPolygon3d(polySets, 'Color', 'magenta', 'LineWidth', 2);
