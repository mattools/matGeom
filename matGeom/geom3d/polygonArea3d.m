function area = polygonArea3d(poly, varargin)
%POLYGONAREA3D Area of a 3D polygon.
%
%   AREA = polygonArea3d(POLY)
%   POLY is given as a N-by-3 array of vertex coordinates. The resulting
%   area is positive.
%   Works also for polygons given as a cell array of polygons.
%
%   Example
%     % area of a simple 3D square 
%     poly = [10 30 20;20 30 20;20 40 20;10 40 20];
%     polygonArea3d(poly)
%     ans =
%        100
%
%     % Area of a 3D mesh
%     [v f] = createCubeOctahedron;
%     polygons = meshFacePolygons(v, f);
%     areas = polygonArea3d(polygons);
%     sum(areas)
%     ans =
%         18.9282
%
%   See also
%     polygons3d, triangleArea3d, polygonArea, polygonCentroid3d

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2012-02-24,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

%   HISTORY
%   2013-08-20 add support for multiple polygons

% Check multiple polygons
if iscell(poly) || sum(sum(isnan(poly))) > 0
    % split the polygons into a cell array
    polygons = splitPolygons3d(poly);
    nPolys = length(polygons);
    
    % compute area of each polygon
    area = zeros(nPolys, 1);
    for  i = 1:nPolys
        area(i) = polygonArea3d(polygons{i});
    end
    
    return;
end

% put the first vertex at origin (reducing computation errors for polygons
% far from origin)
v0 = poly(1, :);
poly = bsxfun(@minus, poly, v0);

% indices of next vertices
N = size(poly, 1);
iNext = [2:N 1];

% compute cross-product of each elementary triangle formed by origin and
% two consecutive vertices
cp = cross(poly, poly(iNext,:), 2);

% choose one of the triangles as reference for the normal direction
vn = vectorNorm3d(cp);
[tmp, ind] = max(vn); %#ok<ASGLU>
cpRef = cp(ind,:);

% compute the sign of the area of each triangle
% (need to compute the sign explicitely, as the norm of the cross product
% does not keep orientation within supporting plane)
sign_i = sign(dot(cp, repmat(cpRef, N, 1), 2));

% compute area of each triangle, using sign correction
area_i = vectorNorm3d(cp) .* sign_i;

% sum up individual triangles area
area = sum(area_i) / 2;
