%DEMOREMOVEMESHFACES Demonstration script for function removeMeshFaces
%
%   output = demoRemoveMeshFaces(input)
%
%   Example
%   demoRemoveMeshFaces
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2017-07-11,    using Matlab 9.1.0.441655 (R2016b)
% Copyright 2017 INRA - Cepia Software Platform.

%% Initialisations

[vertices, faces] = createSoccerBall;
m.vertices=vertices;
faces = triangulateFaces(faces);
m.faces=faces;
fLI = false(length(faces),1);
rmFI=round(linspace(1,length(faces),10));
fLI(rmFI)=true;

faceCents = faceCentroids(vertices, faces);

%% 
[vertices2, faces2] = removeMeshFaces(vertices, faces, fLI);
assert(isequal(faceCentroids(vertices, faces(~fLI,:)),faceCentroids(vertices2, faces2)))

figure('color','w')
drawMesh(vertices, faces, 'faceColor', 'none', 'faceAlpha', .2);
drawMesh(vertices2, faces2, 'faceAlpha', .7);
text(faceCents(fLI,1),faceCents(fLI,2),faceCents(fLI,3),num2str(rmFI'))
view(3)
axis equal

%% 
[m2] = removeMeshFaces(vertices, faces, fLI);
assert(isequal(faceCentroids(vertices, faces(~fLI,:)),faceCentroids(m2.vertices, m2.faces)))

figure('color','w')
drawMesh(vertices, faces, 'faceColor', 'none', 'faceAlpha', .2);
drawMesh(m2.vertices, m2.faces, 'faceAlpha', .7);
text(faceCents(fLI,1),faceCents(fLI,2),faceCents(fLI,3),num2str(rmFI'))
view(3)
axis equal

%%
[m2] = removeMeshFaces(m, fLI);
assert(isequal(faceCentroids(m.vertices, m.faces(~fLI,:)),faceCentroids(m2.vertices, m2.faces)))

figure('color','w')
drawMesh(vertices, faces, 'faceColor', 'none', 'faceAlpha', .2);
drawMesh(m2.vertices, m2.faces, 'faceAlpha', .7);
text(faceCents(fLI,1),faceCents(fLI,2),faceCents(fLI,3),num2str(rmFI'))
view(3)
axis equal
