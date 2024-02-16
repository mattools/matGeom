function [polys, closedFlag] = intersectPlaneMesh(plane, v, f)
%INTERSECTPLANEMESH Compute the polylines resulting from plane-mesh intersection.
%
%   POLYS = intersectPlaneMesh(P, V, F)
%   [POLYS, CLOSED] = intersectPlaneMesh(P, V, F)
%   Computes the intersection between a plane and a mesh. 
%   The plane P is given as:
%   P = [X0 Y0 Z0  DX1 DY1 DZ1  DX2 DY2 DZ2]
%   The mesh is given as numeric array V of vertex coordinates and an array
%   of (triangular) face vertex indices.
%   The output POLYS is a cell array of polylines, where each cell contains
%   a NV-by-3 numeric array of coordinates. The (optional) output CLOSED is
%   a logical array the same size as the POLYS, indicating whether the
%   corresponding polylines are closed (true), or open (false). 
%   Use the functions 'drawPolygon3d' to display closed polylines, and
%   'drawPolyline3d' to display open polylines.
%
%
%   Example
%     % Intersect a cube by a plane
%     [v, f] = createCube; v = v * 10;
%     plane = createPlane([5 5 5], [3 4 5]);
%     % draw the primitives
%     figure; hold on; set(gcf, 'renderer', 'opengl');
%     axis([-10 20 -10 20 -10 20]); view(3);
%     drawMesh(v, f); drawPlane3d(plane);
%     % compute intersection polygon
%     polys = intersectPlaneMesh(plane, v, f);
%     drawPolygon3d(polys, 'LineWidth', 2);
%
%     % Intersect a torus by a set of planes, and draw the results
%     % first creates a torus slightly shifted and rotated
%     torus = [.5 .6 .7   30 10   3 4];
%     figure('color','w');
%     % convert to mesh representation
%     [v, f] = torusMesh(torus, 'nTheta', 64, 'nPhi', 64);
%     f = triangulateFaces(f);
%     drawMesh(v, f);
%     hold on; view (3); axis equal; light;
%     % compute intersections with collection of planes
%     xList = -50:5:50;
%     polySet = cell(length(xList), 1);
%     for i = 1:length(xList)
%         x0 = xList(i);
%         plane = createPlane([x0 .5 .5], [1 .2 .3]);
%         polySet{i} = intersectPlaneMesh(plane, v, f);
%     end
%     % draw the resulting 3D polygons
%     drawPolygon3d(polySet, 'lineWidth', 2, 'color', 'y')
%
%     % Demonstrate ability to draw open mesh intersections
%     poly = circleArcToPolyline([10 0 5 90 180], 33);
%     [x, y, z] = revolutionSurface(poly, linspace(-pi, pi, 65));
%     [v, f] = surfToMesh(x, y, z);
%     f = triangulateFaces(f);
%     plane = createPlane([0 0 0], [5 2 -4]);
%     figure; hold on; axis equal; view(3);
%     drawMesh(v, f, 'linestyle', 'none', 'facecolor', [0.0 0.8 0.0], 'faceAlpha', 0.7);
%     drawPlane3d(plane, 'facecolor', 'm', 'faceAlpha', 0.5);
%     % compute and display intersection
%     [curves, closed] = intersectPlaneMesh(plane, v, f);
%     drawPolyline3d(curves(~closed), 'linewidth', 2, 'color', 'b')
%
%
%   See also 
%     meshes3d, intersectPlanes, intersectEdgePlane
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2012-07-31, using Matlab 7.9.0.529 (R2009b)
% Copyright 2012-2023 INRA - Cepia Software Platform

e = [];
if isstruct(v)
    f = v.faces;
    if isfield(v, 'edges')
        e = v.edges;
    end
    v = v.vertices;
end


%% Computation of crossing edges

% compute the edge list
if isempty(e)
    e = meshEdges(f);
end
edges = [ v(e(:,1), :) v(e(:,2), :) ];

% identify which edges cross the mesh
inds = isBelowPlane(v, plane);
edgeCrossInds = find(sum(inds(e), 2) == 1);

% compute one intersection point for each edge
intersectionPoints = intersectEdgePlane(edges(edgeCrossInds, :), plane);



%% mapping edges <-> faces
% identify for each face the indices of edges that intersect the plane, as
% well as for each edge, the indices of the two faces around it.
% We expect each face to contain either 0 or 2 intersecting edges.
% 

nFaces = length(f);
faceEdges = cell(1, nFaces);
nCrossEdges = length(edgeCrossInds);
crossEdgeFaces = cell(nCrossEdges, 1);

