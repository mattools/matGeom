function inds = meshBoundaryEdgeIndices(varargin)
%MESHBOUNDARYEDGEINDICES Indices of boundary edges of a mesh.
%
%   INDS = meshBoundaryVertexIndices(V, F)
%   INDS = meshBoundaryVertexIndices(V, E, F)
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
%     % draw boundary vertices
%     ec = meshEdges(vc, fc);
%     inds = meshBoundaryEdgeIndices(vc, ec, fc);
%     edges = [vc(ec(inds, 1), :) vc(ec(inds, 2), :)];
%     hold on; drawEdge3d(edges, 'linewidth', 2, 'color', 'b');
%
%   See also
%     meshes3d, meshBoundary, meshBoundaryVertexIndices, meshEdgeFaces
 
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

% compute edges to faces map
edgeFaces = meshEdgeFaces(vertices, edges, faces);

inds = find(sum(edgeFaces == 0, 2) > 0);
