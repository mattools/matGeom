%DEMOSPLITMESH Demonstration script for function splitMesh
%
%   output = demoSplitMesh(input)
%
%   Example
%   demoSplitMesh
%
%   See also
%
% ------
% Author: oqilipo
% Created: 2017-09-20,    using Matlab 9.1.0.441655 (R2016b)
% Copyright 2017

%% Quad mesh
[v1, f1] = boxToMesh([1 0 -1 0 -1 0]); 
[v2, f2] = boxToMesh([-1 0 1 0 -1 0]);
[vertices, faces] = concatenateMeshes(v1, f1, v2, f2);
meshes = splitMesh(vertices, faces, 'all');
figure('color','w'); view(3); axis equal
cmap=hsv(length(meshes));
for m=1:length(meshes)
    drawMesh(meshes(m), cmap(m,:))
end

%% Triangle mesh
[v1, f1] = boxToMesh([1 0 -1 0 -1 0]); 
[v2, f2] = boxToMesh([-1 0 1 0 -1 0]);
[v3, f3] = createSoccerBall;
f1 = triangulateFaces(f1);
f2 = triangulateFaces(f2);
f3 = triangulateFaces(f3);
[mesh.vertices, mesh.faces] = concatenateMeshes(v1, f1, v3, f3, v2, f2);
meshes = splitMesh(mesh);
figure('color','w'); view(3); axis equal
cmap=hsv(length(meshes));
for m=1:length(meshes)
    drawMesh(meshes(m), cmap(m,:))
end

%% Triangle mesh - component with most vertices
[v1, f1] = boxToMesh([1 0 -1 0 -1 0]); 
[v2, f2] = boxToMesh([-1 0 1 0 -1 0]);
[v3, f3] = createSoccerBall;
f1 = triangulateFaces(f1);
f2 = triangulateFaces(f2);
f3 = triangulateFaces(f3);
[mesh.vertices, mesh.faces] = concatenateMeshes(v1, f1, v3, f3, v2, f2);
% Only return the component with the most vertices
meshes = splitMesh(mesh, 'mostVertices');
figure('color','w'); view(3); axis equal
cmap=hsv(length(meshes));
for m=1:length(meshes)
    drawMesh(meshes(m), cmap(m,:))
end