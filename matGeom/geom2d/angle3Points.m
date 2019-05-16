function theta = angle3Points(varargin)
%ANGLE3POINTS Compute oriented angle made by 3 points.
%
%   ALPHA = angle3Points(P1, P2, P3);
%   Computes the angle between the points P1, P2 and P3.
%   Pi are either [1*2] arrays, or [N*2] arrays, in this case ALPHA is a 
%   [N*1] array. The angle computed is the directed angle between line 
%   (P2P1) and line (P2P3).
%   Result is always given in radians, between 0 and 2*pi.
%
%   See Also:
%   points2d, angles2d, angle2points
%
%
%   ---------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% created the 23/02/2004.
% Copyright 2010 INRA - Cepia Software Platform.


%   HISTORY :
%   25/09/2005 : enable single parameter

if length(varargin)==3
    p1 = varargin{1};
    p2 = varargin{2};
    p3 = varargin{3};
elseif length(varargin)==1
    var = varargin{1};
    p1 = var(1,:);
    p2 = var(2,:);
    p3 = var(3,:);
end    

% angle line (P2 P1)
theta = lineAngle(createLine(p2, p1), createLine(p2, p3));

