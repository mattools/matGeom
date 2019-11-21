function polys = intersectPlaneMesh(plane, v, f)
% Compute the polygons resulting from plane-mesh intersection.
%
%   POLYS = intersectPlaneMesh(P, V, F)
%   Computes the interection between a plane and a mesh given by vertex and
%   face lists. The result is a cell array of polygons.
%
%   The function currently returns at most one polygon in the cell array
%   POLYS.
%
%
%   Example
%     % Intersect a cube by a plane
%     [v f] = createCube; v = v * 10;
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
%     figure; drawTorus(torus, 'nTheta', 180, 'nPhi', 180);
%     hold on; view (3); axis equal; light;
%     % convert to mesh representation
%     [v, f] = torusMesh(torus, 'nTheta', 64, 'nPhi', 64);
%     % compute intersections with collection of planes
%     xList = -50:5:50;
%     polySet = cell(length(xList), 1);
%     for i = 1:length(xList)
%         x0 = xList(i);
%         plane = createPlane([x0 .5 .5], [1 .2 .3]);
%         polySet{i} = intersectPlaneMesh2(plane, v, f);
%     end
%     % draw the resulting 3D polygons
%     drawPolygon3d(polySet, 'lineWidth', 2, 'color', 'k')
%
%
%   See also
%     meshes3d, intersectPlanes, intersectEdgePlane
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2012-07-31,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

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
crossEdgeFaces = zeros(nCrossEdges, 2);

for iEdge = 1:length(edgeCrossInds)
    edge = e(edgeCrossInds(iEdge), :);
    indFaces = find(sum(ismember(f, edge), 2) == 2);
    
    if length(indFaces) ~= 2
        error('crossing edge %d (%d,%d) is associated to %d faces', ...
            iEdge, edge(1), edge(2), length(indFaces));
    end
    
    crossEdgeFaces(iEdge, :) = indFaces;
    
    for iFace = 1:length(indFaces)
        indEdges = faceEdges{indFaces(iFace)};
        indEdges = [indEdges iEdge]; %#ok<AGROW>
        faceEdges{indFaces(iFace)} = indEdges;
    end
end


%% Iterate on edges and faces to form polygons

% initialize an array indicating which indices need to be processed
nCrossEdges = length(edgeCrossInds);
remainingCrossEdges = true(nCrossEdges, 1);

% create empty cell array of polygons
polys = {};

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
    currentFace = crossEdgeFaces(currentEdgeIndex, 1);

    % iterate along current face-edge couples until back to first edge
    while true
        % find the index of next crossing edge
        inds = faceEdges{currentFace};
        currentEdgeIndex = inds(inds ~= currentEdgeIndex);
     
        % mark current edge as processed
        remainingCrossEdges(currentEdgeIndex) = false;
    
        % find the index of the other face containing current edge
        inds = crossEdgeFaces(currentEdgeIndex, :);
        currentFace = inds(inds ~= currentFace);
    
        % check end of current loop
        if currentEdgeIndex == startEdgeIndex
            break;
        end
        
        % add index of current edge
        polyEdgeInds = [polyEdgeInds currentEdgeIndex]; %#ok<AGROW>
    end
    
    % create polygon, and add it to list of polygons
    poly = intersectionPoints(polyEdgeInds, :);
    polys = [polys, {poly}]; %#ok<AGROW>
end
