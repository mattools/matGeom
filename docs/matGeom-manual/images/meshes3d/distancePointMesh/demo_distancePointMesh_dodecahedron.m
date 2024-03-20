%DEMO_DISTANCEPOINTMESH_DODECAHEDRON  One-line description here, please.
%
%   output = demo_distancePointMesh_dodecahedron(input)
%
%   Example
%   demo_distancePointMesh_dodecahedron
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2023-12-20,    using Matlab 23.2.0.2409890 (R2023b) Update 3
% Copyright 2023 INRAE.

mesh = createDodecahedron;
mesh.vertices = mesh.vertices * 30 + 50;

hf1 = figure; hold on; axis equal; axis([0 100 0 100 0 100]); view(3);
drawMesh(mesh, 'faceAlpha', 0.5, 'faceColor', [.5 .5 .5]);
print(gcf, 'distancePointMesh_dodecahedron_init.png', '-dpng');

[x, y] = meshgrid(1:100, 1:100);
z = ones(size(x)) * 50;

pts = [x(:) y(:) z(:)];
distMap = reshape(distancePointMesh(pts, mesh), size(x));
figure; imshow(distMap, [0 max(distMap(:))]); colormap('parula');

figure(hf1);
surf(x, y, z, distMap, 'linestyle', 'none');
print(gcf, 'distancePointMesh_dodecahedron_view3d.png', '-dpng');

