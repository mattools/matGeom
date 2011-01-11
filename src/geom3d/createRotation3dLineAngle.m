function mat = createRotation3dLineAngle(line, theta)
%CREATEROTATION3DLINEANGLE Create rotation around a line by an angle theta
%
%   MAT = createRotation3dLineAngle(LINE, ANGLE)
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
%           1.015
%
%   See also
%   transforms3d, rotation3dAxisAndAngle, rotation3dToEulerAngles,
%   createEulerAnglesRotation
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-08-11,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% determine rotation center and direction
center = [0 0 0];
if size(line, 2)==6
    center = line(1:3);
    vector = line(4:6);
else
    vector = line;
end

% normalize vector
v = normalizeVector3d(vector);

% compute projection matrix P and anti-projection matrix
P = v'*v;
Q = [0 -v(3) v(2) ; v(3) 0 -v(1) ; -v(2) v(1) 0];
I = eye(3);

% compute vectorial part of the transform
mat = eye(4);
mat(1:3, 1:3) = P + (I - P)*cos(theta) + Q*sin(theta);

% add translation coefficient
mat = recenterTransform3d(mat, center);
