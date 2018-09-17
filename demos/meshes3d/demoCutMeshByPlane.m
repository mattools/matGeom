%DEMOCUTMESHBYPLANE cut a soccerball by a plane
%
%   output = demoCutMeshByPlane(input)
%
%   Example
%   demoCutMeshByPlane
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2017-07-11,    using Matlab 9.1.0.441655 (R2016b)
% Copyright 2017 INRA - Cepia Software Platform.


%% Initialisations

[v, f] = createSoccerBall;
f = triangulateFaces(f);
mesh.vertices=v; mesh.faces=f;
planeOrigin = [-0.2 0 0];
planeNormal = [-1 0 -1];
plane = createPlane(planeOrigin, planeNormal);


%%
[above, inside, below] = cutMeshByPlane(mesh, plane);

figure('color','w'); axis equal; hold on; view(3)
drawMesh(above, 'FaceColor', 'r');
drawMesh(inside, 'FaceColor', 'g');
drawMesh(below, 'FaceColor', 'b');

drawPlane3d(plane, 'FaceAlpha',.7)
drawVector3d(planeOrigin, planeNormal)

%%
[aV, aF, iV, iF, bV, bF] = cutMeshByPlane(mesh.vertices, mesh.faces, plane);

figure('color','w'); axis equal; hold on; view(3)
drawMesh(aV, aF, 'FaceColor', 'r');
drawMesh(iV, iF, 'FaceColor', 'g');
drawMesh(bV, bF, 'FaceColor', 'b');

drawPlane3d(plane, 'FaceAlpha',.7)
drawVector3d(planeOrigin, planeNormal)

%%
[aV, aF] = cutMeshByPlane(mesh.vertices, mesh.faces, plane);

figure('color','w'); axis equal; hold on; view(3)
drawMesh(aV, aF, 'FaceColor', 'r');
% drawMesh(iV, iF, 'FaceColor', 'g');
% drawMesh(bV, bF, 'FaceColor', 'b');

drawPlane3d(plane, 'FaceAlpha',.7)
drawVector3d(planeOrigin, planeNormal)

%%
[iV, iF] = cutMeshByPlane(mesh.vertices, mesh.faces, plane,'part','in');

figure('color','w'); axis equal; hold on; view(3)
% drawMesh(aV, aF, 'FaceColor', 'r');
drawMesh(iV, iF, 'FaceColor', 'g');
% drawMesh(bV, bF, 'FaceColor', 'b');

drawPlane3d(plane, 'FaceAlpha',.7)
drawVector3d(planeOrigin, planeNormal)

%%
[bV, bF] = cutMeshByPlane(mesh.vertices, mesh.faces, plane,'part','below');

figure('color','w'); axis equal; hold on; view(3)
% drawMesh(aV, aF, 'FaceColor', 'r');
% drawMesh(iV, iF, 'FaceColor', 'g');
drawMesh(bV, bF, 'FaceColor', 'b');

drawPlane3d(plane, 'FaceAlpha',.7)
drawVector3d(planeOrigin, planeNormal)

%%
above = cutMeshByPlane(mesh, plane);

figure('color','w'); axis equal; hold on; view(3)
drawMesh(above, 'FaceColor', 'r');
% drawMesh(iV, iF, 'FaceColor', 'g');
% drawMesh(bV, bF, 'FaceColor', 'b');

drawPlane3d(plane, 'FaceAlpha',.7)
drawVector3d(planeOrigin, planeNormal)

%%
inside = cutMeshByPlane(mesh, plane,'part','in');

figure('color','w'); axis equal; hold on; view(3)
% drawMesh(aV, aF, 'FaceColor', 'r');
drawMesh(inside, 'FaceColor', 'g');
% drawMesh(bV, bF, 'FaceColor', 'b');

drawPlane3d(plane, 'FaceAlpha',.7)
drawVector3d(planeOrigin, planeNormal)

%%
below = cutMeshByPlane(mesh, plane,'part','below');

figure('color','w'); axis equal; hold on; view(3)
% drawMesh(aV, aF, 'FaceColor', 'r');
% drawMesh(iV, iF, 'FaceColor', 'g');
drawMesh(below, 'FaceColor', 'b');

drawPlane3d(plane, 'FaceAlpha',.7)
drawVector3d(planeOrigin, planeNormal)