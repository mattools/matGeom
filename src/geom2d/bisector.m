function ray = bisector(varargin)
%BISECTOR Return the bisector of two lines, or 3 points
%
%   RAY = bisector(LINE1, LINE2);
%   create the bisector of the two lines, given as [x0 y0 dx dy].
%
%   RAY = bisector(P1, P2, P3);
%   create the bisector of lines (P2 P1) and (P2 P3).
%
%   The result has the form [x0 y0 dx dy], with [x0 y0] being the origin
%   point ans [dx dy] being the direction vector, normalized to have unit
%   norm.
%   
%   See also:
%   lines2d, rays2d
%
%   ---------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% created the 31/10/2003.
% Copyright 2010 INRA - Cepia Software Platform.

%   HISTORY
%   2005-07-07 add bisector of 3 points
%   2010-11-05 ode cleanup

if length(varargin)==2
    % two lines
    line1 = varargin{1};
    line2 = varargin{2};
    
    point = intersectLines(line1, line2);    
    
elseif length(varargin)==3
    % three points
    p1 = varargin{1};
    p2 = varargin{2};
    p3 = varargin{3};

    line1 = createLine(p2, p1);
    line2 = createLine(p2, p3);
    point = p2;
    
elseif length(varargin)==1
    % three points, given in one array
    var = varargin{1};
    p1 = var(1, :);
    p2 = var(2, :);
    p3 = var(3, :);

    line1 = createLine(p2, p1);
    line2 = createLine(p2, p3);
    point = p2;
end

% compute line angles
a1 = lineAngle(line1);
a2 = lineAngle(line2);

% compute bisector angle (angle of first line + half angle between lines)
angle = mod(a1 + mod(a2-a1+2*pi, 2*pi)/2, pi*2);

% create the resulting ray
ray = [point cos(angle) sin(angle)];
