function varargout = rotation3dToEulerAngles(mat)
%ROTATION3DTOEULERANGLES Extract Euler angles from a rotation matrix
%
%   [PHI, THETA, PSI] = rotation3dToEulerAngles(MAT)
%
%   Example
%   rotation3dToEulerAngles
%
%   References
%   Code from Graphics Gems IV on euler angles
%   http://tog.acm.org/resources/GraphicsGems/gemsiv/euler_angle/EulerAngles.c
%
%   See also
%   transforms3d, rotation3dAxisAndAngle, createRotation3dLineAngle,
%   createEulerAnglesRotation
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-08-11,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.


% extract |cos(theta)|
cy = hypot(mat(1, 1), mat(2, 1));

% avoid dividing by 0
if cy > 16*eps
    % normal case: theta <> 0
    phi     = atan2( mat(3, 2), mat(3, 3));
    theta   = atan2(-mat(3, 1), cy);
    psi     = atan2( mat(2, 1), mat(1, 1));
else
    
    phi     = atan2(-mat(2, 3), mat(2, 2));
    theta   = atan2(-mat(3, 1), cy);
    psi     = 0;
end

% format output arguments
if nargout<=1
    varargout{1} = [phi theta psi];
else
    varargout = {phi, theta, psi};
end
