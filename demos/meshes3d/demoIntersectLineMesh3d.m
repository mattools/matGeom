% Demonstration of the intersectLineMesh3d function.
%
%   output = demoIntersectLineMesh3d(input)
%
%   Example
%   demoIntersectLineMesh3d
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2021-08-02,    using Matlab 9.10.0.1684407 (R2021a) Update 3
% Copyright 2021 INRAE.


%% Input mesh

% create the mesh
[v, f] = createOctahedron;
v = v * 10;

% draw the mesh
figure; hold on; axis equal; view(3); 
axis([-10 10 -10 10 -10 10]);
drawMesh(v, f, 'g');


%% Input lines
% create a collection of parallel lines

% line direction is mostly horizontal
vl = [3 2 1];

% choose several origins for lines
ly = -8:4:8;
lz = -8:4:8;
[y0, z0] = meshgrid(ly, lz);
x0 = zeros(size(y0));

% create the lines
lines = [x0(:) y0(:) z0(:) repmat(vl, numel(y0), 1)];

% draw the lines
drawLine3d(lines, 'b');


%% Compute intersections

% compute intersections
inters = intersectLineMesh3d(lines, v, f);

% draw intersection points
drawPoint3d(inters, 'ko');
