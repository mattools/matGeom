function [gnodes, gedges] = relativeNeighborhoodGraph(points)
%RELATIVENEIGHBORHOODGRAPH Relative Neighborhood Graph of a set of points
%
%   [NODES, EDGES] = relativeNeighborhoodGraph(POINTS)
%   EDGES = relativeNeighborhoodGraph(POINTS)
%
%   The Relative Neighborhood Graph (RNG) is a subgraph of the Delaunay
%   Triangulation computed from the same set of points. The Gabriel graph
%   and the euclidean minimal spanning tree (EMST) are subgraphs of the
%   RNG.
%
%   Example
%     nodes = rand(100, 2) * 100;
%     edges = relativeNeighborhoodGraph(nodes);
%     figure; drawGraph(nodes, edges);
%
%   See also
%     gabrielGraph, euclideanMST
%
 
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2016-03-02,    using Matlab 8.6.0.267246 (R2015b)
% Copyright 2016 INRA - Cepia Software Platform.

% first compute Delaunay triangulation to reduce further computations
DT = delaunayTriangulation(points);
E = edges(DT);

% compute edge lengths
nEdges = size(E, 1);
edgeLengths = zeros(nEdges, 1);
for i = 1:nEdges
    edgeLengths(i) = distancePoints(points(E(i,1),:), points(E(i,2),:));
end

% identify indices of faces attached to each vertex
vertexFaces = vertexAttachments(DT);

% iterate over edges to check if the should be kept
keepEdge = true(nEdges, 1);
for iEdge = 1:nEdges
    iVertex1 = E(iEdge, 1);
    iVertex2 = E(iEdge, 2);
    vertex1 = points(iVertex1, :);
    vertex2 = points(iVertex2, :);
    
    % compute indices of faces containing one of the two vertices
    inds = [vertexFaces{iVertex1} vertexFaces{iVertex2}];
    localFaces = DT.ConnectivityList(inds, :);
    
    % compute indices of vertices is the first neighborhood of the edge
    inds = unique(localFaces);
    inds(ismember(inds, [iVertex1 iVertex2])) = [];
    
    % compute max of distances to both original vertices
    dists1 = distancePoints(vertex1, points(inds, :));
    dists2 = distancePoints(vertex2, points(inds, :));
    distsMax = max(dists1, dists2);
    
    % keep edge if all points are outside the "lunule" defined by the edge
    if edgeLengths(iEdge) > min(distsMax)
        keepEdge(iEdge) = false;
    end
end

% filter edges
gedges = E(keepEdge, :);

% format output
gnodes = points;
if nargin == 1
    gnodes = gedges;
end

