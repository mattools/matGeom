function varargout = circleArcToPolyline(arc, N)
%CIRCLEARCTOPOLYLINE Convert a circle arc into a series of points
%
%   P = circleArcToPolyline(ARC, N);
%   convert the circle ARC into a series of N points. 
%   ARC is given in the format: [XC YC R THETA1 DTHETA]
%   where XC and YC define the center of the circle, R its radius, THETA1
%   is the start of the arc and DTHETA is the angle extent of the arc. Both
%   angles are given in degrees. 
%   N is the number of vertices of the resulting polyline, default is 65.
%
%   The result is a N-by-2 array containing coordinates of the N points. 
%
%   [X Y] = circleArcToPolyline(ARC, N);
%   Return the result in two separate arrays with N lines and 1 column.
%
%
%   See also:
%   circles2d, circleToPolygon, drawCircle, drawPolygon
%
%
% ---------
% author : David Legland 
% created the 22/05/2006.
% Copyright 2010 INRA - Cepia Software Platform.
%

% HISTORY
% 2011-03-30 use angles in degrees, add default value for N
% 2011-12-09 rename to circleArcToPolyline


% default value for N
if nargin < 2
    N = 65;
end

% vector of positions
t0 = deg2rad(arc(4));
t1 = t0 + deg2rad(arc(5));
t = linspace(t0, t1, N)';

% compute coordinates of vertices
x = arc(1) + arc(3) * cos(t);
y = arc(2) + arc(3) * sin(t);

% format output
if nargout <= 1
    varargout = {[x y]};
else
    varargout = {x, y};
end
