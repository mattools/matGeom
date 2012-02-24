function box = polygonBounds(polygon)
%POLYGONBOUNDS Compute the bounding box of a polygon
%
%   BOX = polygonBounds(POLY);
%   Returns the bounding box of the polygon. 
%   BOX has the format: [XMIN XMAX YMIN YMAX].
%
%   Input polygon POLY is as a N-by-2 array containing coordinates of each
%   vertex. multiple polygons can be specified either by inserting NaN rows
%   between vertex coordinates, or by using a cell array, each cell
%   containing the vertex coordinates of a polygon loop.
%
%   See also
%   polygons2d, boxes2d, boundingBox
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-10-12,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - Cepia software platform


% transform as a cell array of simple polygons
polygons = splitPolygons(polygon);

% init extreme values
xmin = inf;
xmax = -inf;
ymin = inf;
ymax = -inf;

for i = 1:length(polygons)
    polygon = polygons{i};
    
    xmin = min(xmin, min(polygon(:,1)));
    xmax = max(xmax, max(polygon(:,1)));
    ymin = min(ymin, min(polygon(:,2)));
    ymax = max(ymax, max(polygon(:,2)));
end

box = [xmin xmax ymin ymax];
