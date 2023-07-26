function d = distancePointPlane(point, plane)
%DISTANCEPOINTPLANE Signed distance between 3D point and plane.
%
%   D = distancePointPlane(POINT, PLANE)
%   Returns the euclidean distance between point POINT and the plane PLANE,
%   given by: 
%   POINT : [x0 y0 z0]
%   PLANE : [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2]
%   D     : scalar  
%   
%   See also 
%   planes3d, points3d, intersectLinePlane

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-02-18
% Copyright 2005-2023 INRA - TPV URPOI - BIA IMASTE

% normalized plane normal
n = normalizeVector3d(cross(plane(:,4:6), plane(:, 7:9), 2));

% Uses Hessian form, ie : N.p = d
% I this case, d can be found as : -N.p0, when N is normalized
d = -sum(bsxfun(@times, n, bsxfun(@minus, plane(:,1:3), point)), 2);
