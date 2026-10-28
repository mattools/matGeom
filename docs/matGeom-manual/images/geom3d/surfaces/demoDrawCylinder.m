%DEMODRAWELLIPSOID  One-line description here, please.
%
%   output = demoDrawEllipsoid(input)
%
%   Example
%   demoDrawEllipsoid
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2026-10-28,    using Matlab 26.2.0.3386108 (R2026b)
% Copyright 2026 INRAE.


%% Common data

center = [50 50 50];
orient = [120 40 10];
azel =  [120 30];


%% cylinder

rotMat = eulerAnglesToRotation3d(orient);
pts = [50 0 0;-50 0 0];
pts2 = transformPoint3d(pts, rotMat);
pts3 = pts2 + center;
cyl = [pts3(1,:) pts3(2,:) 20];


figure; hold on; axis equal; axis([0 100 0 100 0 100]);
drawCylinder(cyl, 'faceColor', 'g');
view(azel); light;
print(gcf, 'cylinder_large.png', '-dpng');
