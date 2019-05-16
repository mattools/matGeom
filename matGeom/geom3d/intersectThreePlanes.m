function point = intersectThreePlanes(plane1, plane2, plane3)
%INTERSECTTHREEPLANES Return intersection point between 3 planes in space.
%
%   LINE = intersectThreePlanes(PLANE1, PLANE2, PLANE3)
%   Returns the point or straight line belonging to three planes.
%   PLANE:  [x0 y0 z0  dx1 dy1 dz1  dx2 dy2 dz2]
%   POINT:  [x0 y0 z0]
%   IF rank of the coefficient matrix r1 = 3 and
%   Rank of the augmented matrix r2 = 3 return point
%   Otherwise returns point with NaN values.
%
%   See also:
%   planes3d, intersectPlanes, intersectLinePlane
%
%   ---------
%   author : Roozbeh Geraili Mikola
%   email  : roozbehg@berkeley.edu or roozbehg@live.com
%   created the 09/20/2017.
%

%   HISTORY

% plane normal
n1 = normalizeVector3d(cross(plane1(:,4:6), plane1(:, 7:9), 2));
n2 = normalizeVector3d(cross(plane2(:,4:6), plane2(:, 7:9), 2));
n3 = normalizeVector3d(cross(plane3(:,4:6), plane3(:, 7:9), 2));

% Uses Hessian form, ie : N.p = d
% I this case, d can be found as : -N.p0, when N is normalized
d1 = dot(n1, plane1(:,1:3), 2);
d2 = dot(n2, plane2(:,1:3), 2);
d3 = dot(n3, plane3(:,1:3), 2);

% create coefficient and augmented matrices
A = [n1;n2;n3];
D = [d1;d2;d3];
AD = [n1,d1;n2,d2;n3,d3];

% calculate rank of the coefficient and augmented matrices
r1 = rank(A);
r2 = rank(AD);

% if rank of the coefficient matrix r1 = 3 and
% rank of the augmented matrix r2 = 3 return point
% and if r1 = 2 and r2 = 2 return line, 
% otherwise returns point with NaN values.
if r1 == 3 && r2 == 3
    % Intersecting at a point
    point = (A\D)';
else
    point = [NaN NaN NaN];
end

