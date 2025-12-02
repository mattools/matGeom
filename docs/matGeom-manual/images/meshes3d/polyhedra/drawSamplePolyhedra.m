%DRAWSAMPLEPOLYHEDRA  One-line description here, please.
%
%   output = drawSamplePolyhedra(input)
%
%   Example
%   drawSamplePolyhedra
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2025-12-01,    using Matlab 25.1.0.2943329 (R2025a)
% Copyright 2025 INRAE.

%% Cube
figure(1); clf; 
[v, f] = createCube;
drawMesh(v, f, 'linewidth', 2);
view(3); axis('vis3d'); axis off;
title('Cube');
print(gcf, 'cube.png', '-dpng');


%% Octahedron
figure(1); clf; 
[v, f] = createOctahedron;
drawMesh(v, f, 'linewidth', 2);
view(3); axis('vis3d'); axis off;
title('Octahedron');
print(gcf, 'Octahedron.png', '-dpng');


%% Tetrahedron
figure(1); clf; 
[v, f] = createTetrahedron;
drawMesh(v, f, 'linewidth', 2);
view(3); axis('vis3d'); axis off;
view([30 35]);
title('Tetrahedron');
print(gcf, 'tetrahedron.png', '-dpng');


%% Dodecahedron
figure(1); clf; 
[v, f] = createDodecahedron;
drawMesh(v, f, 'linewidth', 2);
view(3); axis('vis3d'); axis off;
title('Dodecahedron');
print(gcf, 'dodecahedron.png', '-dpng');


%% Icosahedron
figure(1); clf; 
[v, f] = createIcosahedron;
drawMesh(v, f, 'linewidth', 2);
view(3); axis('vis3d'); axis off;
title('Icosahedron');
print(gcf, 'icosahedron.png', '-dpng');


%% Cube-Octahedron
figure(1); clf; 
[v, f] = createCubeOctahedron;
drawMesh(v, f, 'linewidth', 2);
view(3); axis('vis3d'); axis off;
title('CubeOctahedron');
print(gcf, 'cubeOctahedron.png', '-dpng');


%% Soccer Ball, buckyall, C60...
figure(1); clf; 
[v, f] = createSoccerBall;
drawMesh(v, f, 'linewidth', 2);
view(3); axis('vis3d'); axis off;
title('Soccer Ball');
print(gcf, 'soccerBall.png', '-dpng');


%% Tetrakaidecahedron
figure(1); clf; 
[v, f] = createTetrakaidecahedron;
drawMesh(v, f, 'linewidth', 2);
view(3); axis('vis3d'); axis off;
title('Tetrakaidecahedron');
print(gcf, 'tetrakaidecahedron.png', '-dpng');


%% Rhombododecahedron
figure(1); clf; 
[v, f] = createRhombododecahedron;
drawMesh(v, f, 'linewidth', 2);
view(3); axis('vis3d'); axis off;
title('Rhombododecahedron');
print(gcf, 'rhombododecahedron.png', '-dpng');


%% Durer Polyhedron
figure(1); clf; 
[v, f] = createDurerPolyhedron;
drawMesh(v, f, 'linewidth', 2);
view(3); axis('vis3d'); axis off;
title('Durer Polyhedron');
print(gcf, 'DurerPolyhedron.png', '-dpng');
