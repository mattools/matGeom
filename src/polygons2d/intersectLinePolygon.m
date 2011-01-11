function intersects = intersectLinePolygon(line, poly)
%INTERSECTLINEPOLYGON get intersection points between a line and a polygon
%
%   P = intersectLinePolygon(LINE, POLY)
%   Returns the intersection points of the lines LINE with polygon POLY. 
%   LINE is a 1x4 array containing parametric representation of the line
%   (in the form [x0 y0 dx dy], see createLine for details). 
%   POLY is a NVx2 array containing coordinates of the NV polygon vertices
%   P is a NIx2 array containing the coordinates of the M intersection
%   points.
%
%   Example
%   % compute intersections between a square and an horizontal line
%   poly = [0 0;10 0;10 10;0 10];
%   line = [5 5 1 0];
%   intersectLinePolygon(line, poly)
%   ans =
%         10     5
%          0     5
%      
%   See also
%   lines2d, polygons2d, intersectLines, intersectRayPolygon
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

%   HISTORY
%   2008/11/24 rename 'pi' as 'intersects', update doc
%   2009/23/07 removed forgotten occurence of 'pi' variable (thanks to Bala
%       Krishnamoorthy)
%   2010/01/26 rewrite using vectorisation

% create the array of edges
N = size(poly, 1);
edges = [poly(1:N,:) poly([2:N 1], :)];

supportLines = edgeToLine(edges);
intersects = intersectLines(line, supportLines);
b = isPointOnEdge(intersects, edges);
intersects = intersects(b, :);
