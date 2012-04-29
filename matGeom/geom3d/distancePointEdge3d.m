function varargout = distancePointEdge3d(point, edge)
%DISTANCEPOINTEDGE3D Minimum distance between a 3D point and a 3D edge
%
%   DIST = distancePointEdge3d(POINT, EDGE);
%   Return the euclidean distance between edge EDGE and point POINT. 
%   EDGE has the form: [x1 y1 z1 x2 y2 z2], and POINT is [x y z].
%
%   If EDGE is N-by-6 array, result is N-by-1 array computed for each edge.
%   If POINT is a N-by-3 array, the result is computed for each point.
%   If both POINT and EDGE are array, they must have the same number of
%   rows, and the result is computed for each couple point(i,:);edge(i,:).
%
%   [DIST POS] = distancePointEdge3d(POINT, EDGE);
%   Also returns the position of closest point on the edge. POS is
%   comprised between 0 (first point) and 1 (last point).
%
%   See also:
%   edges3d, points3d, distancePoints3d, distancePointLine3d
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
vl = edge(:, 4:6) - edge(:, 1:3);

% compute position of points projected on the supporting line
% (Size of t is the max number of edges or points)
t = linePosition3d(point, [edge(:,1:3) vl]);

% ensure degenerated edges are correclty processed (consider the first
% vertex is the closest)
delta = vectorNorm3d(vl);
t(delta < eps) = 0;

% change position to ensure projected point is located on the edge
t(t < 0) = 0;
t(t > 1) = 1;

% coordinates of projected point
p0 = bsxfun(@plus, edge(:,1:3), [t .* vl(:,1) t .* vl(:,2) t .* vl(:,3)]);

% compute distance between point and its projection on the edge
dist = sqrt((point(:,1) - p0(:,1)) .^ 2 + (point(:,2) - p0(:,2)) .^ 2 + (point(:,3) - p0(:,3)) .^ 2);

% process output arguments
varargout{1} = dist;
if nargout > 1
    varargout{2} = t;
end
