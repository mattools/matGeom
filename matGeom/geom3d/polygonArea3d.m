function area = polygonArea3d(poly, varargin)
%POLYGONAREA3D Area of a 3D polygon
%
%   AREA = polygonArea3d(POLY)
%   POLY is given as a N-by-3 array of vertex coordinates. The resulting
%   area is positive.
%
%   Example
%     poly = [10 30 20;20 30 20;20 40 20;10 40 20];
%     polygonArea3d(poly)
%     ans =
%        100
%
%   See also
%     polygons3d, triangleArea3d, polygonArea, polygonCentroid3d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-02-24,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% put the first vertex at origin (reducing computation errors for polygons
% far from origin)
v0 = poly(1, :);
poly = bsxfun(@minus, poly, v0);

% indices of next vertices
N = size(poly, 1);
iNext = [2:N 1];

% compute area (vectorized version)
% need to compute the sign expicitely, as the norm of the cross product
% doas not keep orientation within supporting plane.
cp = cross(poly, poly(iNext,:), 2);
sign_i = sign(dot(cp, repmat(cp(2,:), N, 1), 2));
area_i = vectorNorm3d(cp) .* sign_i;

% sum up individual triangles area
area = sum(area_i) / 2;
