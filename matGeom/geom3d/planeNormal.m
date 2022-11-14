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

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2005-02-17.
% Copyright 2005 INRA - TPV URPOI - BIA IMASTE

%   HISTORY
%   15/04/2013 Extended to N-dim planes by Sven Holcombe

% plane normal
outSz = size(plane);
outSz(2) = 3;
n = zeros(outSz);
n(:) = crossProduct3d(plane(:,4:6,:), plane(:, 7:9,:));
