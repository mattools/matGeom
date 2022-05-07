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
% e-mail: david.legland@inrae.fr
% Created: 2017-07-11,    using Matlab 9.1.0.441655 (R2016b)
% Copyright 2017 INRA - Cepia Software Platform.


%% Initialisations

[v, f] = createSoccerBall;
f = triangulateFaces(f);
mesh.vertices=v; mesh.faces=f;
planeOrigin = [-0.2 0 0];
planeNormal = [-1 0 -1];
plane = createPlane(planeOrigin, planeNormal);


%% Cut the mesh into different parts

[above, inside, below] = cutMeshByPlane(mesh, plane);

figure('color','w'); axis equal; hold on; view(3)
drawMesh(above, 'FaceColor', 'r');
drawMesh(inside, 'FaceColor', 'g');
drawMesh(below, 'FaceColor', 'b');

drawPlane3d(plane, 'FaceAlpha',.7);
drawVector3d(planeOrigin, planeNormal);

print(gcf, 'cutMeshByPlane.png', '-dpng');
