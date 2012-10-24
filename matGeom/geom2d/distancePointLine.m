function [dist pos] = distancePointLine(point, line)
%DISTANCEPOINTLINE Minimum distance between a point and a line
%
%   D = distancePointLine(POINT, LINE)
%   Return the euclidean distance between line LINE and point POINT. 
%
%   LINE has the form : [x0 y0 dx dy], and POINT is [x y].
%
%   If LINE is N-by-4 array, result is N-by-1 array computes for each line.
%
%   If POINT is N-by-2, then result is computed for each point.
%
%   If both POINT and LINE are array, result is computed for each couple of
%   point and line, and is returned in a NP-by-NL array, where NP is the
%   number of points, and NL is the number of lines.
%
%
%   See also:
%   lines2d, points2d, distancePoints, distancePointEdge
%
%   
%   ---------
%   author : David Legland 
%   INRA - CEPIA URPOI - MIA MathCell
%   created the 24/06/2005
%

%   HISTORY:
%   2012-10-24 rewrite using bsxfun

% direction vector of each line (row vectors)
vx = line(:, 3)';
vy = line(:, 4)';

% squared length of edges, with a check of valifity
delta = (vx .* vx + vy .* vy);
invalidEdges = delta < eps;
delta(invalidEdges) = 1; 

% difference of coordinates between point and edge first vertex 
% (NP-by-NE arrays)
dx  = bsxfun(@minus, point(:, 1), line(:, 1)');
dy  = bsxfun(@minus, point(:, 2), line(:, 2)');

% compute position of points projected on the supporting line, by using
% normalised dot product (NP-by-NL array)
pos = bsxfun(@rdivide, bsxfun(@times, dx, vx) + bsxfun(@times, dy, vy), delta);

% ensure degenerated edges are correclty processed (consider the line
% origin as closest point)
pos(:, invalidEdges) = 0;

% compute distance between point and its projection on the edge
dist = hypot(bsxfun(@times, pos, vx) - dx, bsxfun(@times, pos, vy) - dy);


% if size(line, 1)==1 && size(point, 1)>1
%     line = repmat(line, [size(point, 1) 1]);
% end
% 
% if size(point, 1)==1 && size(line, 1)>1
%     point = repmat(point, [size(line, 1) 1]);
% end
% 
% dx = line(:, 3);
% dy = line(:, 4);
% 
% % compute position of points projected on line
% tp = ((point(:, 2) - line(:, 2)).*dy + (point(:, 1) - line(:, 1)).*dx) ./ (dx.*dx+dy.*dy);
% p0 = line(:, 1:2) + [tp tp].*[dx dy];
% 
% 
% % compute distances between points and their projections
% dx = point - p0;
% dist  = sqrt(sum(dx.*dx, 2));



