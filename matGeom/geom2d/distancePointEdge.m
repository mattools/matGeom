function varargout = distancePointEdge(point, edge)
%DISTANCEPOINTEDGE Minimum distance between a point and an edge
%
%   DIST = distancePointEdge(POINT, EDGE);
%   Return the euclidean distance between edge EDGE and point POINT. 
%   EDGE has the form: [x1 y1 x2 y2], and POINT is [x y].
%
%   If EDGE is N-by-4 array, result is N-by-1 array computed for each edge.
%   If POINT is a N-by-2 array, the result is computed for each point.
%   If both POINT and EDGE are array, they must have the same number of
%   rows, and the result is computed for each couple point(i,:);edge(i,:).
%
%   [DIST POS] = distancePointEdge(POINT, EDGE);
%   Also returns the position of closest point on the edge. POS is
%   comprised between 0 (first point) and 1 (last point).
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

% direction vector of each edge
dx = edge(:, 3) - edge(:,1);
dy = edge(:, 4) - edge(:,2);

% compute position of points projected on the supporting line
% (Size of tp is the max number of edges or points)
delta = dx .* dx + dy .* dy;
tp = ((point(:, 1) - edge(:, 1)) .* dx + (point(:, 2) - edge(:, 2)) .* dy) ./ delta;

% ensure degenerated edges are correclty processed (consider the first
% vertex is the closest)
tp(delta < eps) = 0;

% change position to ensure projected point is located on the edge
tp(tp < 0) = 0;
tp(tp > 1) = 1;

% coordinates of projected point
p0 = [edge(:,1) + tp .* dx, edge(:,2) + tp .* dy];

% compute distance between point and its projection on the edge
dist = sqrt((point(:,1) - p0(:,1)) .^ 2 + (point(:,2) - p0(:,2)) .^ 2);

% process output arguments
varargout{1} = dist;
if nargout > 1
    varargout{2} = tp;
end
