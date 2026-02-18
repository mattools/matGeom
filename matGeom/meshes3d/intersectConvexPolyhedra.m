function varargout = intersectConvexPolyhedra(mesh1, mesh2, varargin)
%INTERSECTCONVEXPOLYHEDRA Intersection of two convex polyhedra.
%
%   usage:
%   RES = intersectConvexPolyhedra(MESH1, MESH2)
%   [VI, FI] = intersectConvexPolyhedra(MESH1, MESH2)
%   Computes the (convex) mesh resulting from the intersection of the
%   volumes defined by the two input convex meshes. The result is also a
%   mesh corresponding to the boundary of the convex volume. If two output
%   arguments are requested, they correspond to the vertices and the faces
%   of the resulting mesh.
%
%   ... = intersectConvexPolyhedra(..., 'mergeCoplanarFaces', TF)
%   Specifies whether the resulting mesh should be given as a triangulation
%   (TF is false) or as a polygonal mesh with potentially a variable number
%   of vertex per face (TF is true). Default value is TRUE.
%
%   Example
%     mesh1 = createCube;
%     mesh2 = transformMesh(createOctahedron, createTranslation3d([0.8 0.7 0.6]));
%     inter = intersectConvexPolyhedra(mesh1, mesh2);
%     figure; hold on;
%     drawMesh(mesh1, 'faceColor', [0.7 0 0], 'faceAlpha', 0.3);
%     drawMesh(mesh2, 'faceColor', [0 0 0.7], 'faceAlpha', 0.3);
%     drawMesh(inter, 'faceColor', [0.7 0 0.7], 'faceAlpha', 0.8);
%     axis equal; view(3);
%
%   See also
%     meshes3d, convexHull3d, minConvexHull

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2025-12-01,    using Matlab 25.1.0.2943329 (R2025a)
% Copyright 2025 INRAE.


% parse optional input arguments
parser = inputParser;
addParameter(parser, 'mergeCoplanarFaces', true);
parse(parser, varargin{:});
mergeCoplanar = parser.Results.mergeCoplanarFaces;

% retrieve data from each mesh
verts1 = mesh1.vertices;
verts2 = mesh2.vertices;


% identify which vertices are within the other mesh
inVertsFlag1 = isPointInMesh(verts1, mesh2);
inVertsFlag2 = isPointInMesh(verts2, mesh1);

% compute array of edges
edges1 = meshEdges(mesh1);
edges2 = meshEdges(mesh2);

% iterate over edges of first mesh, and populate array of intersections
ne1 = size(edges1, 1);
inters1 = zeros(0, 3);
for i1 = 1:ne1
    seg = [verts1(edges1(i1,1), :) verts1(edges1(i1,2), :)];
    tmp = intersectEdgeMesh3d(seg, mesh2);
    inters1 = [inters1 ; tmp]; %#ok<AGROW>
end

% iterate over edges of first mesh, and populate array of intersections
ne2 = size(edges2, 1);
inters2 = zeros(0, 3);
for i1 = 1:ne2
    seg = [verts2(edges2(i1,1), :) verts2(edges2(i1,2), :)];
    tmp = intersectEdgeMesh3d(seg, mesh1);
    inters2 = [inters2 ; tmp]; %#ok<AGROW>
end

% concatenates vertices of result mesh
convVerts = [verts1(inVertsFlag1,:) ; verts2(inVertsFlag2,:) ; inters1 ; inters2];

% convert to mesh data structure
tri = convhulln(convVerts);
[vertices2, faces2] = trimMesh(convVerts, tri);

% optional cleanup of faces
if mergeCoplanar
    [vertices2, faces2] = mergeCoplanarFaces(vertices2, faces2);
end

% format output arguments
varargout = formatMeshOutput(nargout, vertices2, faces2);
