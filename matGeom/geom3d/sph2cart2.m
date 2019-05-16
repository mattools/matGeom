function varargout = sph2cart2(theta, phi, rho)
%SPH2CART2 Convert spherical coordinates to cartesian coordinates.
%
%   C = SPH2CART2(S)
%   C = SPH2CART2(THETA, PHI)       (assume rho = 1)
%   C = SPH2CART2(THETA, PHI, RHO)   
%   [X, Y, Z] = SPH2CART2(THETA, PHI, RHO);
%
%   S = [phi theta rho] (spherical coordinate).
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
%   See also:
%   angles3d, cart2sph2, sph2cart, sph2cart2d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

%   HISTORY
%   22/03/2005: make test for 2 args, and add radius if not specified for
%       1 arg.
%   03/11/2006: change convention for angle: uses order [THETA PHI RHO]

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

if nargout <= 1
    varargout{1} = [x, y, z];
else
    varargout{1} = x;
    varargout{2} = y;
    varargout{3} = z;
end
    
