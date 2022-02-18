%DRAWMESH_MUSHROOM  One-line description here, please.
%
%   output = drawMesh_mushroom(input)
%
%   Example
%   drawMesh_mushroom
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-01-22,    using Matlab 9.7.0.1247435 (R2019b) Update 2
% Copyright 2020 INRAE.

[v, f] = readMesh_off('mushroom.off');

figure; 
drawMesh(v, f, 'facecolor', [.7 .7 .7], 'linestyle', 'none');
axis equal; view([-15 80]); light; axis off
drawFaceNormals(v, f);

print(gcf, 'drawMesh_mushroom.png', '-dpng');
