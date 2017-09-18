%DEMOREMOVEMESHVERTICES Demonstration script for function removeMeshVertices
%
%   output = demoRemoveMeshVertices(input)
%
%   Example
%   demoRemoveMeshVertices
%
%   See also
%
% ------
% Author: oqilipo
% Created: 2017-09-17,    using Matlab 9.1.0.441655 (R2016b)
% Copyright 2017


%% in & out: faces / vertices 
figure('color','w'); view(3);
[v, f] = createSoccerBall; 
plane = createPlane([.6 0 0], [1 0 -1]);
indAbove = find(~isBelowPlane(v, plane));
[v2, f2] = removeMeshVertices(v, f, indAbove);
drawMesh(v2, f2); drawPlane3d(plane); axis equal;

%% in: faces / vertices | out: vertices-faces-struct
figure('color','w'); view(3); 
[v, f] = createSoccerBall; 
plane = createPlane([.6 0 0], [1 0 0]);
indAbove = find(~isBelowPlane(v, plane));
mesh2 = removeMeshVertices(v, f, indAbove);
drawMesh(mesh2); drawPlane3d(plane); axis equal;

%% in & out: vertices-faces-struct
figure('color','w'); view(3);
mesh = createSoccerBall; 
plane = createPlane([-.6 0 0], [1 1 0]);
indAbove = find(~isBelowPlane(v, plane));
mesh2 = removeMeshVertices(mesh, indAbove);
drawMesh(mesh2); drawPlane3d(plane); axis equal;