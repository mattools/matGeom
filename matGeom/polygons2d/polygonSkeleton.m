function varargout = polygonSkeleton(poly, varargin)
% Skeletonization of a polygon with a dense distribution of vertices.
%
%   [V, ADJ] = polygonSkeleton(POLY)
%   POLY is given as a N-by-2 array of polygon vertex coordinates. The
%   result is given a Nv-by-2 array of skeleton vertex coordinates, and an
%   adjacency list, as a NV-by-1 cell array. Each cell contains indices of
%   vertices adjacent to the vertex indexed by the cell.
%
%   [V, ADJ, RAD] = polygonSkeleton(POLY)
%   Also returns the radius of each vertex, corresponding to the distance
%   between the vertex and the closest point of the original contour
%   polygon.
%
%   SKEL = polygonSkeleton(POLY)
%   Concatenates the results in a struct SKEL with following fields:
%   * vertices  the Nv-by-2 array of skeleton vertex coordinates
%   * adjList   the adjacency list of each vertex, as a Nv-by-1 cell array.
%   * radius    the Nv-by-1 array of radius for each vertex
%
%   Example
%     % start from a binary shape
%     img = imread('circles.png');
%     img = imFillHoles(img);
%     figure; imshow(img); hold on;
%     % compute a smooth contour
%     cntList = imContours(img);
%     cnts = smoothPolygon(cntList{1}, 5);
%     drawPolygon(cnts, 'g');
%     % compute skeleton
%     [vertices, adjList] = polygonSkeleton(poly);
%     % convert adjacency list to an edge array
%     edges = adjacencyListToEdges(adjList);
%     % draw the skeleton graph
%     drawGraphEdges(vertices, edges);
%
%   See also
%     graphs, adjacencyListToEdges
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-05-29,    using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2020 INRAE.


%% Voronoi Diagram computation

% Compute Voronoi Diagram, using polygon vertices as germs.
[V, C] = voronoin(poly);

% compute number of elements of each array
nVertices   = size(V, 1);
nCells      = size(C, 1);

% Detection of the vertices located inside the contour
insideFlag = inpolygon(V(:,1), V(:,2), poly(:,1), poly(:,2));
innerVertices = V(insideFlag, :);

% indices of inner vertices
indsInside = find(insideFlag);
nInnerVertices = length(indsInside);

% compute map between voronoi vertex indices and skeleton vertex indices.
vertexIndexMap = zeros(nVertices, 1);
for iVertex = 1:length(indsInside)
    vertexIndexMap(indsInside(iVertex)) = iVertex;
end


%% Compute the topology of the skeleton
%
% Compute the topology as a list of adjacent vertex indices for each vertex
% inside the polygon.
% Need to convert between voronoi indices and skeleton indices.

% allocate adjacncy list
adjList = cell(nInnerVertices, 1);
vertexGermInds = zeros(nInnerVertices, 1);

% iterate on voronoi cells to compute skeleton by linking adjacent vertices
% (avoiding first cell which is located at infinity by convention)
for iGerm = 2:nCells
    % vertices of current cell
    cellVertices = C{iGerm};
    nCellVertices = length(cellVertices);
    
    % iterate on vertices of current cell
    for k = 1:nCellVertices
        % index of current voronoi vertex
        iVertex = cellVertices(k);
        
        % process only vertices within the contour
        if insideFlag(iVertex) == 0
            continue;
        end
        
        % convert voronoi vertex index to skeleton vertex index
        indV1 = vertexIndexMap(iVertex);
        
        % update the reference germ associated to current skeleton vertex
        vertexGermInds(indV1) = iGerm;
        
        % compute indices of adjacent vertices (in cell)
        iPrev = cellVertices(mod(k - 2, nCellVertices) + 1);
        iNext = cellVertices(mod(k, nCellVertices) + 1);
        
        % keep only the neighbors within the polygon
        if insideFlag(iPrev) == 1
            adjList{indV1} = [adjList{indV1} vertexIndexMap(iPrev)];
        end
        if insideFlag(iNext) == 1
            adjList{indV1} = [adjList{indV1} vertexIndexMap(iNext)];
        end
    end
end

% cleanup to avoid duplicate indices
for iVertex = 1:nInnerVertices
    adjList{iVertex} = unique(adjList{iVertex});
end


%% Compute radius list

% for each voronoi vertex inside the polygon, compute the distance to
% original polygon.
% Find indices of germs associated to each vertex.
% By construction, each vertex is the circumcenter of three germs.
radiusList = zeros(nInnerVertices, 1);
for iVertex = 1:nInnerVertices
    radiusList(iVertex) = norm(poly(vertexGermInds(iVertex),:) - innerVertices(iVertex,:));
end


%% Format output

if nargout <= 1
    % format output to a struct
    varargout{1} = struct('vertices', {innerVertices}, 'adjList', {adjList}, 'radius', {radiusList});
elseif nargout == 2
    varargout = {innerVertices, adjList};
elseif nargout == 3
    varargout = {innerVertices, adjList, radiusList};
end
