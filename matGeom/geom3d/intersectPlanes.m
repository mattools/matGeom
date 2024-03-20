function line = intersectPlanes(plane1, plane2, varargin)
%INTERSECTPLANES Return intersection line between 2 planes in space.
%
%   LINE = intersectPlanes(PLANE1, PLANE2)
%   Returns the straight line belonging to both planes.
%   PLANE:  [x0 y0 z0  dx1 dy1 dz1  dx2 dy2 dz2]
%   LINE:   [x0 y0 z0  dx dy dz]
%   In case of parallel planes, returns line with NaN values.
%
%   LINE = intersectPlanes(PLANE1, PLANE2, TOL)
%   Also specifies the tolerance for detecting parallel planes.
%
%   See also 
%   planes3d, lines3d, intersectLinePlane
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-02-17
% Copyright 2005-2023 INRA - TPV URPOI - BIA IMASTE

tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% plane normal
n1 = normalizeVector3d(cross(plane1(:,4:6), plane1(:, 7:9), 2));
n2 = normalizeVector3d(cross(plane2(:,4:6), plane2(:, 7:9), 2));

% test if planes are parallel
if abs(cross(n1, n2, 2)) < tol
    line = [NaN NaN NaN NaN NaN NaN];
    return;
end

% Uses Hessian form, ie : N.p = d
% I this case, d can be found as : -N.p0, when N is normalized
d1 = dot(n1, plane1(:,1:3), 2);
d2 = dot(n2, plane2(:,1:3), 2);

% compute dot products
dot1 = dot(n1, n1, 2);
dot2 = dot(n2, n2, 2);
dot12 = dot(n1, n2, 2);

% intermediate computations
det = dot1*dot2 - dot12*dot12;
c1  = (d1*dot2 - d2*dot12)./det;
c2  = (d2*dot1 - d1*dot12)./det;

% compute line origin and direction
p0  = c1*n1 + c2*n2;
dp  = cross(n1, n2, 2);

line = [p0 dp];
