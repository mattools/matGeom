function theta = lineAngle(varargin)
%LINEANGLE Computes angle between two straight lines.
%
%   A = lineAngle(LINE);
%   Returns the angle between horizontal, right-axis and the given line.
%   Angle is given in radians, between 0 and 2*pi, in counter-clockwise
%   direction.
%
%   A = lineAngle(LINE1, LINE2);
%   Returns the directed angle between the two lines. Angle is given in
%   radians between 0 and 2*pi, in counter-clockwise direction.
%
%   See also
%   lines2d, angles2d, createLine, normalizeAngle

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2003-10-31
% Copyright 2003 INRA - TPV URPOI - BIA IMASTE

nargs = length(varargin);
if nargs == 1
    % angle of one line with horizontal
    line = varargin{1};
    theta = mod(atan2(line(:,4), line(:,3)) + 2*pi, 2*pi);
    
elseif nargs==2
    % angle between two lines
    theta1 = lineAngle(varargin{1});
    theta2 = lineAngle(varargin{2});
    theta = mod(bsxfun(@minus, theta2, theta1)+2*pi, 2*pi);
end
