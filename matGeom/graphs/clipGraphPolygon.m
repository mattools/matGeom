function [nodes2, edges2] = clipGraphPolygon(nodes, edges, poly)
%CLIPGRAPHPOLYGON  Clip a graph with a polygon
%
%   [NODES2, EDGES2] = clipGraphPolygon(NODES, EDGES, POLY)
%   Clips the graph defined by nodes NODES and edges EDGES with the polygon
%   given in POLY. POLY is a N-by-2 array of vertices.
%   The result is a new graph containing nodes inside the polygon, as well
%   as nodes created by the intersection of edges with the polygon.
%
%   Example
%     elli = [50 50 40 20 30];
%     figure; hold on;
%     drawEllipse(elli, 'k');
%     poly = ellipseToPolygon(elli, 200);
%     box = polygonBounds(poly);
%     germs = randomPointInPolygon(poly, 100);
%     drawPoint(germs, 'b.');
%     [n, e, f] = boundedVoronoi2d(box, germs);
%     [n2, e2] = clipGraphPolygon(n, e, poly);
%     drawGraphEdges(n2, e2);
%
%   See also
%     graphs, drawGraph, clipGraph
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2012-02-24,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% Algorithm summary:
% * For each edge not outside do:
%    * clip edge with poly
%    * if no inter
%    *    add current edge (same vertex indices)
%    *    continue
%    * end
%    * add intersections to list, compute their indices
%    * create the new edge(s)

%% Clip the nodes

% find index of nodes inside clipping window
nodeInside = isPointInPolygon(nodes, poly);

innerNodeInds = find(nodeInside);

% create correspondance between original nodes and inside nodes
nodeIndsMap = zeros(size(nodes, 1), 1);
for i = 1:length(innerNodeInds)
    nodeIndsMap(innerNodeInds(i)) = i;
end

% select clipped nodes
nodes2 = nodes(innerNodeInds, :);


%% Clip the edges

insideEnds = nodeInside(edges);

% allocate memory for edges with at least one vertex inside
nEdges2 = sum(sum(insideEnds, 2) ~= 0);

% allocate memory for at least edges inside
edges2 = zeros(nEdges2, 2);

nEdges = size(edges, 1);

% index of next edge
iEdge2 = 1;

% index of next vertex
iNode2 = size(nodes2, 1) + 1;


% iterate over all edges
for iEdge = 1:nEdges
    % index of edge vertices
    v1 = edges(iEdge, 1);
    v2 = edges(iEdge, 2);
    
    % compute intersection(s) of current edge with boundary
    edge0 = [nodes(v1,:) nodes(v2,:)]; 
    intersects = intersectEdgePolygon(edge0, poly);
    
    % process edges that do not cross polygon boundary
    if isempty(intersects)
        if nodeInside(v1) && nodeInside(v2)
            % current edge is totally inside the clipping polygon
            edges2(iEdge2,:) = nodeIndsMap([v1 v2]);
            iEdge2 = iEdge2 + 1;
        end
        continue;
    end
    
    % add intersection(s) to the vertex array
    nInters = size(intersects, 1);
    intersectInds = iNode2:iNode2+nInters-1;
    nodes2(intersectInds,:) = intersects;
    iNode2 = iNode2 + nInters;
    
    % concatenate vertex indices with indices of extremities inside poly
    if nodeInside(v1)
        intersectInds = [nodeIndsMap(v1) intersectInds]; %#ok<AGROW>
    end
    if nodeInside(v2)
        intersectInds = [intersectInds nodeIndsMap(v2)]; %#ok<AGROW>
    end
    
    % create new edge for each couple of contiguous intersection
    while length(intersectInds) > 1
        edges2(iEdge2, :) = intersectInds(1:2);
        intersectInds(1:2) = [];
        iEdge2 = iEdge2 + 1;
    end
    
    if ~isempty(intersectInds)
        warning('matGeom:graphs:AlgorithmicError', ...
            'edge %d has odd number of intersects', iEdge);
    end
end
