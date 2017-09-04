function [nodes2, edges2, faces2] = clipMesh2dPolygon(nodes, edges, faces, poly)
%CLIPMESH2DPOLYGON  Clip a planar mesh with a polygon
%
%   [NODES2, EDGES2, FACES2] = clipMesh2dPolygon(NODES, EDGES, FACES, POLY)
%   Clips the graph defined by nodes NODES and edges EDGES with the polygon
%   given in POLY. POLY is a N-by-2 array of vertices.
%   The result is a new graph containing nodes inside the polygon, as well
%   as nodes created by the intersection of edges with the polygon.
%
%   Important: it is assumed that no edge crosses the polygon twice. This
%   is the case if the polygon is convex (or nearly convex) and if the
%   edges are small compared to the polygon.
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
%     [n2, e2, f2] = clipMesh2dPolygon(n, e, f, poly);
%     drawGraphEdges(n2, e2);
%     fillGraphFaces(n2, f2);
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

%% Pre-processing

% number of nodes, edges and faces
nNodes = size(nodes, 1);
nEdges = size(edges, 1);
nFaces = meshFaceNumber(nodes, faces);

% associate each face to the list of its incident edge
faceEdgeInds = meshFaceEdges(nodes, edges, faces);


%% Clip the nodes

% find index of nodes inside clipping window
nodeInside = isPointInPolygon(nodes, poly);

innerNodeInds = find(nodeInside);

% create correspondance between original nodes and inside nodes
nodeIndsMap = zeros(nNodes, 1);
for i = 1:length(innerNodeInds)
    nodeIndsMap(innerNodeInds(i)) = i;
end

% select clipped nodes
nodes2 = nodes(innerNodeInds, :);


%% Prepare edge clipping
% Need to compute with edges will be kept. This includes (1) edges totally
% inside the original polygon and (2) edges clipped by the polygon.

% array of boolean flag for each end vertex of each edge
insideEnds = nodeInside(edges);

% find index of edges totally inside polygon
% (do not test intersections with polygon edges)
edgeInsideFlag = sum(insideEnds, 2) == 2;
innerEdgeInds = find(edgeInsideFlag);

% Create correspondance map between original edges and new edges.
innerEdgeIndsMap = zeros(nEdges, 1);
for i = 1:length(innerEdgeInds)
    innerEdgeIndsMap(innerEdgeInds(i)) = i;
end

% create correspondance map between old edges and new edges
% Use a cell array, as each edge may be clip into several edges.
% The map is initialized with inner edges indices, but may contain indices
% of clipped edges in later processing
edgeIndsMap = cell(nEdges, 1);
for i = 1:length(innerEdgeInds)
    edgeIndsMap{innerEdgeInds(i)} = i;
end


% find edges either totally inside polygon, or with one intersection with
% the polygon
keepEdgeFlag = sum(insideEnds, 2) > 0;

% allocate memory for edges to keep (with at least one vertex inside)
nEdges2 = sum(keepEdgeFlag);
edges2 = zeros(nEdges2, 2);


% create correspondance map between new edges and original edge(s)
% Use a cell array, as each edge may be clip into several edges.
% The map is initialized with inner edges indices, but may contain indices
% of clipped edges in later processing
edgeIndsMap2 = cell(nEdges2, 1);


%% Determine clipped edges

% index of next edge
% index of next edge to add to the list
% iEdge2 = 1;
iEdge2 = length(innerEdgeInds) + 1;

% index of next vertex
iNode2 = size(nodes2, 1) + 1;

% iterate over all edges
for iEdge = 1:nEdges
    % index of edge vertices
    v1 = edges(iEdge, 1);
    v2 = edges(iEdge, 2);
    
    % compute intersection(s) of current edge with polygon boundary
    edge0 = [nodes(v1,:) nodes(v2,:)]; 
    intersects = intersectEdgePolygon(edge0, poly);
    
    % If current edge do not cross polygon boundary, it is either totally
    % inside or totally outside
    if isempty(intersects)
        % check if edge is totally inside the polygon
        if nodeInside(v1) && nodeInside(v2)
            % create new edge by converting node indices
            newEdge = nodeIndsMap([v1 v2])';
            
            % add the new edge to the list of new edges
            ind = innerEdgeIndsMap(iEdge);
            edges2(ind,:) = newEdge;
            
            % keep index correspondance new->old
            edgeIndsMap2{ind} = iEdge;
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

    % determine the number of edges corresponding to the clipped edge
    % (usually only one)
    nNewEdges = (nInters + 1) / 2;
    if nNewEdges ~= round(nNewEdges)
        warning('matGeom:graphs:AlgorithmicError', ...
            'edge %d has odd number of intersects', iEdge);
    end

    % compute list of indices of the new edges
    newEdgeInds = (1:nNewEdges) + iEdge2 - 1;

    % associate new edge indices to the current edge
    edgeIndsMap{iEdge} = newEdgeInds;
    
    % create a new edge for each pair of contiguous intersections
    while length(intersectInds) > 1
        edges2(iEdge2, :) = intersectInds(1:2);
        edgeIndsMap2{iEdge2} = iEdge;
        intersectInds(1:2) = [];
        iEdge2 = iEdge2 + 1;
    end
    
    if ~isempty(intersectInds)
        warning('matGeom:graphs:AlgorithmicError', ...
            'edge %d has odd number of intersects', iEdge);
    end
