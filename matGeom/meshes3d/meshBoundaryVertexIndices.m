function inds = meshBoundaryVertexIndices(varargin)
%MESHBOUNDARYVERTEXINDICES Indices of boundary vertices of a mesh.
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
%     inds = meshBoundaryVertexIndices(vc, fc);
%     hold on; drawPoint3d(vc(inds,:), 'k*');
%
%   See also 
%     meshes3d, meshBoundary, meshBoundaryEdgeIndices, meshEdgeFaces

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2019-05-01, using Matlab 8.6.0.267246 (R2015b)
% Copyright 2019-2023 INRA - Cepia Software Platform

[vertices, faces] = parseMeshData(varargin{:});

BE = meshBoundaryEdges(vertices, faces);

inds = unique(BE(:));
