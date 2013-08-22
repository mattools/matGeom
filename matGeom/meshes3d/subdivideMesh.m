function [vertices2 faces2] = subdivideMesh(vertices, faces, n)
%SUBDIVIDEMESH Subdivides each face of the mesh
%
%   [V2 F2] = subdivideMesh(V, F, N)
%   Subdivides the mesh specified by (V,F) such that each face F is divided
%   into N^2 smaller faces.
%
%   Example
%     [v f] = createOctahedron;
%     figure; drawMesh(v, f); view(3);
%     [v2 f2] = subdivideMesh(v, f, 4);
%     figure; drawMesh(v2, f2); view(3)
%
%   See also
%     meshes3d, drawMesh
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-08-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.


%% Initialisations

if ~isnumeric(faces) || size(faces, 2) ~= 3
    error('Requires a triangular mesh');
end

% compute the edge array
edgeVertexIndices = computeMeshEdges(faces);
nEdges = size(edgeVertexIndices, 1);

% index of faces around each edge
edges = computeMeshEdges(faces);
% edgeFaceIndices = meshEdgeFaces(vertices, edges, faces);

% index of edges around each face
faceEdgeIndices = meshFaceEdges(vertices, edges, faces);


%% Create new vertices on edges

% several interpolated positions
t = linspace(0, 1, n + 1)';
coef2 = t(2:end-1);
coef1 = 1 - t(2:end-1);

% initialise the array of new vertices
vertices2 = vertices;

edgeNewVertexIndices = zeros(nEdges, n-1);

% create new vertices on each edge
for iEdge = 1:nEdges
    v1 = vertices(edgeVertexIndices(iEdge, 1), :);
    v2 = vertices(edgeVertexIndices(iEdge, 2), :);

    newPoints = coef1 * v1 + coef2 * v2;
    
    edgeNewVertexIndices(iEdge,:) = size(vertices2, 1) + (1:n-1);
    
    vertices2 = [vertices2 ; newPoints]; %#ok<AGROW>
end

% % for checkup
% edgeNewVertexIndices

%% Process each face

faces2 = zeros(0, 3);

nFaces = size(faces, 1);
for iFace = 1:nFaces
    % compute index of each corner vertex
    face = faces(iFace, :);
    iv1 = face(1);
    iv2 = face(2);
    iv3 = face(3);
    
    % compute index of each edge
    faceEdges = faceEdgeIndices{iFace};
    ie1 = faceEdges(1);
    ie2 = faceEdges(2);
    ie3 = faceEdges(3);
    
    % indices of new vertices on edges
    edge1NewVertexIndices = edgeNewVertexIndices(ie1, :);
    edge2NewVertexIndices = edgeNewVertexIndices(ie2, :);
    edge3NewVertexIndices = edgeNewVertexIndices(ie3, :);
    
    % keep vertex 1 as reference for edges 1 and 3
    if edges(ie1, 1) ~= iv1
        edge1NewVertexIndices = edge1NewVertexIndices(end:-1:1);
    end
    if edges(ie3, 1) ~= iv1
        edge3NewVertexIndices = edge3NewVertexIndices(end:-1:1);
    end
    
    % for edge 2, keep vertex 2 of the current face as reference 
    if edges(ie2, 1) ~= iv2
        edge2NewVertexIndices = edge2NewVertexIndices(end:-1:1);
    end
    
    % create the first new face, on 'top' of the original face
    topVertexInds = [edge1NewVertexIndices(1) edge3NewVertexIndices(1)];
    newFace = [iv1 topVertexInds];
    faces2 = [faces2; newFace]; %#ok<AGROW>
        
    % iterate over middle strips
    for iStrip = 2:n-1
        % index of extreme vertices of current row
        ivr1 = edge1NewVertexIndices(iStrip);
        ivr2 = edge3NewVertexIndices(iStrip);
        
        % extreme vertices as points
        v1 = vertices2(ivr1, :);
        v2 = vertices2(ivr2, :);
        
        % create additional vertices within the row
        t = linspace(0, 1, iStrip+1)';
        coef2 = t(2:end-1);
        coef1 = 1 - t(2:end-1);
        newPoints = coef1 * v1 + coef2 * v2;

        % compute indices of new vertices in result array
        newInds = size(vertices2, 1) + (1:iStrip-1);
        botVertexInds = [ivr1 newInds ivr2];
        
        % add new vertices
        vertices2 = [vertices2 ; newPoints]; %#ok<AGROW>
        
        % create top faces of current strip
        for k = 1:iStrip-1
            newFace = [topVertexInds(k) botVertexInds(k+1) topVertexInds(k+1)];
            faces2 = [faces2; newFace]; %#ok<AGROW>
        end
        
        % create bottom faces of current strip
        for k = 1:iStrip
            newFace = [topVertexInds(k) botVertexInds(k) botVertexInds(k+1)];
            faces2 = [faces2; newFace]; %#ok<AGROW>
        end
        
        % bottom vertices of current strip are top vertices of next strip
        topVertexInds = botVertexInds;
    end
        
    % create new faces for the last strip
    botVertexInds = [iv2 edge2NewVertexIndices iv3];
    
    % create top faces for last strip
    for k = 1:n-1
        newFace = [topVertexInds(k) botVertexInds(k+1) topVertexInds(k+1)];
        faces2 = [faces2; newFace]; %#ok<AGROW>
    end
    
    % create bottom faces for last strip
    for k = 1:n
        newFace = [topVertexInds(k) botVertexInds(k) botVertexInds(k+1)];
        faces2 = [faces2; newFace]; %#ok<AGROW>
    end
    
    
%     % create additional vertices in the middle of the face
%     for iRow = 1:nv-2
%         % index of extreme vertices of current row
%         ivr1 = edge1NewVertexIndices(iRow);
%         ivr2 = edge3NewVertexIndices(iRow);
%     end
    
end















