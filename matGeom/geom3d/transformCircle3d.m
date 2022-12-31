function circle2 = transformCircle3d(circle, tfm)
%TRANSFORMCIRCLE3D Transform a 3D circle with a 3D affine transformation.
%
%   CIRCLE2 = transformPlane3d(CIRCLE, TFM)
%
%   Example
%     circle = [1 1 1 2 45 45 0];
%     tfm = createRotationOz(pi);
%     circle2 = transformCircle3d(circle, tfm);
%     figure('color','w'); hold on; axis equal tight; view(-10,25);
%     xlabel('x'); ylabel('y'); zlabel('z');
%     drawCircle3d(circle,'r'); drawPoint3d(circle(1:3),'r+')
%     drawCircle3d(circle2,'g'); drawPoint3d(circle2(1:3),'g+')
%
%   See also 
%     transforms3d, transformPoint3d, transformVector3d, transformLine3d, 
%     transformPlane3d
%

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2022-12-03, using MATLAB 9.13.0.2080170 (R2022b) Update 1
% Copyright 2022

parser = inputParser;
addRequired(parser, 'circle', @(x) validateattributes(x, {'numeric'},...
    {'ncols',7,'real','finite','nonnan'}));
addRequired(parser, 'tfm', @isTransform3d);
parse(parser, circle, tfm);
circle = parser.Results.circle;
tfm = parser.Results.tfm;

% Compute transformation from local basis to world basis
initialTfm = localToGlobal3d(circle(1:3), circle(5), circle(6), circle(7));
% Add the additional transformation
newTfm = tfm*initialTfm;

% Convert to Euler angles
[phi, theta, psi] = rotation3dToEulerAngles(newTfm, 'ZYZ');

% Create transformed circle
circle2 = [transformPoint3d(circle(1:3), tfm), circle(4), theta, phi, psi];
