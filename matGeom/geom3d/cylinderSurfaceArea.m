function S = cylinderSurfaceArea(cyl)
%CYLINDERSURFACEAREA  Surface area of a cylinder
%
%   S = cylinderSurfaceArea(CYL)
%   Computes the surface area of the cylinder defined by:
%   CYL = [X1 Y1 Z1  X2 Y2 Z2  R], 
%   where [X1 Y1 Z1] and [X2 Y2 Z2] are the coordinates of the cylinder
%   extremities, and R is the cylinder radius.
%   The surface area of the cylinder comprises the surface area of the two
%   disk-shape end caps.
%
%   Example
%     cyl = [0 0 0  1 0 0  1];
%     cylinderSurfaceArea(cyl)
%     ans =
%        12.5664
%     % equals to 4*pi
%
%   See also
%     geom3d, ellipsoidSurfaceArea, intersectLineCylinder
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2017-11-02,    using Matlab 9.3.0.713579 (R2017b)
% Copyright 2017 INRA - Cepia Software Platform.

H = distancePoints3d(cyl(:, 1:3), cyl(:, 4:6));
R = cyl(:,7);

S1 = 2*pi*R .* H;
S2 = 2 * (pi * R.^2);

S = S1 + S2;
