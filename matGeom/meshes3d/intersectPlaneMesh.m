function polys = intersectPlaneMesh(plane, v, f)
%INTERSECTPLANEMESH Compute the polygons resulting from plane-mesh intersection
%
%   POLYS = intersectPlaneMesh(P, V, F)
%   Computes the interection between a plane and a mesh given by vertex and
%   face lists. The result is a cell array of polygons.
%
%   The function currenlty returns at most one polygon in the cell array
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
%   See also
%     meshes3d, intersectPlanes, intersectEdgePlane
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-07-31,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% compute the edge list
e = computeMeshEdges(f);
edges = [ v(e(:,1), :) v(e(:,2), :) ];

% associate two neighbour face to each edge
faceEdges = meshEdgeFaces(v, e, f);

% compute one intersection point for each edge
intersectionsPoints = intersectEdgePlane(edges, plane);

% keep only 'valid' intersection points and intersected edges
validEdges = isfinite(intersectionsPoints(:,1));
validEdgeInds = find(isfinite(intersectionsPoints(:,1)));

validFaceEdge = faceEdges(validEdges, :);
% validFaceInds = unique(validFaceEdge(:));

% processedEdge = false(size(e, 1), 1);

polys = {};
while ~isempty(validEdgeInds)
    % start new polygon
    
    % start at any edge, mark it as current
    startEdgeIndex = validEdgeInds(1);
    currentEdgeIndex = startEdgeIndex;
    
    % initialize new set of edge indices
    polyEdgeInds = currentEdgeIndex;
    
    % choose one of the two faces around the edge
    currentFace = faceEdges(currentEdgeIndex, 1);
    
%     % current edge is ready
%     processedEdge(currentEdgeIndex) = true;
    
    % iterate along current face-edge couples until back to first edge
    while true
        % indices of the two valid edges for current face
        % (length should be equal to 2)
        inds = validEdgeInds(sum(validFaceEdge == currentFace, 2) > 0);
        currentEdgeIndex = inds(inds ~= currentEdgeIndex);
        
        inds = faceEdges(currentEdgeIndex, :);
        currentFace = inds(inds ~= currentFace);
    
        % check end of current loop
        if currentEdgeIndex == startEdgeIndex
            break;
        end
        
        % add index of current edge
        polyEdgeInds = [polyEdgeInds currentEdgeIndex]; %#ok<AGROW>
    end
    
    poly = intersectionsPoints(polyEdgeInds, :);
    
    polys = [polys, {poly}]; %#ok<AGROW>
    break;
end
