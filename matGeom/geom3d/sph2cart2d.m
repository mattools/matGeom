function varargout = sph2cart2d(theta, phi, rho)
%SPH2CART2D Convert spherical coordinates to cartesian coordinates in degrees.
%
%   C = SPH2CART2(THETA, PHI, RHO)
%   C = SPH2CART2(THETA, PHI)       (assume rho = 1)
%   C = SPH2CART2(S)
%   [X, Y, Z] = SPH2CART2(THETA, PHI, RHO);
%
%   S = [phi theta rho] (spherical coordinate).
%   C = [X Y Z]  (cartesian coordinate)
%
%   The following convention is used:
%   THETA is the colatitude, in degrees, 0 for north pole, +180 degrees for
%   south pole, +90 degrees for points with z=0. 
%   PHI is the azimuth, in degrees, defined as matlab cart2sph: angle from
%   Ox axis, counted counter-clockwise.
%   RHO is the distance of the point to the origin.
%   Discussion on choice for convention can be found at:
%   http://www.physics.oregonstate.edu/bridge/papers/spherical.pdf
%
%   See also:
%   angles3d, cart2sph2d, sph2cart2
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-29,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% Process input arguments
if nargin == 1
    phi     = theta(:, 2);
    if size(theta, 2) > 2
        rho = theta(:, 3);
    else
        rho = ones(size(phi));
    end
    theta   = theta(:, 1);
    
elseif nargin == 2
    rho     = ones(size(theta));
    
end

% conversion
rz = rho .* sind(theta);
x  = rz  .* cosd(phi);
y  = rz  .* sind(phi);
z  = rho .* cosd(theta);

% Process output arguments
if nargout == 1 || nargout == 0
    varargout{1} = [x, y, z];
    
else
    varargout{1} = x;
    varargout{2} = y;
    varargout{3} = z;
end
    
