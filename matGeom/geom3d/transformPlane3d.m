function plane2 = transformPlane3d(plane, trans)
%TRANSFORMPLANE3D Transform a 3D plane with a 3D affine transform
%
%   PLANE2 = transformPlane3d(PLANE, TRANS)
%
%   Example
%     p1 = [10 20 30];
%     p2 = [30 40 50];
%     p3 = [0 -10 -20];
%     plane = createPlane(p1, p2, p3);
%     rot = createRotationOx(p1, pi/6);
%     plane2 = transformPlane3d(plane, rot);
%     figure; hold on;
%     axis([0 100 0 100 0 100]); view(3);
%     drawPlane3d(plane, 'b');
%     drawPlane3d(plane2, 'm');
%
%   See also:
%   lines3d, transforms3d, transformPoint3d, transformVector3d,
%   transformLine3d
%

% ------
% Author: David Legland, oqilipo
% e-mail: david.legland@inra.fr
% Created: 2017-07-09
% Copyright 2017 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

plane2 = [...
    transformPoint3d( plane(:,1:3), trans) ...  % transform origin point
    transformVector3d(plane(:,4:6), trans) ...  % transform 1st dir. vect.
    transformVector3d(plane(:,7:9), trans)];    % transform 2nd dir. vect.