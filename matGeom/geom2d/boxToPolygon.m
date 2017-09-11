function poly = boxToPolygon(box)
%BOXTOPOLYGON Convert a bounding box to a square polygon
%
%   poly = boxToPolygon(box)
%   Utility function that convert box data in [XMIN XMAX YMIN YMAX] format
%   to polygon data corresponding to the box boundary. The resulting POLY
%   is a 4-by-2 array.
%
%
%   Example
%     box = [ 10 50 20 40];
%     poly = boxToPolygon(box)
%     poly = 
%         10    20
%         50    20
%         50    40
%         10    40
%
%   See also
%     boxes2d, polygons2d, boxToRect
 
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2017-09-10,    using Matlab 8.6.0.267246 (R2015b)
% Copyright 2017 INRA - Cepia Software Platform.

% extreme coordinates
xmin = box(1);  
xmax = box(2);
ymin = box(3);  
ymax = box(4);

% convert to polygon
poly = [...
    xmin ymin; ...
    xmax ymin; ...
    xmax ymax; ...
    xmin ymax];