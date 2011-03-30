function varargout = randomAngle3d(varargin)
%RANDOMANGLE3D Return a 3D angle uniformly distributed on unit sphere
%
%   usage
%   [THETA PHI] = randomAngle3d
%   Generate an angle unformly distributed on the surface of the unit
%   sphere.
%
%   "Mathematical" convention is used: theta is the colatitude (angle with
%   vertical axis, 0 for north pole, +pi for south pole, pi/2 for points at
%   equator) with z=0. 
%   phi is the same as matlab cart2sph: angle from Ox axis, counted
%   positively counter-clockwise.
%
%   [THETA PHI] = randomAngle3d(N)
%   generates N random angles (N is a scalar)
%
%   Example:
%   randomAngle3d
%
%   See also:
%   angles3d, sph2cart2, cart2sph2
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

%   HISTORY
%   04/01/2007: change angle order, update doc

N = 1;
if ~isempty(varargin)
    N = varargin(1);
end

phi = 2*pi*rand(N, 1);
theta = asin(2*rand(N, 1)-1) + pi/2;

if nargout<2
    var = [theta phi];
    varargout{1} = var;
else
    varargout{1} = theta;
    varargout{2} = phi;
end
