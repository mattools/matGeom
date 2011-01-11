function theta = circle3dPosition(point, circle)
%CIRCLE3DPOSITION return the angular position of a point on a 3D circle
%
%   POS = circle3dPosition(POINT, CIRCLE)
%   with POINT: [xp yp zp]
%   and CIRCLE: [X0 Y0 Z0 R THETA PHI] or [X0 Y0 Z0 R THETA PHI PSI]
%   (THETA being the colatitude, and PHI the azimut)
%   return angular position of point on the circle, comprised between 0 and
%   2*PI.
%
%   See also:
%   circles3d, circle3dOrigin
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 21/02/2005
%

%   HISTORY
%   27/06/2007: change 3D angle convention


% get center and radius
xc = circle(:,1);
yc = circle(:,2);
zc = circle(:,3);

% get angle of normal
theta   = circle(:,5);
phi     = circle(:,6);

% find origin of the circle
ori     = circle3dOrigin(circle);

% create plane containing the circle
plane   = createPlane([xc yc zc], [theta phi]);

% find position of point on the circle plane
pp0     = planePosition(ori,    plane);
pp      = planePosition(point,  plane);

% compute angles in the planes
theta0  = mod(atan2(pp0(:,2), pp0(:,1)) + 2*pi, 2*pi);
theta   = mod(atan2(pp(:,2), pp(:,1)) + 2*pi - theta0, 2*pi);

