%DEMO_MESHPROCESSING_BUNNY1K  One-line description here, please.
%
%   output = demo_meshProcessing_bunny1k(input)
%
%   Example
%   demo_meshProcessing_bunny1k
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2024-06-27,    using Matlab 24.1.0.2628055 (R2024a) Update 4
% Copyright 2024 INRAE.


%% Read data

% read sample mesh
mesh = readMesh('bunny_F1k.ply');

% display mesh using equal-scale axes
figure; hold on; axis equal; view(3);
drawMesh(mesh, 'faceColor', [.7 .7 .7]);
axis([-8 10 -6 8 -8 10]);
view(15, 20);


%% Display face normals

normals = meshFaceNormals(mesh);
centros = meshFaceCentroids(mesh);

figure; hold on; axis equal; view(3);
drawMesh(mesh, 'faceColor', [.7 .7 .7]);
axis([-8 10 -6 8 -8 10]);
view(15, 20);
drawArrow3d(centros, normals);


%% Distance point mesh

% compute distance between some arbitrary poitns and mesh
point = [8 -3 8;2 -5 8;-6 -4 -4];
[dist, proj] = distancePointMesh(point, mesh);

% also compute a distance map for a vertical slice intersecting the mesh
lx = linspace(-8, 10, 181);
lz = linspace(-8, 10, 181);
[x, z] = meshgrid(lx, lz);
y = ones(size(x)) * 3;
pts = [x(:) y(:) z(:)];
dists = distancePointMesh(pts, mesh);
distMap = reshape(dists, size(x));

% display mesh
figure; hold on; axis equal; view(3);
drawMesh(mesh, 'faceColor', [.7 .7 .7]);
axis([-8 10 -6 8 -8 10]);
view(15, 20);

% display the distance map
surf(x, y, z, distMap, 'linestyle', 'none');

% display point-to-mesh distances
drawPoint3d(point, 'ko');
drawPoint3d(proj, 'k*');
drawEdge3d([point proj], 'color', 'k', 'linewidth', 2)



%% Curvature map

% compute the two main curvatures on each vertex of the mesh
[k1, k2] = meshCurvatures(mesh.vertices, mesh.faces);

% displauy the Gaussian curvature, equal to the product of the main
% curvatures
figure; hold on; axis equal; view(3);
drawMesh(mesh, 'VertexColor', k1 .* k2);
axis([-8 10 -6 8 -8 10]);
view(15, 20);
set(gca, 'clim', [-0.01 0.01]);
colormap jet;


%% Plane intersection

% plane direction vector
direction = normalizeVector3d([2 -1 1]);

% choose several parallel planes
positions = -10:2:10;

figure; hold on; axis equal; view(3);
drawMesh(mesh, 'faceColor', [.7 .7 .7]);
axis([-8 10 -6 8 -8 10]);
view(15, 20);

% iterate over planes
for iPos = 1:length(positions)
    % create supporting plane as 1-by-9 rowvector
    planeOrigin = [0 0 0] + positions(iPos) * direction;
    plane = createPlane(planeOrigin, direction);

    % compute intersections
    polys = intersectPlaneMesh(plane, mesh);

    % display intersectinos
    drawPolygon3d(polys, 'lineWidth', 2, 'color', 'm');
end


%% Clip mesh with a plane

% create a plane, a result of clipping
plane = createPlane([0 0 0], [-5 5 3]);
[v2, f2] = clipMeshByPlane(mesh, plane);

% display result
figure; hold on; axis equal; view(3);
axis([-8 10 -6 8 -8 10]);
drawMesh(v2, f2, 'faceColor', [.7 .7 .7]);
view(15, 20);

% also draw the boundary
boundary = meshBoundary(v2, f2);
drawPolygon3d(boundary, 'linewidth', 2, 'color', 'm');
