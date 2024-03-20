function varargout = sph2cart2(theta, phi, rho)
%SPH2CART2 Convert spherical coordinates to cartesian coordinates.
%
%   C = SPH2CART2(S)
%   C = SPH2CART2(THETA, PHI)       (assuming rho = 1)
%   C = SPH2CART2(THETA, PHI, RHO)   
%   [X, Y, Z] = SPH2CART2(THETA, PHI, RHO);
%
%   S = [theta phi rho] (spherical coordinate).
%   C = [X Y Z]  (cartesian coordinate)
%
%   The following convention is used:
%   THETA is the colatitude, in radians, 0 for north pole, +pi for south
%   pole, pi/2 for points with z=0. 
%   PHI is the azimuth, in radians, defined as matlab cart2sph: angle from
%   Ox axis, counted counter-clockwise.
%   RHO is the distance of the point to the origin.
%   Discussion on choice for convention can be found at:
%   http://www.physics.oregonstate.edu/bridge/papers/spherical.pdf
%
%   Example
%     xyz = sph2cart2(pi/2, 0, 10)
%     xyz =
%        10.0000         0    0.0000
%
%     xyz = sph2cart2(pi/2, pi/2, 10)
%     xyz =
%         0.0000   10.0000    0.0000
%
%     % check consistency with cart2sph2
%     sph2cart2(cart2sph2(0.7, 0.8, 5))
%     ans =
%         0.7000    0.8000    5.0000
%
%   See also 
%     angles3d, cart2sph2, sph2cart, sph2cart2d, eulerAnglesToRotation3d
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2005-02-18
% Copyright 2005-2023 INRAE - BIA Research Unit - BIBS Platform (Nantes)

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
rz = rho .* sin(theta);
x  = rz  .* cos(phi);
y  = rz  .* sin(phi);
z  = rho .* cos(theta);

% format output
if nargout <= 1
    varargout{1} = [x, y, z];
else
    varargout{1} = x;
    varargout{2} = y;
    varargout{3} = z;
end
    
