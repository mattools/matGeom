function [regions, distances] = meshVoronoiDiagram(vertices, faces, germInds)
% Voronoi Diagram on the surface of a polygonal mesh.
%
%   REGIONS = meshVoronoiDiagram(V, F, GERM_INDS)
%   Computes the region associated to each vertex of the input mesh (V,F),
%   i.e. the index of the germ closest to the vertex.
%   V is a NV-by-3 array of vertx coordinates, and F is a NF-by-3 array
%   containing vertex indices of each face.
%   IGERMS is an array of vertex indices.
%   REGIONS is a column vector with as many rows as the number of vertices,
%   containing for each vertex the index of the closest germ. 
%   The regions are computed by propagating distances along edges.
%   
%   [REGIONS, DISTANCES] = meshVoronoiDiagram(V, F, GERM_INDS)
%   Also returns the (geodesic) distance from each vertex to the closest
%   germ. 
%   
%
%   Example
%     % Create a triangular mesh based on an icosahedron shape
%     [v, f] = createIcosahedron; v = v - mean(v); 
%     [v, f] = subdivideMesh(v, f, 10); v = normalizeVector3d(v);
%     figure; hold on; axis equal; view(3);
%     drawMesh(v, f, 'faceColor', [.7 .7 .7]);
%     % generate germs within the mesh (identify with indices)
%     nGerms = 10; 
%     inds = randperm(size(v, 1), nGerms);
%     drawPoint3d(v(inds,:), 'bo');
%     % Compute Voronoi Diagram
%     [regions, distances] = meshVoronoiDiagram(v, f, inds);
%     % Display regions
%     figure; hold on; axis equal; view(3);
%     cmap = jet(nGerms);
%     patch('Vertices', v, 'Faces', f, 'FaceVertexCData', cmap(regions, :), 'FaceColor', 'interp', 'LineStyle', 'none');
%     % Display distance maps
%     figure; hold on; axis equal; view(3);
%     patch('Vertices', v, 'Faces', f, 'FaceVertexCData', distances, 'FaceColor', 'interp', 'LineStyle', 'none');
%
%   See also
%     meshes3d, drawMesh
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-04-16,    using Matlab 9.7.0.1247435 (R2019b) Update 2
% Copyright 2020 INRAE.

% choose initial germ indices if input is a scalar
nVertices = size(vertices, 1);
if isscalar(germInds)
    germInds = randperm(nVertices, germInds);
end
nGerms = length(germInds);

% init info for vertices
distances = inf * ones(nVertices, 1);
regions = zeros(nVertices, 1);

% initialize vertex data for each germ
for iGerm = 1:nGerms
    ind = germInds(iGerm);
    distances(ind) = 0;
    regions(ind) = iGerm;
end

% compute the adjacencey matrix, as a Nv-by-Nv sparse matrix of 0 and 1.
adj = meshAdjacencyMatrix(faces);


% create the queue of vertex to process, initialized with germ indices.
vertexQueue = germInds;
processed = false(nVertices, 1);

% process vertices in the queue, using distance as priority
while ~isempty(vertexQueue)
    % find the vertex with smallest distance
    [~, ind] = min(distances(vertexQueue));
    iVertex = vertexQueue(ind);
    vertexQueue(ind) = [];
    
    % info for current vertex
    vertex = vertices(iVertex, :);
    dist0 = distances(iVertex);
    
    % neighbors of current vertex
    neighbors = find(adj(iVertex,:));
    
    % keep only vertices not yet processed
    neighbors = neighbors(~processed(neighbors));
    
    for iNeigh = 1:length(neighbors)
        indNeigh = neighbors(iNeigh);
        dist = dist0 + distancePoints3d(vertex, vertices(indNeigh, :));
        
        if dist < distances(indNeigh)
            distances(indNeigh) = dist;
            regions(indNeigh) = regions(iVertex);
            vertexQueue = [vertexQueue indNeigh]; %#ok<AGROW>
        end
    end
    
    % mark current vertex as processed
    processed(iVertex) = true;
end
