function [pos, zp] = planePosition(point, plane)
%PLANEPOSITION Compute position of a point on a plane.
%
%   COORDS2D = planePosition(POINT, PLANE)
%   POINT has format [X Y Z], and plane has format
%   [X0 Y0 Z0  DX1 DY1 DZ1  DX2 DY2 DZ2], where :
%   - (X0, Y0, Z0) is a point belonging to the plane
%   - (DX1, DY1, DZ1) is a first direction vector
%   - (DX2, DY2, DZ2) is a second direction vector
%   Result COORDS2D has the form [XP YP], with XP and YP the coordinates of
%   the point in the coordinate system of the plane.
%
%   [COORDS2D, Z] = planePosition(POINT, PLANE)
%   Also returns the coordinates along the normal of the plane. When the
%   point is within the plane, this coordinate should be zero.
%
%   Example
%     plane = [10 20 30  1 0 0  0 1 0];
%     point = [13 24 35];
%     pos = planePosition(point, plane)
%     pos = 
%         3   4
%
%   Example
%     % plane with non unit direction vectors
%     p0 = [30 20 10]; v1 = [2 1 0]; v2 = [-2 4 0];
%     plane = [p0 v1 v2];
%     pts = [p0 ; p0 + v1 ; p0 + v2 ; p0 + 3 * v1 + 2 * v2];
%     pos = planePosition(pts, plane)
%     pos = 
%          0     0
%          1     0
%          0     1
%          3     2
%
%
%   See also:
%     geom3d, planes3d, points3d, planePoint
%

%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 21/02/2005.
%

% size of input arguments
npl = size(plane, 1);
npt = size(point, 1);

% check inputs have compatible sizes
if npl ~= npt && npl > 1 && npt > 1
    error('geom3d:planePosition:inputSize', ...
        'plane and point should have same size, or one of them must have 1 row');
end

% origin and direction vectors of the plane(s)
p0 = plane(:, 1:3);
v1 = plane(:, 4:6);
v2 = plane(:, 7:9);

% Principle
% 
% for each (recentered) point, we need to solve the system:
%   s * v1x + t * v2x + u * v3x  = px
%   s * v1y + t * v2y + u * v3y  = py
%   s * v1z + t * v2z + u * v3z  = pz
% Assuming the point belong to the place, the value of u is 0. The last
% equation is kept only for homogeneity.
% We rewrite in matrix form:
%   [ v1x v2x v3x ]   [ s ]   [ xp ]
%   [ v1y v2y v3y ] * [ t ] = [ yp ]
%   [ v1z v2z v3z ]   [ u ]   [ zp ]
% Or:
%   A * X = B
% We need to solve X = inv(A) * B. In practice, we use the b/A notation,
% obtained after using transpositon on the A\b notation.
%   X' = (inv(mat) * bsxfun(@minus, point, p0)')';
%   X' = bsxfun(@minus, point, p0) * inv(mat');
%   X' = bsxfun(@minus, point, p0) / mat';
%   (and we compute the transpose of the basis transform)

% Compute dot products with direction vectors of the plane
if npl == 1
    % we have npl == 1 and npt > 1
    % build transpose of matrix that changes plane basis to global basis
    mat = [v1 ; v2 ; cross(v1, v2, 2)];
    tmp = bsxfun(@minus, point, p0) / mat;
    pos = tmp(:, 1:2);
    zp = tmp(:,3);

else
    % NPL > 0 -> iterate over planes
    % Number of points can be either 1, or the same number as planes
    pos = zeros(npl, 2);
    zp = zeros(npl, 1);
    for ipl = 1:npl
        mat = [v1(ipl,:) ; v2(ipl,:) ; cross(v1(ipl,:), v2(ipl,:), 2)];
        % choose either point with same index, or the single point
        ind = min(ipl, npt);
        tmp = bsxfun(@minus, point(ind,:), p0(ipl,:)) / mat;
        pos(ipl,:) = tmp(1,1:2);
        zp(ipl) = tmp(1,3);
    end
end

% % old version (:
% s = dot(point-p0, d1, 2) ./ vectorNorm3d(d1);
% t = dot(point-p0, d2, 2) ./ vectorNorm3d(d2);
