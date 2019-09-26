function [axis, theta] = rotation3dAxisAndAngle(mat)
%ROTATION3DAXISANDANGLE Determine axis and angle of a 3D rotation matrix.
%
%   [AXIS, ANGLE] = rotation3dAxisAndAngle(MAT)
%   Where MAT is a 4-by-4 matrix representing a rotation, computes the
%   rotation axis (containing the points that remain invariant under the
%   rotation), and the rotation angle around that axis.
%   AXIS has the format [DX DY DZ], constrained to unity, and ANGLE is the
%   rotation angle in radians.
%
%   Note: this method use eigen vector extraction. It would be more precise
%   to use quaternions, see:
%   http://www.mathworks.cn/matlabcentral/newsreader/view_thread/160945
%
%   
%   Example
%     origin = [1 2 3];
%     direction = [4 5 6];
%     line = [origin direction];
%     angle = pi/3;
%     rot = createRotation3dLineAngle(line, angle);
%     [axis angle2] = rotation3dAxisAndAngle(rot);
%     angle2
%     angle2 =
%           1.0472
%
%   See also
%   transforms3d, vectors3d, angles3d, eulerAnglesToRotation3d
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2010-08-11,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% extract the linear part of the rotation matrix
A = mat(1:3, 1:3);

% extract eigen values and eigen vectors
[V, D] = eig(A - eye(3));

% we need the eigen vector corresponding to eigenvalue==1
[dummy, ind] = min(abs(diag(D)-1)); %#ok<ASGLU>

% extract corresponding eigen vector
vector = V(:, ind)';

% compute rotation angle
t = [A(3,2)-A(2,3) , A(1,3)-A(3,1) , A(2,1)-A(1,2)];
theta = atan2(dot(t, vector), trace(A)-1);

% If angle is negative, invert both angle and vector direction
if theta<0
    theta  = -theta; 
    vector = -vector; 
end

% try to get a point on the line
% seems to work, but not sure about stability
[V, D] = eig(mat-eye(4)); %#ok<ASGLU>
origin = V(1:3,4)'/V(4, 4);

% create line corresponding to rotation axis
axis = [origin vector];

