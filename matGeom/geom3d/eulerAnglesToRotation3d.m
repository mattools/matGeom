function mat = eulerAnglesToRotation3d(phi, theta, psi, varargin)
%EULERANGLESTOROTATION3D Convert 3D Euler angles to 3D rotation matrix
%
%   MAT = eulerAnglesToRotation3d(PHI, THETA, PSI)
%   Creates a rotation matrix from the 3 euler angles PHI THETA and PSI,
%   given in degrees, using the 'XYZ' convention (local basis), or the
%   'ZYX' convention (global basis). The result MAT is a 4-by-4 rotation
%   matrix in homogeneous coordinates.
%
%   PHI:    rotation angle around Z-axis, in degrees, corresponding to the
%       'Yaw'. PHI is between -180 and +180.
%   THETA:  rotation angle around Y-axis, in degrees, corresponding to the
%       'Pitch'. THETA is between -90 and +90.
%   PSI:    rotation angle around X-axis, in degrees, corresponding to the
%       'Roll'. PSI is between -180 and +180. 
%   These angles correspond to the "Yaw-Pitch-Roll" convention, also known
%   as "Tait–Bryan angles". 
%
%   The resulting rotation is equivalent to a rotation around X-axis by an
%   angle PSI, followed by a rotation around the Y-axis by an angle THETA,
%   followed by a rotation around the Z-axis by an angle PHI. 
%   That is:
%       ROT = Rz * Ry * Rx;
%
%   MAT = eulerAnglesToRotation3d(ANGLES)
%   Concatenates all angles in a single 1-by-3 array.
%
%   Example
%   [n e f] = createCube;
%   phi     = 20;
%   theta   = 30;
%   psi     = 10;
%   rot = eulerAnglesToRotation3d(phi, theta, psi);
%   n2 = transformPoint3d(n, rot);
%   drawPolyhedron(n2, f);
%
%   See also
%   transforms3d, createRotationOx, createRotationOy, createRotationOz
%   rotation3dAxisAndAngle
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-07-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

%   HISTORY
%   2011-06-20 rename and use degrees


% Process input arguments
if size(phi, 2) == 3
    % manages arguments given as one array
    theta   = phi(:, 2);
    psi     = phi(:, 3);
    phi     = phi(:, 1);
end

% create individual rotation matrices
k = pi / 180;
rotX = createRotationOx(psi * k);
rotY = createRotationOy(theta * k);
rotZ = createRotationOz(phi * k);

% concatenate matrices
mat = rotZ * rotY * rotX;
