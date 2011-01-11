function demoPolyhedra(varargin)
%DEMOPOLYHEDRA Draw main polyhedra defined in the geom3d toolbox
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

figure;

% cube
subplot(3, 3, 1);
[v f] = createCube;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Cube');

% Octahedron
subplot(3, 3, 2);
[v f] = createOctahedron;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Octahedron');

% Cube-Octahedron
subplot(3, 3, 3);
[v f] = createCubeOctahedron;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Cube-Octahedron');

% Icosahedron
subplot(3, 3, 4);
[v f] = createIcosahedron;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Icosahedron');

% Dodecahedron
subplot(3, 3, 5);
[v f] = createDodecahedron;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Dodecahedron');

% Soccer Ball, buckyall, C60...
subplot(3, 3, 6);
[v f] = createSoccerBall;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Soccer Ball');


% Tetrahedron
subplot(3, 3, 7);
[v f] = createTetrahedron;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Tetrahedron');


% Tetrakaidecahedron
subplot(3, 3, 8);
[v f] = createTetrakaidecahedron;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Tetrakaidecahedron');


% Menger Sponge
subplot(3, 3, 9);
[v e f] = createMengerSponge;
drawMesh(v, f);
view(3); axis('vis3d'); axis off;
title('Menger Sponge');




