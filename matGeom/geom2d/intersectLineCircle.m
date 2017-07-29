function points = intersectLineCircle(line, circle)
%INTERSECTLINECIRCLE Intersection point(s) of N lines and N circles
%
%   INTERS = intersectLineCircle(LINE, CIRCLE);
%   Returns a 2-by-2-by-N array @var{points}, containing on each row the
%   coordinates of an intersection point for each line-circle pair, i.e.
%   INTERS(:,:,k)} contains the intersections between LINE(k,:)
%   and CIRCLE(k,:).
%   If a line and a circle do not intersect, the result is NA.

%   Example
%     % base point
%     center = [10 0];
%     % create vertical line
%     l1 = [center 0 1];
%     % circle
%     c1 = [center 5];
%     pts = intersectLineCircle(l1, c1)
%     pts =
%     10   -5
%     10    5
%     % draw the result
%     figure; clf; hold on;
%     axis([0 20 -10 10]);
%     drawLine(l1);
%     drawCircle(c1);
%     drawPoint(pts, 'rx');
%     axis equal;
%
%   See also
%   lines2d, circles2d, intersectLines, intersectCircles
%
%   References
%   http://local.wasp.uwa.edu.au/~pbourke/geometry/sphereline/
%   http://mathworld.wolfram.com/Circle-LineIntersection.html
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-01-14,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% HISTORY
% 2011-06-06 fix bug in delta test
% 05/05/2017 included some suggestions from code by JuanPi Carbajal <ajuanpi+dev@gmail.com>

% check size of inputs
nLines = size(line, 1);
nCircles = size(circle, 1);
if nLines ~= nCircles
  error ('matGeom:geom2d:invalidArguments', ...
      'Requires same number of lines and circles');
end

% center parameters
center = circle(:, 1:2);
radius = circle(:, 3);

% line parameters
dp = line(:, 1:2) - center;
vl = line(:, 3:4);

% coefficient of second order equation
a = sum(line(:, 3:4).^2, 2);
b = 2*sum(dp .* vl, 2);
c = sum(dp.^2, 2) - radius.^2;

% discriminant
delta  = b .^ 2 - 4 * a .* c;

points = nan(2, 2, nCircles);

validInds = delta > 0;

if any(validInds)
    % compute roots
    u = bsxfun(@plus, -b(validInds), bsxfun(@times, [-1 1], sqrt(delta(validInds))));
    u = bsxfun(@rdivide, u, a(validInds)) / 2;

    if nCircles == 1
        points = [...
            line(1:2) + u(:,1) .* line(3:4); ...
            line(1:2) + u(:,2) .* line(3:4)];
    else
        tmp = [...
            line(validInds,1:2) + u(:,1) .* line(validInds,3:4) ...
            line(validInds,1:2) + u(:,2) .* line(validInds,3:4)].';
        points(:,:, validInds) = permute(reshape(tmp, [2,2, nCircles]), [2 1 3]);
    end
end
