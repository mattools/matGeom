function varargout = cart2sph2(varargin)
%CART2SPH2 Convert cartesian coordinates to spherical coordinates.
%
%   [THETA PHI RHO] = cart2sph2([X Y Z])
%   [THETA PHI RHO] = cart2sph2(X, Y, Z)
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
%   Example:
%   cart2sph2([1 0 0])  returns [pi/2 0 1];
%   cart2sph2([1 1 0])  returns [pi/2 pi/4 sqrt(2)];
%   cart2sph2([0 0 1])  returns [0 0 1];
%
%   See also:
%   angles3d, sph2cart2, cart2sph, cart2sph2d
%

%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

%   HISTORY
%   02/11/2006: update doc, and manage case RHO is empty
%   03/11/2006: change convention for angle : uses order [THETA PHI RHO]
%   27/06/2007: manage 2 output arguments

if length(varargin)==1
    var = varargin{1};
elseif length(varargin)==3
    var = [varargin{1} varargin{2} varargin{3}];
end

if size(var, 2)==2
    var(:,3)=1;
end

[p, t, r] = cart2sph(var(:,1), var(:,2), var(:,3));

if nargout == 1 || nargout == 0
    varargout{1} = [pi/2-t p r];
elseif nargout==2
    varargout{1} = pi/2-t;
    varargout{2} = p;
else
    varargout{1} = pi/2-t;
    varargout{2} = p;
    varargout{3} = r;
end
    