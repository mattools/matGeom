function circle = intersectPlaneSphere(plane, sphere)
%INTERSECTPLANESPHERE Return intersection circle between a plane and a sphere.
%
%   CIRC = intersectPlaneSphere(PLANE, SPHERE)
%   Returns the circle which is the intersection of the given plane
%   and sphere. 
%   PLANE  : [x0 y0 z0  dx1 dy1 dz1  dx2 dy2 dz2]
%   SPHERE : [XS YS ZS  RS]
%   CIRC   : [XC YC ZC  RC  THETA PHI PSI]
%   [x0 y0 z0] is the origin of the plane, [dx1 dy1 dz1] and [dx2 dy2 dz2]
%   are two direction vectors,
%   [XS YS ZS] are coordinates of the sphere center, RS is the sphere
%   radius, 
%   [XC YC ZC] are coordinates of the circle center, RC is the radius of
%   the circle, [THETA PHI] is the normal of the plane containing the
%   circle (THETA being the colatitude, and PHI the azimut), and PSI is a
%   rotation angle around the normal (equal to zero in this function, but
%   kept for compatibility with other functions). All angles are given in
%   degrees.
%   
%   See also 
%   planes3d, spheres, circles3d, intersectLinePlane, intersectLineSphere

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-02-18
% Copyright 2005-2022 INRA - TPV URPOI - BIA IMASTE

% number of inputs of each type
Ns = size(sphere, 1);
Np = size(plane, 1);

% unify data dimension
if Ns ~= Np 
    if Ns == 1
        sphere = sphere(ones(Np, 1), :);
    elseif Np == 1
        plane = plane(ones(Ns, 1), :);
    else
        error('data should have same length, or one data should have length 1');
    end
end
% center of the spheres
center  = sphere(:,1:3);

% radius of spheres
if size(sphere, 2) == 4
    Rs  = sphere(:,4);
else
    % assume default radius equal to 1
    Rs  = ones(size(sphere, 1), 1);
end

% projection of sphere center on plane -> gives circle center
circle0 = projPointOnPlane(center, plane);

% radius of circles
d   = distancePoints3d(center, circle0);
Rc  = sqrt(Rs.*Rs - d.*d);

% normal of planes = normal of circles
nor = planeNormal(plane);

% convert to angles
[theta, phi] = cart2sph2(nor(:,1), nor(:,2), nor(:,3));
psi = zeros(Np, 1);

% create structure for circle
k = 180 / pi;
circle = [circle0 Rc [theta phi psi]*k];
