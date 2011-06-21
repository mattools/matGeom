function ori = circle3dOrigin(varargin)
%CIRCLE3DORIGIN Return the first point of a 3D circle
%
%   P = circle3dOrigin([XC YC ZC R THETA PHI])
%   P = circle3dOrigin([XC YC ZC R THETA PHI PSI])
%   Returns the origin point of the circle, i.e. the first point used for
%   drawing circle.
%
%   See also:
%   circles3d, points3d, circle3dPosition
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 21/02/2005
%

%   HISTORY

% get center and radius
circle = varargin{1};
xc = circle(:,1);
yc = circle(:,2);
zc = circle(:,3);
r  = circle(:,4);

% get angle of normal
theta   = circle(:,5);
phi     = circle(:,6);

% get roll
if size(circle, 2)==7
    psi = circle(:,7);
else
    psi = zeros(size(circle, 1), 1);
end

% create origin point
pt0 = [r 0 0];

% compute transformation from local basis to world basis
trans   = localToGlobal3d(xc, yc, zc, theta, phi, psi);

% transform the point
ori = transformPoint3d(pt0, trans);
