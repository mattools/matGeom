function line = radicalAxis(circle1, circle2)
%RADICALAXIS Compute the radical axis (or radical line) of 2 circles
%
%   L = radicalAxis(C1, C2)
%   Computes the radical axis of 2 circles.
%
%   Example
%   C1 = [10 10 5];
%   C2 = [60 50 30];
%   L = radicalAxis(C1, C2);
%   hold on; axis equal;axis([0 100 0 100]); 
%   drawCircle(C1);drawCircle(C2);drawLine(L);
%
%   See also
%   lines2d, circles2d, createCircle
%
%   Ref:
%   http://mathworld.wolfram.com/RadicalLine.html
%   http://en.wikipedia.org/wiki/Radical_axis
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-05-15,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.
%

% extract circles parameters
x1 = circle1(:,1);
x2 = circle2(:,1);
y1 = circle1(:,2);
y2 = circle2(:,2);
r1 = circle1(:,3);
r2 = circle2(:,3);

% distance between each couple of centers
dist  = sqrt((x2-x1).^2 + (y2-y1).^2);

% relative position of intersection point of 
% the radical line with the line joining circle centers
d = (dist.^2 + r1.^2 - r2.^2) * .5 ./ dist;

% compute angle of radical axis
angle = lineAngle(createLine([x1 y1], [x2 y2]));
cot = cos(angle);
sit = sin(angle);

% parameters of the line
x0 = x1 + d*cot;
y0 = y1 + d*sit;
dx = -sit;
dy = cot;

% concatenate into one structure
line = [x0 y0 dx dy];
