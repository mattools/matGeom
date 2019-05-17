function point = projPointOnPlane(point, plane)
%PROJPOINTONPLANE Return the orthogonal projection of a point on a plane.
%
%   PT2 = projPointOnPlane(PT1, PLANE);
%   Compute the (orthogonal) projection of point PT1 onto the plane PLANE,
%   given as [X0 Y0 Z0  VX1 VY1 VZ1  VX2 VY2 VZ2] (origin point, first
%   direction vector, second directionvector).
%   
%   The function is fully vectorized, in that multiple points may be
%   projected onto multiple planes in a single call, returning multiple
%   points. With the exception of the second dimension (where
%   SIZE(PT1,2)==3, and SIZE(PLANE,2)==9), each dimension of PT1 and PLANE
%   must either be equal or one, similar to the requirements of BSXFUN. In
%   basic usage, point PT1 is a [N*3] array, and PLANE is a [N*9] array
%   (see createPlane for details). Result PT2 is a [N*3] array, containing
%   coordinates of orthogonal projections of PT1 onto planes PLANE. In
%   vectorised usage, PT1 is an [N*3*M*P...] matrix, and PLANE is an
%   [X*9*Y...] matrix, where (N,X), (M,Y), etc, are either equal pairs, or
%   one of the two is one.
%
%   See also:
%   planes3d, points3d, planePosition, intersectLinePlane

%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

%   HISTORY
%   21/08/2006: debug support for multiple points or planes
%   22/04/2013: uses bsxfun for mult. pts/planes in all dimensions (Sven H)

% Unpack the planes into origins and normals, keeping original shape
plSize = size(plane);
plSize(2) = 3;
[origins, normals] = deal(zeros(plSize));
origins(:) = plane(:,1:3,:);
normals(:) = crossProduct3d(plane(:,4:6,:), plane(:, 7:9,:));

% difference between origins of plane and point
dp = bsxfun(@minus, origins, point);

% relative position of point on normal's line
t = bsxfun(@rdivide, sum(bsxfun(@times,normals,dp),2), sum(normals.^2,2));

% add relative difference to project point back to plane
point = bsxfun(@plus, point, bsxfun(@times, t, normals));
