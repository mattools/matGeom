function varargout = cubicBezierToPolyline(points, varargin)
%CUBICBEZIERTOPOLYLINE Compute equivalent polyline from bezier curve control
%
%   POLY = cubicBezierToPolyline(POINTS, N)
%   Creates a polyline with N edges from the coordinates of the 4 control
%   points stored in POINTS. 
%   POINTS is either a 4-by-2 array (vertical concatenation of point
%   coordinates), or a 1-by-8 array (horizontal concatenation of point
%   coordinates). 
%   The result is a (N-1)-by-2 array.
%
%   POLY = cubicBezierToPolyline(POINTS)
%   Assumes N = 64 edges as default.
%
%   [X Y] = cubicBezierToPolyline(...)
%   Returns the result in two separate arrays for X and Y coordinates.
%
%
%   Example
%     poly = cubicBezierToPolyline([0 0;5 10;10 5;10 0], 100);
%     drawPolyline(poly, 'linewidth', 2, 'color', 'g');
%
%   See also
%     drawBezierCurve, drawPolyline
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-10-06,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% default number of discretization steps
N = 64;

% check if discretization step is specified
if ~isempty(varargin)
    var = varargin{1};
    if length(var) == 1 && isnumeric(var)
        N = round(var);
    end
end

% parametrization variable for bezier (use N+1 points to have N edges)
t = linspace(0, 1, N+1)';

% rename points
if size(points, 2)==2
    % case of points given as a 4-by-2 array
    p1 = points(1,:);
    c1 = points(2,:);
    c2 = points(3,:);
    p2 = points(4,:);
else
    % case of points given as a 1-by-8 array, [X1 Y1 CX1 CX2..]
    p1 = points(1:2);
    c1 = points(3:4);
    c2 = points(5:6);
    p2 = points(7:8);
end    

% compute coefficients of Bezier Polynomial, using polyval ordering
coef(4, 1) = p1(1);
coef(4, 2) = p1(2);
coef(3, 1) = 3 * c1(1) - 3 * p1(1);
coef(3, 2) = 3 * c1(2) - 3 * p1(2);
coef(2, 1) = 3 * p1(1) - 6 * c1(1) + 3 * c2(1);
coef(2, 2) = 3 * p1(2) - 6 * c1(2) + 3 * c2(2);
coef(1, 1) = p2(1) - 3 * c2(1) + 3 * c1(1) - p1(1);
coef(1, 2) = p2(2) - 3 * c2(2) + 3 * c1(2) - p1(2); 

% compute position of vertices
x = polyval(coef(:, 1), t);
y = polyval(coef(:, 2), t);

if nargout <= 1
    varargout = {[x y]};
else
    varargout = {x, y};
end
