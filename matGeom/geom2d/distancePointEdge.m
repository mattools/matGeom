function [dist pos] = distancePointEdge(point, edge)
%DISTANCEPOINTEDGE Minimum distance between a point and an edge
%
%   DIST = distancePointEdge(POINT, EDGE);
%   Return the euclidean distance between edge EDGE and point POINT. 
%   EDGE has the form: [x1 y1 x2 y2], and POINT is [x y].
%
%   If EDGE is N-by-4 array, result is 1-by-4 array computed for each edge.
%   If POINT is a N-by-2 array, the result is a N-by-1 array.
%   If both POINT and EDGE are array, the result is computed for each
%   point-edge couple, and stored into a NP-by-NE array.
%
%   [DIST POS] = distancePointEdge(POINT, EDGE);
%   Also returns the position of closest point on the edge. POS is
%   comprised between 0 (first point) and 1 (last point).
%
%   Eaxmple
%     % Distance between a point and an edge
%     distancePointEdge([3 4], [0 0 10 0])
%     ans =
%         4
%
%     % Distance between several points and one edge
%     points = [10 15; 15 10; 30 10];
%     edge   = [10 10 20 10];
%     distancePointEdge(points, edge)
%     ans = 
%         5 
%         0
%        10
%
%     % Distance between a point a several edges
%     point = [14 33];
%     edges  = [10 30 20 30; 20 30 20 40;20 40 10 40;10 40 10 30];
%     distancePointEdge(point, edges)
%     ans = 
%         3    6    7    4
%
%
%   See also:
%   edges2d, points2d, distancePoints, distancePointLine
%   
%
%   ---------
%   author : David Legland 
%   INRA - CEPIA URPOI - MIA MathCell
%   created the 07/04/2004.
%

%   HISTORY
%   2005-06-24 rename, and change arguments sequence
%   2009-04-30 add possibility to return position of closest point
%   2011-04-14 add checkup for degenerate edges, improve speed, update doc


% direction vector of each edge (row vectors)
vx = (edge(:, 3) - edge(:,1))';
vy = (edge(:, 4) - edge(:,2))';

% squared length of edges, with a check of validity
delta = vx .* vx + vy .* vy;
invalidEdges = delta < eps;
delta(invalidEdges) = 1; 

% difference of coordinates between point and edge first vertex 
% (NP-by-NE arrays)
dx  = bsxfun(@minus, point(:, 1), edge(:, 1)');
dy  = bsxfun(@minus, point(:, 2), edge(:, 2)');

% compute position of points projected on the supporting line, by using
% normalised dot product (NP-by-NE array)
pos = bsxfun(@rdivide, bsxfun(@times, dx, vx) + bsxfun(@times, dy, vy), delta);

% ensure degenerated edges are correclty processed (consider the first
% vertex is the closest)
pos(:, invalidEdges) = 0;

% change position to ensure projected point is located on the edge
pos(pos < 0) = 0;
pos(pos > 1) = 1;

% compute distance between point and its projection on the edge
dist = hypot(bsxfun(@times, pos, vx) - dx, bsxfun(@times, pos, vy) - dy);
