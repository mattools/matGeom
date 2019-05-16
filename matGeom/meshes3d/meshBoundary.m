function polyList = meshBoundary(varargin)
%MESHBOUNDARY Boundary of a mesh as a collection of 3D line strings.
%
%   CURVES = meshBoundary(V, F)
%
%   Example
%     % create centered icosahedron
%     [v, f] = createIcosahedron;
%     v(:,3) = v(:,3) - mean(v(:,3));
%     % convert to simili-sphere
%     [v2, f2] = subdivideMesh(v, f, 3);
%     v3 = normalizeVector3d(v2);
%     % clip with plane
%     plane = createPlane([0 0 0], [-1 -2 3]);
%     [vc, fc] = clipMeshVertices(v3, f2, plane, 'shape', 'plane');
%     figure; drawMesh(vc, fc); axis equal; view(3);
%     % draw mesh boundary
%     curves = meshBoundary(vc, fc);
%     hold on; drawPolygon3d(curves{1}, 'linewidth', 2, 'color', 'b');
%
%   See also
%     meshes3d, meshBoundaryEdgeIndices, meshBoundaryVertexIndices
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2019-05-01,    using Matlab 8.6.0.267246 (R2015b)
% Copyright 2019 INRA - Cepia Software Platform.

[vertices, edges, faces] = parseMeshData(varargin{:});

% Compute edge-vertex map if not specified
if isempty(edges)
    edges = meshEdges(vertices, faces);
end

bndEdgeInds = meshBoundaryEdgeIndices(vertices, edges, faces);
bndEdges = edges(bndEdgeInds, :);

if isempty(bndEdgeInds)
    polyList = {};
    return;
end

% allocate empty array
polyList = {};

nPolys = 0;
while ~isempty(bndEdges)
    nPolys = nPolys + 1;
    
    % current edge
    edge = bndEdges(1, :);

    % initialize new polyline at first vertex
    ind0 = edge(1);
    vertexInds = ind0;
    
    % current vertex
    index = edge(2);
    bndEdges(1, :) = [];
    
    % iterate over edges until current vertex becomes ind0
    while index ~= ind0
        % append current vertex to list of indices for current polygon
        vertexInds = [vertexInds ; index]; %#ok<AGROW>
        
        % index of the next edge containing current vertex
        edgeInd = find(sum(bndEdges == index, 2) > 0);
        
        % check validity
        if isempty(edgeInd)
            error('could not find next edge for vertex index %d', index);
        end
        if length(edgeInd) > 1
            error('two many edges contains vertex index %d', index);
        end
        
        % remove current edge from the list of edges to process
        edge = bndEdges(edgeInd, :);
        bndEdges(edgeInd, :) = [];
        
%         % check if current edge closes current polygon
%         if index == ind0
%             break;
%         end
        
        % identify the next index
        index = edge(edge ~= index);
    end
    
    % create the 3D polyline
    polyList{nPolys} = vertices(vertexInds, :); %#ok<AGROW>
end
