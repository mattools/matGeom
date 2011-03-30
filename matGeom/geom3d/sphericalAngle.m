function alpha = sphericalAngle(p1, p2, p3)
%SPHERICALANGLE Compute angle between points on the sphere
%
%   ALPHA = sphericalAngle(P1, P2, P3)
%   Compute angle (P1, P2, P3), i.e. the angle, measured at point P2,
%   between the direction P2 P1 and the direction P2 P3.
%   The result is given in radians, between 0 and 2*PI.
%
%   Points are given either as [x y z] (there will be normalized to lie on
%   the unit sphere), or as [phi theta], with phi being the longitude in [0
%   2*PI] and theta being the elevation on horizontal [-pi/2 pi/2].
%
%
%   NOTE: 
%   this is an 'oriented' version of the angle computation, that is, the
%   result of sphericalAngle(P1, P2, P3) equals
%   2*pi-sphericalAngle(P3,P2,P1). To have the more classical relation
%   (with results given betwen 0 and PI), it suffices to take the minimum
%   of angle and 2*pi-angle.
%   
%   See also:
%   angles3d, spheres
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 21/02/2005.
%

%   HISTORY
%   23/05/2006 fix bug for points with angle from center > pi/2

% test if points are given as matlab spherical coordinate
if size(p1, 2) ==2
    [x y z] = sph2cart(p1(:,1), p1(:,2));
    p1 = [x y z];
    [x y z] = sph2cart(p2(:,1), p2(:,2));
    p2 = [x y z];
    [x y z] = sph2cart(p3(:,1), p3(:,2));
    p3 = [x y z];
end

% normalize points
p1  = normalizeVector3d(p1);
p2  = normalizeVector3d(p2);
p3  = normalizeVector3d(p3);

% create the plane tangent to the unit sphere and containing central point
plane = createPlane(p2, p2);

% project the two other points on the plane
pi1 = planePosition(projPointOnPlane(p1, plane), plane);
pi3 = planePosition(projPointOnPlane(p3, plane), plane);

% compute angle on the tangent plane
alpha = angle3Points(pi1, [0 0], pi3);

