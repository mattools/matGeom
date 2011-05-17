function res = isCounterClockwise(p1, p2, p3, varargin)
%ISCOUNTERCLOCKWISE Compute relative orientation of 3 points
%
%   CCW = isCounterClockwise(P1, P2, P3);
%   Computes the orientation of the 3 points. The returns is:
%   +1 if the path P1->P2->P3 turns Counter-Clockwise (i.e., the point P3
%       is located "on the left" of the line P1-P2)
%   -1 if the path turns Clockwise (i.e., the point P3 lies "on the right"
%       of the line P1-P2) 
%   0  if the point P3 is located on the line segment [P1 P2].
%
%   This function can be used in more complicated algorithms: detection of
%   line segment intersections, convex hulls, point in triangle...
%
%   CCW = isCounterClockwise(P1, P2, P3, EPS);
%   Specifies the threshold used for detecting colinearity of the 3 points.
%   Default value is 1e-12 (absolute).
%
%   Example
%   isCounterClockwise([0 0], [10 0], [10 10])
%   ans = 
%       1
%   isCounterClockwise([0 0], [0 10], [10 10])
%   ans = 
%       -1
%   isCounterClockwise([0 0], [10 0], [5 0])
%   ans = 
%       0
%
%   See also
%   points2d, isPointOnLine, isPointInTriangle
%
%   References
%   Algorithm adapated from Sedgewick's book.
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-04-09
% Copyright 2011 INRA - Cepia Software Platform.


%   HISTORY
%   2011-05-16 change variable names, add support for point arrays


% get threshold value
eps = 1e-12;
if ~isempty(varargin)
    eps = varargin{1};
end

% ensure all data have same size
np = max([size(p1, 1) size(p2, 1) size(p3,1)]);
if np > 1
    if size(p1,1) == 1
        p1 = repmat(p1, np, 1);
    end
    if size(p2,1) == 1
        p2 = repmat(p2, np, 1);
    end
    if size(p3,1) == 1
        p3 = repmat(p3, np, 1);
    end    
end

% init with 0
res = zeros(np, 1);

% extract vector coordinates
x0  = p1(:, 1);
y0  = p1(:, 2);
dx1 = p2(:, 1) - x0;
dy1 = p2(:, 2) - y0;
dx2 = p3(:, 1) - x0;
dy2 = p3(:, 2) - y0;

% check non colinear cases
res(dx1 .* dy2 > dy1 .* dx2) =  1;
res(dx1 .* dy2 < dy1 .* dx2) = -1;

% case of colinear points
ind = abs(dx1 .* dy2 - dy1 .* dx2) < eps;
res(ind( (dx1(ind) .* dx2(ind) < 0) | (dy1(ind) .* dy2(ind) < 0) )) = -1;
res(ind(  hypot(dx1(ind), dy1(ind)) <  hypot(dx2(ind), dy2(ind)) )) =  1;
