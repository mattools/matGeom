function n = planeNormal(plane)
%PLANENORMAL Compute the normal to a plane
%
%   N = planeNormal(PLANE) 
%   compute the normal of the given plane
%   PLANE : [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2]
%   N : [dx dy dz]
%   
%   See also
%   planes3d, createPlane
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 17/02/2005.
%

%   HISTORY


% plane normal
n = cross(plane(:,4:6), plane(:, 7:9), 2);
