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
%   % base point
%   center = [10 0];
%   % create vertical line
%   l1 = [center 0 1];
%   % circle
%   c1 = [center 5];
%   pts = intersectLineCircle(l1, c1)
%   pts = 
%       10   -5
%       10    5
%   % draw the result
%   figure; clf; hold on;
%   axis([0 20 -10 10]);
%   drawLine(l1);
%   drawCircle(c1);
%   drawPoint(pts, 'rx');
%   axis equal;
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
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-01-14,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

%   HISTORY
%   2011-06-06 fix bug in delta test
%   15/04/2017: improved code by JuanPi Carbajal <ajuanpi+dev@gmail.com>

n = size (line, 1);
if n ~= size (circle, 1)
  error ('matGeom:invalid-input-arg', 'Function takes same number of lines and circles.');
endif

% circle parameters
center = circle(:, 1:2);
radius = circle(:, 3);

% line parameters
dp = line(:, 1:2) - center;
vl = line(:, 3:4);

% coefficient of second order equation
a = sum (line(:, 3:4).^2, 2);
b = 2 * sum (dp .* vl, 2);
c =  sum (dp.^2, 2) - radius.^2;

% discriminant
delta    = b .^ 2 - 4 * a .* c;
nn_delta = delta >= 0;          % nonnegative delta
nnn      = sum (nn_delta);

points = NA (2, 2, n);

if nnn > 0
  % roots
  u = -b(nn_delta) + bsxfun(@times, [-1 1], sqrt (delta(nn_delta)) );
  u = bsxfun (@rdivide, u, a(nn_delta)) / 2;

  if n == 1
    points = [line(1:2) + u(:,1) .* line(3:4); ...
              line(1:2) + u(:,2) .* line(3:4)];
  else
    tmp = [line(nn_delta,1:2) + u(:,1) .* line(nn_delta,3:4) ...
           line(nn_delta,1:2) + u(:,2) .* line(nn_delta,3:4)].';

    points(:,:, nn_delta) = permute (reshape ( tmp, [2,2,nnn]), [2 1 3]);
  end

end