end


%% Clip faces

% initialize new array of faces
faces2 = cell(0, 0);
iFace2 = 1;

for iFace = 1:nFaces
    % get edge indices of current face
    edgeInds = faceEdgeInds{iFace};
    nodeInds = unique(edges(edgeInds, :));
    
    % check which edges of current face are inside
    insideFlags = nodeInside(nodeInds);
    
    % do not consider faces whose all vertices are outside polygon
    % (for the moment)
    if all(~insideFlags)
        continue;
    end
    
    % check if face is totally within the polygon or if we need to clip the
    % face with the polygon boundary
    if all(insideFlags)
        % convert edge indices
        edgeInds2 = [];
        for iEdge = 1:length(edgeInds)
            edgeInds2 = [edgeInds2 edgeIndsMap{edgeInds(iEdge)}]; %#ok<AGROW>
        end
        
        % convert edge indices to list of vertices
        faceEdges = edges2(edgeInds2, :);
        newFace = faceEdges(1, :);
        nextInd = newFace(2);

        faceEdges(1,:) = [];
        while size(faceEdges, 1) > 1
            ind = find(sum(faceEdges == nextInd, 2));
            nodeInds = faceEdges(ind, :);
            nextInd = nodeInds(nodeInds ~= nextInd);
            newFace = [newFace nextInd]; %#ok<AGROW>
            faceEdges(ind, :) = [];
        end
        
    else    
        % process case of clipped faces
        
        % get indices of clipped edges
        keepFlags = keepEdgeFlag(edgeInds);
        edgeInds = edgeInds(keepFlags);

        % convert edge indices
        edgeInds2 = [];
        for iEdge = 1:length(edgeInds)
            edgeInds2 = [edgeInds2 edgeIndsMap{edgeInds(iEdge)}]; %#ok<AGROW>
        end

        % convert edge indices to list of vertices
        faceEdges = edges2(edgeInds2, :);

        % find a vertex existing only once
        indices = unique(faceEdges(:));
        for i = 1:length(indices)
            if sum(faceEdges(:) == indices(i)) == 1
                ind0 = indices(i);
                break;
            end
        end

        % initialize new face from single vertex
        nextInd = ind0;
        newFace = nextInd;

        % iterate over edges until other single vertex
        while size(faceEdges, 1) > 0
            ind = find(sum(faceEdges == nextInd, 2));
            nodeInds = faceEdges(ind, :);
            nextInd = nodeInds(nodeInds ~= nextInd);
            newFace = [newFace nextInd]; %#ok<AGROW>
            faceEdges(ind, :) = [];
        end

        % crop the clipping polygon into two polylines
        node0 = nodes2(ind0, :);
        pos0 = projPointOnPolygon(node0, poly);
        pos1 = projPointOnPolygon(nodes2(nextInd, :), poly);
        sub1 = polygonSubcurve(poly, pos0, pos1);
        sub2 = polygonSubcurve(poly, pos1, pos0);

        % keep only the smallest polyline
        if polylineLength(sub1) < polylineLength(sub2)
            sub = sub1;
        else
            sub = sub2;
        end

        % eventually add polygon vertices contained within subcurve extremities
        dists = distancePoints(sub([1 end],:), node0);
        if dists(1) < dists(2)
            newNodes = sub(end-1:-1:2, :);
        else
            newNodes = sub(2:end-1, :);
        end

        newNodeInds = (1:size(newNodes, 1)) + size(nodes2, 1);
        nodes2 = [nodes2; newNodes]; %#ok<AGROW>
        newFace = [newFace newNodeInds]; %#ok<AGROW>

        % add new edges
        newEdges = [[nextInd newNodeInds]' [newNodeInds ind0]'];
        edges2 = [edges2 ; newEdges]; %#ok<AGROW>
    end
    
    % ensure new face is CCW-oriented
    if polygonArea(nodes2(newFace, :)) < 0
        newFace = newFace([1 end:-1:2]);
    end
    
    % add the new face to the set of new faces
    faces2{iFace2} = newFace;
    iFace2 = iFace2 + 1;
end

