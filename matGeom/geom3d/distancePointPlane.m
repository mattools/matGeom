function d = distancePointPlane(point, plane)
%DISTANCEPOINTPLANE Signed distance betwen 3D point and plane
%
%   D = distancePointPlane(POINT, PLANE);
%   Returns the (signed) euclidean distance between point POINT and the
%   plane PLANE, given by: 
%   POINT: [x0 y0 z0]
%   PLANE: [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2]
%   D    : scalar  
%
%   D is positive is the point lies 'above' the plane (in the direction of
%   the normal), or negative is the point lies 'below' the plane (in the
%   opposite direction of the normal).
%
%   POINT and PLANE can also be arrays: either they have the same number of
%   rows, or one of them has only one row. In this case the result D is a
%   column vector 
%
%   See also:
%   planes3d, points3d, intersectLinePlane
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

% HISTORY
% 2010-06-20 add support for multiple inputs
% 2010-11-16 use bsxfun (thanks to Sven Holcombe)


% normalized plane normal
n = normalizeVector3d(cross(plane(:,4:6), plane(:, 7:9), 2));

% Uses Hessian form, ie : N.p = d
% I this case, d can be found as : -N.p0, when N is normalized
d = -sum(bsxfun(@times, n, bsxfun(@minus, plane(:,1:3), point)), 2);