for iEdge = 1:length(edgeCrossInds)
    % identify index of faces adjacent to edge
    edge = e(edgeCrossInds(iEdge), :);
    indFaces = find(sum(ismember(f, edge), 2) == 2);
    
    % assert mesh is manifold (no edge connected to more than three faces)
    if length(indFaces) > 2
        error('crossing edge %d (%d,%d) is associated to %d faces', ...
            iEdge, edge(1), edge(2), length(indFaces));
    end
    
    crossEdgeFaces{iEdge} = indFaces;
    
    % add current edge to list of edges associated to each face
    for iFace = 1:length(indFaces)
        indEdges = faceEdges{indFaces(iFace)};
        indEdges = [indEdges iEdge]; %#ok<AGROW>
        faceEdges{indFaces(iFace)} = indEdges;
    end
end

% initialize an array indicating which edges need to be processed
nCrossEdges = length(edgeCrossInds);
remainingCrossEdges = true(nCrossEdges, 1);


%% Iterate on edges and faces to form open poylines

% create empty cell array of open polylines
openPolys = {};

% identify crossing edges at extremity of open polylines
extremityEdgeInds = find(cellfun(@length, crossEdgeFaces) == 1);
remainingExtremities = true(length(extremityEdgeInds), 1);

% iterate while there are remaining extremity crossing edges
while any(remainingExtremities)
    % start from arbitrary remaining extremity
    extremityIndex = find(remainingExtremities, 1, 'first');
    remainingExtremities(extremityIndex) = false;

    % use extremity as current edge
    startEdgeIndex = extremityEdgeInds(extremityIndex);
    currentEdgeIndex = startEdgeIndex;
    
    % mark current edge as processed
    remainingCrossEdges(currentEdgeIndex) = false;
    
    % initialize new set of edge indices
    polyEdgeInds = currentEdgeIndex;

    % find the unique face adjacent to current edge
    edgeFaces = crossEdgeFaces{currentEdgeIndex};
    currentFace = edgeFaces(1);

    % iterate along current face-edge couples until back to first edge
    while true
        % find the index of next crossing edge
        inds = faceEdges{currentFace};
        currentEdgeIndex = inds(inds ~= currentEdgeIndex);
        
        % add index of current edge
        polyEdgeInds = [polyEdgeInds currentEdgeIndex]; %#ok<AGROW>

        % mark current edge as processed
        remainingCrossEdges(currentEdgeIndex) = false;
    
        % find the index of the other face containing current edge
        inds = crossEdgeFaces{currentEdgeIndex};

        % check if we found an extremity edge
        if length(inds) == 1
            ind = extremityEdgeInds == currentEdgeIndex;
            remainingExtremities(ind) = false;
            break;
        end

        % switch to next face
        currentFace = inds(inds ~= currentFace);
    end
    
    % create polygon, and add it to list of polygons
    poly = intersectionPoints(polyEdgeInds, :);
    openPolys = [openPolys, {poly}]; %#ok<AGROW>
end


%% Iterate on edges and faces to form closed polylines

% create empty cell array of polygons
rings = {};

% iterate while there are some crossing edges to process
while any(remainingCrossEdges)
    
    % start at any edge, mark it as current
    startEdgeIndex = find(remainingCrossEdges, 1, 'first');
    currentEdgeIndex = startEdgeIndex;
    
    % mark current edge as processed
    remainingCrossEdges(currentEdgeIndex) = false;
    
    % initialize new set of edge indices
    polyEdgeInds = currentEdgeIndex;

    % choose one of the two faces around the edge
    edgeFaces = crossEdgeFaces{currentEdgeIndex};
    currentFace = edgeFaces(1);

    % iterate along current face-edge couples until back to first edge
    while true
        % find the index of next crossing edge
        inds = faceEdges{currentFace};
        currentEdgeIndex = inds(inds ~= currentEdgeIndex);
     
        % mark current edge as processed
        remainingCrossEdges(currentEdgeIndex) = false;
    
        % check end of current loop
        if currentEdgeIndex == startEdgeIndex
            break;
        end
        
        % add index of current edge
        polyEdgeInds = [polyEdgeInds currentEdgeIndex]; %#ok<AGROW>

        % find the index of the other face containing current edge
        inds = crossEdgeFaces{currentEdgeIndex};
        currentFace = inds(inds ~= currentFace);
    end
    
    % create polygon, and add it to list of polygons
    poly = intersectionPoints(polyEdgeInds, :);
    rings = [rings, {poly}]; %#ok<AGROW>
end


%% Format output array
polys = [rings, openPolys];
closedFlag = [true(1, length(rings)), false(1, length(openPolys))];
