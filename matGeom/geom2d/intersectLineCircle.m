function points = intersectLineCircle(line, circle)
%INTERSECTLINECIRCLE Intersection point(s) of a line and a circle.
%
%   INTERS = intersectLineCircle(LINE, CIRCLE);
%   Returns a 2-by-2-by-N array, containing on each row the coordinates of
%   an intersection point for each line-circle pair, i.e. INTERS(:,:,k)
%   contains the intersections between LINE(k,:) and CIRCLE(k,:).
%
%   If a line-circle pair does not intersect, the corresponding results are
%   set to NaN. 
%
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
% Authors: David Legland, JuanPi Carbajal
% E-mail: david.legland@inrae.fr, ajuanpi+dev@gmail.com
% Created: 2011-01-14, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2023 INRA - Cepia Software Platform

  		  
% check size of inputs
nLines = size(line, 1);
nCircles = size(circle, 1);
if nLines ~= nCircles
  error ('matGeom:geom3d:invalidArguments', ...
      'Requires same number of lines and circles');
end
  		  
% center parameters
center = circle(:, 1:2);
radius = circle(:, 3);

% line parameters
dp = line(:, 1:2) - center;
vl = line(:, 3:4);

% coefficients of second order equation
a = sum(line(:, 3:4).^2, 2);
b = 2 * sum(dp .* vl, 2);
c = sum(dp.^2, 2) - radius.^2;

% discriminant
delta = b .^ 2 - 4 * a .* c;

points = nan(2, 2, nCircles);

valid = delta >= 0;

if any(valid)
    % compute roots (as a N-by-N-by-2 array)
    u = bsxfun(@plus, -b(valid), bsxfun(@times, [-1 1], sqrt(delta(valid))));
    u = bsxfun(@rdivide, u, a(valid)) / 2;

    if sum(valid) == 1
        points = [...
            line(1:2) + u(:,1) .* line(3:4); ...
            line(1:2) + u(:,2) .* line(3:4)];
    else
        tmp = [...
            line(valid, 1:2) + u(:,1) .* line(valid, 3:4) ...
            line(valid, 1:2) + u(:,2) .* line(valid, 3:4)].';
	    points(:, :, valid) = permute(reshape(tmp, [2, 2, nCircles]), [2 1 3]);
    end
end
