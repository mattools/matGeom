function varargout = euclideanMST(points)
%EUCLIDEANMST Build euclidean minimal spanning tree of a set of points
%
%   EDGES = euclideanMST(POINTS)
%   POINTS is a [NxP] array, N being the number of points and P being the
%   dimension.
%   Result EDGES is a [Mx2] array, containing indices of each vertex for
%   each edges.
%
%   [EDGES DISTS] = euclideanMST(POINTS)
%   Also returns the lengths of edges computed by MST algorithm.
%
%   Algorithm first computes Delaunay triangulation of the set of points,
%   then computes euclidean length of each edge of triangulation, and
%   finally uses prim algorithm to simplify the graph.
%
%   Example
%     % choose random points in the plane and display their Euclidean MST
%     pts = rand(50, 2)*100;
%     edges = euclideanMST(pts);
%     drawGraph(pts, edges)
%
%   See also
%   prim_mst, distancePoints, delaunayn
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-07-27,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% dimension
D   = size(points, 2);
Df  = factorial(D);

% compute all couples of vertices in unit triangle, tetrahedron, or n-dim
% simplex
subs = zeros(Df, 2);
k = 1;
for i = 1:D
    for j = i+1:D+1
        subs(k, 1) = i;
        subs(k, 2) = j;
        k = k + 1;
    end
end

% compute delaunay triangulation in D dimensions
tri = delaunayn(points);
Nt  = size(tri, 1);

% compute all possible edges
edges = zeros(Nt*Df, 2);
for t = 1:Nt
    for i = 1:Df
        edges((t-1)*Df+i, 1) = tri(t, subs(i, 1));
        edges((t-1)*Df+i, 2) = tri(t, subs(i, 2));
    end
end

% simplify edges
edges = unique(sort(edges, 2), 'rows');

% compute euclidean length of each edge
val = zeros(size(edges, 1), 1);
for i = 1:size(edges,1)
    val(i) = distancePoints(points(edges(i,1), :), points(edges(i,2), :));
end

% compute MST of created graph
[edges2 vals2] = prim_mst(edges, val);

% process output arguments
if nargout == 1
    varargout{1} = edges2;
elseif nargout==2
    varargout{1} = edges2;
    varargout{2} = vals2;
end
