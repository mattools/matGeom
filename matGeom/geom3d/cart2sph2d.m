function varargout = cart2sph2d(x, y, z)
%CART2SPH2D Convert cartesian coordinates to spherical coordinates in degrees
%
%   [THETA PHI RHO] = cart2sph2d([X Y Z])
%   [THETA PHI RHO] = cart2sph2d(X, Y, Z)
%
%   The following convention is used:
%   THETA is the colatitude, in degrees, 0 for north pole, 180 degrees for
%   south pole, 90 degrees for points with z=0.
%   PHI is the azimuth, in degrees, defined as matlab cart2sph: angle from
%   Ox axis, counted counter-clockwise.
%   RHO is the distance of the point to the origin.
%   Discussion on choice for convention can be found at:
%   http://www.physics.oregonstate.edu/bridge/papers/spherical.pdf
%
%   Example:
%     cart2sph2d([1 0 0])
%     ans =
%       90   0   1
%
%     cart2sph2d([1 1 0])
%     ans =
%       90   45   1.4142
%
%     cart2sph2d([0 0 1])
%     ans =
%       0    0    1
%
%
%   See also:
%   angles3d, sph2cart2d, cart2sph, cart2sph2
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-29,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% if data are grouped, extract each coordinate
if nargin == 1
    y = x(:, 2);
    z = x(:, 3);
    x = x(:, 1);
end

% cartesian to spherical conversion
hxy     = hypot(x, y);
rho     = hypot(hxy, z);
theta   = 90 - atan2(z, hxy) * 180 / pi;
phi     = atan2(y, x) * 180 / pi;

% % convert to degrees and theta to colatitude
% theta   = 90 - rad2deg(theta);
% phi     = rad2deg(phi);

% format output
if nargout <= 1
    varargout{1} = [theta phi rho];
    
elseif nargout == 2
    varargout{1} = theta;
    varargout{2} = phi;
    
else
    varargout{1} = theta;
    varargout{2} = phi;
    varargout{3} = rho;
end
    