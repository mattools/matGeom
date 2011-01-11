function circle = intersectPlaneSphere(plane, sphere)
%INTERSECTPLANESPHERE return intersection between a plane and a sphere
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
%   kept for compatibility with other functions). 
%   
%   See Also:
%   planes3d, spheres, circles3d, intersectLinePlane, intersectLineSphere
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

%   HISTORY
%   27/06/2007: change output format of circle, add support for multiple
%       data


% unify data dimension
if size(sphere, 1)==1
    sphere = repmat(sphere, [size(plane, 1) 1]);
elseif size(plane, 1)==1
    plane = repmat(plane, [size(sphere, 1) 1]);
elseif size(sphere, 1)~=size(plane, 1)    
    error('data should have same length, or one data should have length 1');
end

% center of the spheres
center  = sphere(:,1:3);

% radius of spheres
if size(sphere, 2)==4
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
[theta phi] = cart2sph2(nor(:,1), nor(:,2), nor(:,3));
psi = zeros(size(plane, 1), 1);

% create structure for circle
circle = [circle0 Rc theta phi psi];
