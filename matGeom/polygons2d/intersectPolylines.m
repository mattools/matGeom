function pts = intersectPolylines(poly1, varargin)
%INTERSECTPOLYLINES Find the common points between 2 polylines
%
%   INTERS = intersectPolylines(POLY1, POLY2)
%   Returns the intersection points between two polylines. Each polyline is
%   defined by a N-by-2 array representing coordinates of its vertices: 
%   [X1 Y1 ; X2 Y2 ; ... ; XN YN]
%   INTERS is a NP-by-2 array containing coordinates of intersection
%   points.
%
%   INTERS = intersectPolylines(POLY1)
%   Compute self-intersections of the polyline.
%
%   Example
%   % Compute intersection points between 2 simple polylines
%     poly1 = [20 10 ; 20 50 ; 60 50 ; 60 10];
%     poly2 = [10 40 ; 30 40 ; 30 60 ; 50 60 ; 50 40 ; 70 40];
%     pts = intersectPolylines(poly1, poly2);
%     figure; hold on; 
%     drawPolyline(poly1, 'b');
%     drawPolyline(poly2, 'm');
%     drawPoint(pts);
%     axis([0 80 0 80]);
%
%   See also
%   polygons2d, polylineSelfIntersections, intersectLinePolygon
%
%   This function uses the 'interX' function, found on the FileExchange,
%   and stored in 'private' directory of this function.
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-15,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

if isempty(varargin)
    % Compute self-intersections
    pts = InterX(poly1')';
    
else
    % compute intersection between two lines
    pts = InterX(poly1', varargin{1}')';
end
