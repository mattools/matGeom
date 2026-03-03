function varargout = subdivideMeshEdges(vertices, faces, n)
%SUBDIVIDEMESHEDGES Subdivides each edge of the mesh.
%
%   [V2, F2] = subdivideMeshEdges(V, F, N)
%   [V2, F2] = subdivideMeshEdges(MESH, N)
%   Subdivides the mesh specified by (V,F) such that each edge is divided
%   into N smaller edges.
%   V is a Nv-by-3 array containing vertex coordinates, and F2 is a Nf-by-3
%   array containing index of vertices of each face.
%   MESH is a Matlab structure with at least two fields 'vertices' and
%   'faces', containing vertex and face respectively. It may also contain
%   an additional 'edges' field.
%
%   Example
%   subdivideMeshEdges
%
%   See also
%     meshes3d, subdivideMesh
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2026-03-03,    using Matlab 25.1.0.2973910 (R2025a) Update 1
% Copyright 2026 INRAE.


%% Initialisations

% vertex to vertex edges, will be computed if not provided within mesh
% structure
edges = [];

% The face-to-edge adjacency information is necessary for associating new
% faces to vertices (will be computed if not found)
faceEdgeIndices = [];

% if mesh is provided as structure, retrieve all possible data
if isstruct(vertices)
    % get relevant inputs
    mesh = vertices;
    n = faces;
    
    % parse fields from a mesh structure
    vertices = mesh.vertices;
    faces = mesh.faces;
    if isfield(mesh, 'edges')
        edges = mesh.edges;
    end

    % The face-to-edge adjacency information is necessary for associating
    % new faces to vertices
    % (will be computed if not found)
    if isfield(mesh, 'faceEdges')
        faceEdgeIndices = mesh.faceEdges;
    end
end

if ~isnumeric(faces)
    error('Requires a regular mesh (trimesh or quadmesh)');
end
% compute the edge array
if isempty(edges)
    edges = meshEdges(faces);
end
nEdges = size(edges, 1);

% compute index of edges around each face if not already provided
if isempty(faceEdgeIndices)
    faceEdgeIndices = meshFaceEdges(vertices, edges, faces);
end


%% Process Edges
% Create new vertices on existing edges. Each edge is subdivided into n new
% edges, creating (n-1) new vertices.

% positions to interpolate vertex positions
t = linspace(0, 1, n + 1)';
coef2 = t(2:end-1);
coef1 = 1 - t(2:end-1);

% initialise the array of new vertices
vertices2 = vertices;

% keep an array containing index of new vertices for each original edge
edgeNewVertexIndices = zeros(nEdges, n-1);

% create new vertices on each edge
for iEdge = 1:nEdges
    % extract each extremity as a point
    v1 = vertices(edges(iEdge, 1), :);
    v2 = vertices(edges(iEdge, 2), :);

    % compute new points
    newPoints = coef1 * v1 + coef2 * v2;
    
    % add new vertices, and keep their indices
    edgeNewVertexIndices(iEdge,:) = size(vertices2, 1) + (1:n-1);
    vertices2 = [vertices2 ; newPoints]; %#ok<AGROW>
end


%% Process faces
% For each face, create a new list of vertex indices, containing index of
% original vertices, as well as index vertices newly created on edges.

% create result array (will grow during face iteration)
nFaces = size(faces, 1);
faces2 = zeros(nFaces, size(faces, 2) * n);

% iterate on faces of original mesh
for iFace = 1:nFaces
    % compute index of each corner vertex
    face = faces(iFace, :);

    newFace = [];
    for iv = 1:length(face)
        iEdge = faceEdgeIndices{iFace}(iv);

        % indices of new vertices on edges
        newVertices = edgeNewVertexIndices(iEdge, :);
        if edges(iEdge, 1) ~= face(iv)
            newVertices = newVertices(end:-1:1);
        end

        newFace = [newFace face(iv) newVertices];
    end
    faces2(iFace, :) = newFace;
end


%% Post-processing

% setup output arguments
varargout = formatMeshOutput(nargout, vertices2, faces2);
