function dif = angleDiff(angle1, angle2)
%ANGLEDIFF Difference between two angles
%
%   Computes the signed angular difference between two angles in radians.
%   The result is comprised between -PI and +PI.
%
%   Example
%     A = angleDiff(-pi/4, pi/4)
%     A = 
%         1.5708    % equal to pi/2
%     A = angleDiff(pi/4, -pi/4)
%     A = 
%        -1.5708    % equal to -pi/2
%
%   See also
%   angles2d, angleAbsDiff
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-07-27,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% first, normalization
angle1 = normalizeAngle(angle1);
angle2 = normalizeAngle(angle2);

% compute difference and normalize in [-pi pi]
dif = normalizeAngle(angle2 - angle1, 0);
