function ring = meshVertexRing(vertices, faces, indV)
%MESHVERTEXRING Compute the ring around the vertex of a mesh.
%
%   INDS = meshVertexRing(MESH, INDV)
%   INDS = meshVertexRing(V, F, INDV)
%   Computes the ring around the vertex of a mesh, i.e. the indices of the
%   vertex that are connected to that vertex. For regular vertices, the
%   vertex ring forms either a loop or an open polyline (for vertices
%   located on the boundary of the mesh).   
%
%   Example
%     mesh = subdivideMesh(createIcosahedron, 2);
%     figure; hold on; axis equal; axis([-1 1 -1 1 0 2]);
%     drawMesh(mesh, 'facecolor', [.7 .7 .7]);
%     inds = meshVertexRing(mesh, 41);
%     poly = mesh.vertices(inds, :);
%     drawPolygon3d(poly, 'color', 'b', 'linewidth', 2);
%
%   See also 
%     meshes3d, meshVertexNormals
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2024-02-19, using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2024 INRAE - BIA Research Unit - BIBS Platform (Nantes)

if isstruct(vertices)
    indV = faces;
    faces = vertices.faces;
    vertices = vertices.vertices; %#ok<NASGU>
end

if size(faces, 2) ~= 3
    error('Requires triangle mesh as input');
end

% indF = any(ismember(faces, indv), 2);
faces2 = faces(any(ismember(faces, indV), 2),:);

% find index of current vertices
ifc = 1;
face = faces2(ifc,:);
face(face == indV) = [];
iv0 = face(ifc, 1);
ivc = face(ifc, 2);

% initialiez result
ring = iv0;

% iterate over faces until we come back at initial vertex
while ivc ~= iv0
    ring = [ring ivc]; %#ok<AGROW>

    % we expect two faces containing next vertex
    inds = find(any(ismember(faces2, ivc), 2));
    % keep the face different from current one
    ifc = inds(inds~=ifc);

    % find next vertex
    face = faces2(ifc,:);
    ivc = face(~ismember(face, [indV ivc]));
end
