function points = randomPointInBox(box, N, varargin)
%RANDOMPOINTINBOX Generate random point within a box
%
%   PTS = randomPointInBox(BOX)
%   Generate a random point within the box BOX. The result is a 1-by-2 row
%   vector.
%
%   PTS = randomPointInBox(BOX, N)
%   Generates N points within the box. The result is a N-by-2 array.
%
%   BOX has the format:
%   BOX = [xmin xmax ymin ymax].
%
%   Example
%     % draw points within a box
%     box = [10 80 20 60];
%     pts =  randomPointInBox(box, 500);
%     figure(1); clf; hold on;
%     drawBox(box);
%     drawPoint(pts, '.');
%     axis('equal');
%     axis([0 100 0 100]);
%
%   See also
%   points2d, boxes2d
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-10-10,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

if nargin < 2
    N = 1;
end

% extract box bounds
xmin = box(1);
xmax = box(2);
ymin = box(3);
ymax = box(4);

% compute size of box
dx = xmax - xmin;
dy = ymax - ymin;

% compute point coordinates
points = [rand(N, 1)*dx+xmin , rand(N, 1)*dy+ymin];
