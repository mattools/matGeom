function [points edges] = delaunayGraph(points, varargin)
%DELAUNAYGRAPH Graph associated to Delaunay triangulation of input points
%
%   [NODES EDGES] = delaunayGraph(POINTS)
%   Compute the Delaunay triangulation of the set of input points, and
%   convert to a set of edges. The output NODES is the same as the input
%   POINTS.
%
%   Example
%     % Draw a planar graph correpspionding to Delaunay triangulation
%     points = rand(30, 2) * 100;
%     [nodes edges] = delaunayGraph(points);
%     figure; 
%     drawGraph(nodes, edges);
%
%     % Draw a 3Dgraph corresponding to Delaunay tetrahedrisation
%     points = rand(20, 3) * 100;
%     [nodes edges] = delaunayGraph(points);
%     figure;
%     drawGraph(nodes, edges);
%     view(3);
%
%   See Also
%   delaunay, delaunayn
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-19,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% compute triangulation
tri = delaunayn(points, varargin{:});

% number of simplices (triangles), and of vertices by simplex (3 in 2D)
nt = size(tri, 1);
nv = size(tri, 2);

% allocate memory
edges = zeros(nt * nv, 2);

% compute edges of each simplex
for i = 1:nv-1
    edges((1:nt) + (i-1)*nt, :) = sort([tri(:, i) tri(:, i+1)], 2);
end
edges((1:nt) + (nv-1)*nt, :) = sort([tri(:, end) tri(:, 1)], 2);

% remove multiple edges
edges = unique(edges, 'rows');
