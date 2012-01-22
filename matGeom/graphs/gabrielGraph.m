function varargout = gabrielGraph(pts)
%GABRIELGRAPH  Gabriel Graph of a set of points
%
%   EDGES = gabrielGraph(PTS)
%   Computes the Gabriel graph of the input set of points PTS. The Gabriel
%   graph is based on the euclidean Delaunay triangulation, and keeps only
%   edges whose circumcircle does not contain any other input point than
%   the edge extremities.
%
%   [NODES EDGES] = gabrielGraph(PTS)
%   Also returns the initial set of points;
%
%   Example
%     pts = rand(100, 2);
%     edges = gabrielGraph(pts);
%     figure; drawPoint(pts);
%     hold on; axis([0 1 0 1]); axis equal;
%     drawGraph(pts, edges);
%
%   See also
%     drawGraph, delaunayGraph
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-01-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% compute delaunay triangulation
dt = DelaunayTri(pts);

% extract edges (N-by-2 array)
eds = dt.edges();

% radius of the circule circumscribed to each edge
rads = edgeLength([pts(eds(:,1), :) pts(eds(:,2), :)]) / 2;

% extract middle point of each edge
midPts = midPoint(pts(eds(:,1), :), pts(eds(:,2), :));

% distance between midpoints and all points
% closest points should be edge vertices
dists = minDistancePoints(midPts, pts);

% geometric tolerance (adapted to point set extent)
tol = max(max(pts) - min(pts)) * eps;

% keep only edges whose circumcircle does not contain any other point
keep = dists >= rads - tol;
edges = eds(keep, :);

if nargout < 2
    varargout = {edges};
else
    varargout = {pts, edges};
end
