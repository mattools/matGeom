function point = circle3dPoint(circle, pos)
%CIRCLE3DPOINT Coordinates of a point on a 3D circle from its position.
%
%   output = circle3dPoint(input)
%
%   Example
%     % Draw some points on a 3D circle
%     figure('color','w'); hold on; view(130,-10);
%     circle = [10 20 30 50 90 45 0];
%     drawCircle3d(circle)
%     % origin point
%     pos1 = 0;
%     drawPoint3d(circle3dPoint(circle, pos1), 'ro')
%     % few points regularly spaced
%     drawPoint3d(circle3dPoint(circle, 10:10:40), '+')
%     % Draw point opposite to origin
%     drawPoint3d(circle3dPoint(circle, 180), 'k*')
%   
%
%   See also 
%   circles3d, circle3dPosition

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2011-06-21, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2023 INRA - Cepia Software Platform

pos=pos(:);

% extract circle coordinates
xc  = circle(1);
yc  = circle(2);
zc  = circle(3);
r   = circle(4);

theta   = circle(5);
phi     = circle(6);
psi     = circle(7);

% convert position to angle
t = pos * pi / 180;

% compute position on base circle
x   = r * cos(t);
y   = r * sin(t);
z   = zeros(length(pos),1);
pt0 = [x y z];

% compute transformation from local basis to world basis
trans   = localToGlobal3d(xc, yc, zc, theta, phi, psi);

% compute points of transformed circle
point   = transformPoint3d(pt0, trans);

