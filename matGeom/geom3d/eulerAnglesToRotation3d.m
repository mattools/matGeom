function mat = eulerAnglesToRotation3d(phi, theta, psi, varargin)
%EULERANGLESTOROTATION3D Convert 3D Euler angles to 3D rotation matrix.
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
%   as "Tait-Bryan angles".
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
%   ... = eulerAnglesToRotation3d(ANGLES, CONVENTION)
%   CONVENTION specifies the axis rotation sequence. Default is 'ZYX'.
%   Supported conventions are: 
%       'ZYX','ZXY','YXZ','YZX','XYZ','XZY'
%       'ZYZ','ZXZ','YZY','YXY','XZX','XYX'
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
% E-mail: david.legland@inrae.fr
% Created: 2010-07-22, using Matlab 7.9.0.529 (R2009b)
% Copyright 2010-2023 INRA - Cepia Software Platform

% Process input arguments
if size(phi, 2) == 3
    if nargin > 1
        varargin{1} = theta;
    end
    % manages arguments given as one array
    psi     = phi(:, 3);
    theta   = phi(:, 2);
    phi     = phi(:, 1);
end

p = inputParser;
validStrings = {...
    'ZYX','ZXY','YXZ','YZX','XYZ','XZY',...
    'ZYZ','ZXZ','YZY','YXY','XZX','XYX'};
addOptional(p,'convention','ZYX',@(x) any(validatestring(x,validStrings)));
parse(p,varargin{:});
convention=p.Results.convention;

% create individual rotation matrices
k = pi / 180;

switch convention
    case 'ZYX'
        rot1 = createRotationOx(psi * k);
        rot2 = createRotationOy(theta * k);
        rot3 = createRotationOz(phi * k);
    case 'ZXY'
        rot1 = createRotationOy(psi * k);
        rot2 = createRotationOx(theta * k);
        rot3 = createRotationOz(phi * k);
    case 'YXZ'
        rot1 = createRotationOz(psi * k);
        rot2 = createRotationOx(theta * k);
        rot3 = createRotationOy(phi * k);
    case 'YZX'
        rot1 = createRotationOx(psi * k);
        rot2 = createRotationOz(theta * k);
        rot3 = createRotationOy(phi * k);
    case 'XYZ'
        rot1 = createRotationOz(psi * k);
        rot2 = createRotationOy(theta * k);
        rot3 = createRotationOx(phi * k);
    case 'XZY'
        rot1 = createRotationOy(psi * k);
        rot2 = createRotationOz(theta * k);
        rot3 = createRotationOx(phi * k);
    case 'ZYZ'
        rot1 = createRotationOz(psi * k);
        rot2 = createRotationOy(theta * k);
        rot3 = createRotationOz(phi * k);
    case 'ZXZ'
        rot1 = createRotationOz(psi * k);
        rot2 = createRotationOx(theta * k);
        rot3 = createRotationOz(phi * k);
    case 'YZY'
        rot1 = createRotationOy(psi * k);
        rot2 = createRotationOz(theta * k);
        rot3 = createRotationOy(phi * k);
    case 'YXY'
        rot1 = createRotationOy(psi * k);
        rot2 = createRotationOx(theta * k);
        rot3 = createRotationOy(phi * k);
    case 'XZX'
        rot1 = createRotationOx(psi * k);
        rot2 = createRotationOz(theta * k);
        rot3 = createRotationOx(phi * k);
    case 'XYX'
        rot1 = createRotationOx(psi * k);
        rot2 = createRotationOy(theta * k);
        rot3 = createRotationOx(phi * k);
end

% concatenate matrices
mat = rot3 * rot2 * rot1;
