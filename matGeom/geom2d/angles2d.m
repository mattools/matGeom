function angles2d
% Description of functions for manipulating angles.
%
%   Angles are normalized in an interval of width 2*PI. Most geom2d
%   functions return results in the [0 2*pi] interval, but it can be
%   convenient to consider the [-pi pi] interval as well. See the
%   normalizeAngle function to switch between conventions.
%
%   Angles are usually oriented. The default orientation is the CCW
%   (Counter-Clockwise) orientation.
%
%   See also:
%   normalizeAngle, angleDiff, angleAbsDiff, angleSort
%   angle2Points, angle3Points, vectorAngle, lineAngle, edgeAngle
%

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2010-03-31,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2010 INRA - Cepia Software Platform.


help('angles2d');