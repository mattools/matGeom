function points = intersectLineCircle(line, circle)
%INTERSECTLINECIRCLE Intersection point(s) of a line and a circle
%
%   INTERS = intersectLineCircle(LINE, CIRCLE);
%   Returns a 2-by-2 array, containing on each row the coordinates of an
%   intersection point. If the line and circle do not intersect, the result
%   is filled with NaN.
%
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


% local precision
eps = 1e-14;

% center parameters
center = circle(:, 1:2);
radius = circle(:, 3);

% line parameters
dp = line(:, 1:2) - center;
vl = line(:, 3:4);

% coefficient of second order equation
a = sum(line(:, 3:4).^2, 2);
b = 2*sum(dp .* vl, 2);
c =  sum(dp.^2, 2) - radius.^2;

% discriminant
delta = b .^ 2 - 4 * a .* c;

if delta > eps
    % find two roots of second order equation
    u1 = (-b - sqrt(delta)) / 2 ./ a;
    u2 = (-b + sqrt(delta)) / 2 ./ a;
    
    % convert into 2D coordinate
    points = [line(1:2) + u1 * line(3:4) ; line(1:2) + u2 * line(3:4)];

elseif abs(delta) < eps
    % find unique root, and convert to 2D coord.
    u = -b / 2 ./ a;    
    points = line(1:2) + u*line(3:4);
    
else
    % fill with NaN
    points = NaN * ones(2, 2);
    return;
end

