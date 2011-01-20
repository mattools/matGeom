function points = intersectCircles(circle1, circle2)
%INTERSECTCIRCLES Intersection points of two circles
%
%   POINTS = intersectCircles(CIRCLE1, CIRCLE2)
%
%   Example
%   c1 = [0  0 10];
%   c2 = [10 0 10];
%   pts = intersectCircles(c1, c2)
%   pts = 
%       5   -8.6603
%       5    8.6603
%
%   References
%   http://local.wasp.uwa.edu.au/~pbourke/geometry/2circle/
%   http://mathworld.wolfram.com/Circle-CircleIntersection.html
%
%   See also
%   circles2d, intersectLineCircle, radicalAxis
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-01-20,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


%TODO adapt sizes of inputs

% extract center and radius of each circle
center1 = circle1(:, 1:2);
center2 = circle2(:, 1:2);
r1 = circle1(:,3);
r2 = circle2(:,3);

% allocate memory for result
nPoints = length(r1);
points = NaN * ones(2*nPoints, 2);

% distance between circle centers
d12 = distancePoints(center1, center2);

% get indices of circle couples with intersections
inds = d12 > abs(r1 - r2) && d12 < (r1 + r2);

if sum(inds) == 0
    return;
end

% angle of line from center1 to center2
angle = angle2Points(center1(inds,:), center2(inds,:));

% position of intermediate point, located at the intersection of the
% radical axis with the line joining circle centers
d1m  = d12(inds) / 2 + (r1(inds).^2 - r2(inds).^2) / (2 * d12(inds));
tmp = polarPoint(center1(inds, :), d1m, angle);

% distance between intermediate point and each intersection point
h   = sqrt(r1(inds).^2 - d1m.^2);

% indices of valid intersections
inds2 = find(inds)*2;
inds1 = inds2 - 1;

% create intersection points
points(inds1, :) = polarPoint(tmp, h, angle - pi/2);
points(inds2, :) = polarPoint(tmp, h, angle + pi/2);
