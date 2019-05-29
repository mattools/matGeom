function demoTransformPoint3d
%DEMOTRANSFORMPOINT3D Demo of transformPoint3d
%
%   Example
%     transformPoint3d
%
%   See also
%

% ------
% Author: oqilipo
% Created: 2019-05-25, using R2018b
% Copyright 2019

[mesh(1).vertices, mesh(1).faces] = boxToMesh([1 0 -1 0 -1 0]); 
[mesh(2).vertices, mesh(2).faces] = boxToMesh([-1 0 1 0 -1 0]);
[mesh(3).vertices, mesh(3).faces] = createSoccerBall;
for m=1:length(mesh)
    mesh(m).faces = triangulateFaces(mesh(m).faces);
end
mesh = concatenateMeshes(mesh);

%% mesh input & output
tfmMesh = transformPoint3d(mesh, createRotationOx(-pi/2));
figure('color','w'); view(3); axis equal
drawMesh(mesh,'r')
drawMesh(tfmMesh,'g')

%% point input % ouput
tfmMesh.vertices = transformPoint3d(mesh.vertices, createRotationOx(-pi/2));
figure('color','w'); view(3); axis equal
drawMesh(mesh,'r')
drawMesh(tfmMesh,'g')

% single xyz column vector input & output 
[tfmMesh.vertices(:,1),tfmMesh.vertices(:,2),tfmMesh.vertices(:,3)] = ...
    transformPoint3d(mesh.vertices(:,1),mesh.vertices(:,2),mesh.vertices(:,3),....
    createRotationOx(-pi/2));
figure('color','w'); view(3); axis equal
drawMesh(mesh,'r')
drawMesh(tfmMesh,'g')