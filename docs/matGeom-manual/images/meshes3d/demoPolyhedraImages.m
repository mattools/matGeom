%DEMOPOLYHEDRAIMAGES  One-line description here, please.
%
%   output = demoPolyhedra(input)
%
%   Example
%   demoPolyhedra
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-12-07,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.


%% Cube
figure(1); clf; 
[v, f] = createCube;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Cube');
print(gcf, 'cube.png', '-dpng');


%% Octahedron
figure(1); clf; 
[v, f] = createOctahedron;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Octahedron');
print(gcf, 'octahedron.png', '-dpng');

%% Cube-Octahedron
figure(1); clf; 
[v, f] = createCubeOctahedron;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Cube-Octahedron');
print(gcf, 'cubeOctahedron.png', '-dpng');

%% Icosahedron
figure(1); clf; 
[v, f] = createIcosahedron;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Icosahedron');
print(gcf, 'icosahedron.png', '-dpng');

%% Dodecahedron
figure(1); clf; 
[v, f] = createDodecahedron;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Dodecahedron');
print(gcf, 'dodecahedron.png', '-dpng');

%% Soccer Ball, buckyall, C60...
figure(1); clf; 
[v, f] = createSoccerBall;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Soccer Ball');
print(gcf, 'soccerBall.png', '-dpng');


%% Tetrahedron
figure(1); clf; 
[v, f] = createTetrahedron;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Tetrahedron');
print(gcf, 'tetrahedron.png', '-dpng');


%% Tetrakaidecahedron
figure(1); clf; 
[v, f] = createTetrakaidecahedron;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Tetrakaidecahedron');
print(gcf, 'tetrakaidecahedron.png', '-dpng');


%% Menger Sponge
figure(1); clf; 
[v, e, f] = createMengerSponge; %#ok<ASGLU>
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Menger Sponge');
print(gcf, 'mengerSponge.png', '-dpng');


%% Rhombododecahedron

figure(1); clf; 
[v, e, f] = createRhombododecahedron;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Rhombododecahedron');
print(gcf, 'rhombododecahedron.png', '-dpng');


%% Durer's Polyhedron

figure(1); clf; 
[v, f] = createDurerPolyhedron;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('DurerPolyhedron');
print(gcf, 'durerPolyhedron.png', '-dpng');
