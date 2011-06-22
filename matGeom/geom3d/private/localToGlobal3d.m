function trans = localToGlobal3d(varargin)
%LOCALTOGLOBAL3D Transformation matrix from local to global coordinate system
%
%   TRANS = localToGlobal3d(CENTER, THETA, PHI, PSI)
%   Compute the transformation matrix from a local (or modelling)
%   coordinate system to the global (or world) coordinate system.
%   This is a low-level function, used by several drawing functions.
%
%   The transform is defined by:
%   - CENTER: the position of the local origin into the World coordinate
%       system
%   - THETA: colatitude, defined as the angle with the Oz axis (between 0
%       and 180 degrees), positive in the direction of the of Oy axis.
%   - PHI: azimut, defined as the angle of the normal with the Ox axis,
%       between 0 and 360 degrees
%   - PSI: intrinsic rotation, corresponding to the rotation of the object
%       around the direction vector, between 0 and 360 degrees
%
%   The resulting transform is obtained by applying (in that order):
%   - Rotation by PSI   around he Z-axis
%   - Rotation by THETA around the Y-axis
%   - Rotation by PHI   around the Z-axis
%   - Translation by vector CENTER
%   This corresponds to Euler ZYZ rotation, using angles PHI, THETA and
%   PSI.
%
%   The 'createEulerAnglesRotation' function may better suit your needs as
%   it is more 'natural'.
%
%   Example
%   localToGlobal3d
%
%   See also
%   transforms3d, createEulerAnglesRotation
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-19,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

%   HISTORY
%   19/08/2009 fix bug in parsing center with 4 args
%   2011-06-21 use degrees

% extract the components of the transform
if nargin == 1
    % all components are bundled in  the first argument
    var     = varargin{1};
    center  = var(1:3);
    theta   = var(4);
    phi     = var(5);
    psi     = 0;
    if length(var) > 5
        psi = var(6);
    end
    
elseif nargin == 4
    % arguments = center, then the 3 angles
    center  = varargin{1};
    theta   = varargin{2};
    phi     = varargin{3};
    psi     = varargin{4};    
    
elseif nargin > 4
    % center is given in 3 arguments, then 3 angles
    center  = [varargin{1} varargin{2} varargin{3}];
    theta   = varargin{4};
    phi     = varargin{5};
    psi     = 0;
    if nargin > 5
        psi = varargin{6};    
    end
end
    
% conversion from degrees to radians
k = pi / 180;

% rotation around normal vector axis
rot1    = createRotationOz(psi * k);

% colatitude
rot2    = createRotationOy(theta * k);

% longitude
rot3    = createRotationOz(phi * k);

% shift center
tr      = createTranslation3d(center);

% create final transform by concatenating transforms
trans   = tr * rot3 * rot2 * rot1;
