function points = clipPoints(points, box)
%CLIPPOINTS Clip a set of points by a box
%
%   CLIP = clipPoints(POINTS, BOX);
%   Returns the set of points which are located inside of the box BOX.
%
%
%   See also
%   points2d, boxes2d, clipLine, drawPoint
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2010 INRA - Cepia Software Platform.

% get bounding box limits
xmin = box(1);
xmax = box(2);
ymin = box(3);
ymax = box(4);

% compute indices of points inside visible area
xOk = points(:,1)>=xmin & points(:,1)<=xmax;
yOk = points(:,2)>=ymin & points(:,2)<=ymax;

% keep only points inside box
points = points(xOk & yOk, :);
