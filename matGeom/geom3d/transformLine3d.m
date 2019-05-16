function res = transformLine3d(line, trans)
%TRANSFORMLINE3D Transform a 3D line with a 3D affine transform.
%
%   LINE2 = transformLine3d(LINE1, TRANS)
%
%   Example
%   P1 = [10 20 30];
%   P2 = [30 40 50];
%   L = createLine3d(P1, P2);
%   T = createRotationOx(P1, pi/6);
%   L2 = transformLine3d(L, T);
%   figure; hold on;
%   axis([0 100 0 100 0 100]); view(3);
%   drawPoint3d([P1;P2]);
%   drawLine3d(L, 'b');
%   drawLine3d(L2, 'm');
%
%   See also:
%   lines3d, transforms3d, transformPoint3d, transformVector3d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2008-11-25,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

res = [...
    transformPoint3d(line(:, 1:3), trans) ...   % transform origin point
    transformVector3d(line(:,4:6), trans)];     % transform direction vect.