function varargout = distancePointEdge(point, edge)
%DISTANCEPOINTEDGE Minimum distance between a point and an edge
%
%   DIST = distancePointEdge(POINT, EDGE);
%   Return the euclidean distance between edge EDGE and point POINT. 
%   EDGE has the form : [x1 y1 x2 y2], and POINT is [x y].
%   If EDGE is [Nx4] array, rsult is [Nx1] array computes for each edge.
%   If POINT is [Nx2], then result is computed for each point.
%   If both POINT and EDGE are array, result is [Nx1], computed for each
%   corresponding point and edge.
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

%   HISTORY:
%   24/06/2005: rename, and change arguments sequence
%   30/04/2009 add possibility to return position of closest point

% ensure inputs have consistent sizes
if size(edge, 1)==1 && size(point, 1)>1
    edge = repmat(edge, [size(point, 1) 1]);
end
if size(point, 1)==1 && size(edge, 1)>1
    point = repmat(point, [size(edge, 1) 1]);
end

% pre-allocate memory
N = size(edge, 1);
dist = zeros(N, 1);

% direction vector of each edge
dx = edge(:, 3)-edge(:,1);
dy = edge(:, 4)-edge(:,2);

% compute position of points projected on edge line
tp = ((point(:, 2) - edge(:, 2)).*dy + (point(:, 1) - edge(:, 1)).*dx) ./ (dx.*dx+dy.*dy);
p0 = edge(:, 1:2) + [tp tp].*[dx dy];

% find points before, on, and after the edge.
ind0 = tp<0;
ind  = tp>=0 & tp<=1;
ind1 = tp>1;

% compute distance, depending on which point (limit1, limit2, or projected
% point).
dist(ind0) = distancePoints(point(ind0, :), edge(ind0, 1:2), 'diag');
dist(ind)  = distancePoints(point(ind, :),  p0(ind, :), 'diag');
dist(ind1) = distancePoints(point(ind1, :), edge(ind1, 3:4), 'diag');

% process output arguments
varargout{1} = dist;
if nargout>1
    varargout{2} = min(max(tp, 0), 1);
end

