function [dists, neighInds] = nndist(points)
%NNDIST Nearest-neighbor distances of each point in a set
%
%   DISTS = nndist(POINTS)
%   Returns the distance to the nearest neighbor of each point in an array
%   of points.
%   POINTS is an array of points, NP-by-ND.
%   DISTS is a NP-by-1 array containing the distances to the nearest
%   neighbor.
%
%   This functions first computes the Delaunay triangulation of the set of
%   points, then search for nearest distance in the set of each vertex
%   neighbors. This reduces the overall complexity, but difference was
%   noticed only for large sets (>10000 points)
%
%   Example
%     % Display Stienen diagram of a set of random points in unit square
%     pts = rand(100, 2);
%     [dists, inds] = nndist(pts);
%     figure; drawPoint(pts, 'k.');
%     hold on; drawCircle([pts dists/2], 'b');
%     axis equal; axis([-.1 1.1 -.1 1.1]);
%     % also display edges
%     drawEdge([pts pts(inds, :)], 'b');
%
%   See also
%     points2d, distancePoints, minDistancePoints, findPoint
%

% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2011-12-01,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% number of points
n = size(points, 1);

% allocate memory
dists = zeros(n, 1);
neighInds = zeros(n, 1);

% in case of few points, use direct computation
if n < 3
    inds = 1:n;
    for i = 1:n
        % compute minimal distance
        [dists(i), indN] = minDistancePoints(points(i,:), points(inds~=i, :));
        if indN >= i
            neighInds(i) = inds(indN) + 1;
        else
            neighInds(i) = inds(indN);
        end
    end
    return;
end

% use Delaunay Triangulation to facilitate computations
DT = delaunayTriangulation(points);

% compute distance to nearest neighbor of each point in the pattern
for i = 1:n
    % find indices of neighbor vertices in Delaunay Triangulation.
    % this set contains the nearest neighbor
    inds = unique(DT.ConnectivityList(sum(DT.ConnectivityList == i, 2) > 0, :));
    inds = inds(inds~=i);
    
    % compute minimal distance 
    [dists(i), indN] = min(distancePoints(points(i,:), points(inds, :)));
    neighInds(i) = inds(indN);
end
