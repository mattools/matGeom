function theta = lineAngle(varargin)
%LINEANGLE Computes angle between two straight lines
%
%   A = lineAngle(LINE);
%   Returns the angle between horizontal, right-axis and the given line.
%   Angle is fiven in radians, between 0 and 2*pi, in counter-clockwise
%   direction.
%
%   A = lineAngle(LINE1, LINE2);
%   Returns the directed angle between the two lines. Angle is given in
%   radians between 0 and 2*pi, in counter-clockwise direction.
%
%   See also
%   lines2d, angles2d, createLine, normalizeAngle
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

%   HISTORY
%   2004-02-19 added support for multiple lines.
%   2011-01-20 use bsxfun

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
