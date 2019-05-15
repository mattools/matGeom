function n = planeNormal(plane)
%PLANENORMAL Compute the normal to a plane.
%
%   N = planeNormal(PLANE) 
%   compute the normal of the given plane
%   PLANE : [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2]
%   N : [dx dy dz]
%   
%   See also
%   geom3d, planes3d, createPlane
%

%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 17/02/2005.
%

%   HISTORY
%   15/04/2013 Extended to N-dim planes by Sven Holcombe

% plane normal
outSz = size(plane);
outSz(2) = 3;
n = zeros(outSz);
n(:) = crossProduct3d(plane(:,4:6,:), plane(:, 7:9,:));
