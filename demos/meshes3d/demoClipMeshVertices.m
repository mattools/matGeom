%DEMOCLIPMESHVERTICES clip a soccerball by different shapes 
%
%   Example
%   demoClipMeshVertices
%
%   See also
%
% ------
% Author: oqilipo
% Created: 2017-08-28, using R2016b
% Copyright 2017


%% clip by a box and return the inside
[mesh.vertices, mesh.faces] = createSoccerBall;
box = [0 2 -1 2 -.5 2];
[v2, f2] = clipMeshVertices(mesh, box);
figure('color','w'); view(3); axis equal
drawMesh(mesh, 'faceColor', 'none', 'faceAlpha', .2);
drawBox3d(box)
drawMesh(v2, f2, 'faceAlpha', .7);

%% clip by a box and return the outside
[v, f] = createSoccerBall;
f = triangulateFaces(f);
box = [0 2 -1 2 -.5 2];
[v2, f2] = clipMeshVertices(v, f, box, 'inside', false);
figure('color','w'); view(3); axis equal
drawMesh(v, f, 'faceColor', 'none', 'faceAlpha', .2);
drawBox3d(box)
drawMesh(v2, f2, 'faceAlpha', .7);

%% clip by a sphere and return the inside 
[v, f] = createSoccerBall;
f = triangulateFaces(f);
sphere = [0.9 -0.7 0 1.1];
mesh2 = clipMeshVertices(v, f, sphere, 'shape', 'sphere');
figure('color','w'); view(3); axis equal
drawMesh(v, f, 'faceColor', 'none', 'faceAlpha', .2);
drawSphere(sphere,'faceColor', 'none','linestyle','-','edgecolor','b')
drawMesh(mesh2, 'faceAlpha', .7);

%% clip by a sphere and return the outside
[mesh.vertices, mesh.faces] = createSoccerBall;
sphere = [0.9 -0.7 0 1.1];
[v2, f2] = clipMeshVertices(mesh, sphere, 'shape', 'sphere', 'inside', false);
figure('color','w'); view(3); axis equal
drawMesh(mesh, 'faceColor', 'none', 'faceAlpha', .2);
drawSphere(sphere,'faceColor', 'none','linestyle','-','edgecolor','b')
drawMesh(v2, f2, 'faceAlpha', .7);