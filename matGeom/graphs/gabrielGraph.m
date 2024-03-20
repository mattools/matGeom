function varargout = gabrielGraph(pts)
%GABRIELGRAPH  Gabriel Graph of a set of points.
%
%   EDGES = gabrielGraph(PTS)
%   Computes the Gabriel graph of the input set of points PTS. The Gabriel
%   graph is based on the euclidean Delaunay triangulation, and keeps only
%   edges whose circumcircle does not contain any other input point than
%   the edge extremities.
%
%   [NODES, EDGES] = gabrielGraph(PTS)
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
%     graphs, drawGraph, delaunayGraph
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2012-01-22, using Matlab 7.9.0.529 (R2009b)
% Copyright 2012-2023 INRA - Cepia Software Platform

% compute Delaunay triangulation
if verLessThan('matlab', '8.1')
    % Code for versions before R2013a
    dt = DelaunayTri(pts); %#ok<DDELTRI>
else
    % Code for versions R2013a and later
    dt = delaunayTriangulation(pts);
end

% extract edges (N-by-2 array)
eds = dt.edges();

% radius of the circle circumscribed to each edge
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

% format output depending on number of output arguments
if nargout < 2
    varargout = {edges};
else
    varargout = {pts, edges};
end
