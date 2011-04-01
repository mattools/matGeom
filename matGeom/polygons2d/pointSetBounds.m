function box = pointSetBounds(points)
%POINTSETBOUNDS Bounding box of a set of points
%
%   BOX = pointSetBounds(POINTS)
%   Returns the bounding box of the set of points POINTS. POITNS can be
%   either a N-by-2 or N-by-3 array. The result BOX is a 1-by-4 or 1by-6
%   array, containing:
%   [XMIN XMAX YMIN YMAX] (2D point sets)
%   [XMIN XMAX YMIN YMAX ZMIN ZMAX] (3D point sets)
%
%   Example
%   pointSetBounds
%
%   See also
%   polygonBounds, drawBox
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-04-01,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% compute extreme x and y values
xmin = min(points(:,1));
xmax = max(points(:,1));
ymin = min(points(:,2));
ymax = max(points(:,2));
box = [xmin xmax ymin ymax];

% process case of 3D points
if size(points, 2) > 2
    zmin = min(points(:,3));
    zmax = max(points(:,3));
    box = [xmin xmax ymin ymax zmin zmax];
end
