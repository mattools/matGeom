function [tri, weight] = triangulatePolygonPair3d(poly1, poly2, varargin)
%TRIANGULATEPOLYGONPAIR3D Compute a triangulation between a pair of 3D polygons.
%
%   TRI = triangulatePolygonPair3d(POLY1, POLY2)
%   Computes a triangulation between vertices of the two input polygons.
%   Each triangle refer to one vertex of either POLY1 or POLY2, and two
%   vertices of the other polygon. Vertex indices correspond to the
%   concatenation of the two polygons. They range from 1 to NV1+NV2.
%   This version minimizes the surface area of the reconstructed surface.
%
%   [TRI, WEIGHT] = triangulatePolygonPair3d(POLY1, POLY2)
%   Also returns the optimal weigth of the reconstruction, corresponding to
%   the surface area of the triangulation.
%   
%   Example
%     % triangulate a surface patch between two ellipses
%     % create two sample curves
%     poly1 = ellipseToPolygon([50 50 40 20 0], 36);
%     poly2 = ellipseToPolygon([50 50 40 20 60], 36);
%     poly1 = poly1(1:end-1,:);
%     poly2 = poly2(1:end-1,:);
%     % transform to 3D polygons / curves
%     curve1 = [poly1 10*ones(size(poly1, 1), 1)];
%     curve2 = [poly2 20*ones(size(poly2, 1), 1)];
%     % draw as 3D curves
%     figure(1); clf; hold on;
%     drawPolygon3d(curve1, 'b'); drawPoint3d(curve1, 'bo');
%     drawPolygon3d(curve2, 'g'); drawPoint3d(curve2, 'go');
%     view(3); axis equal;
%     tri = triangulatePolygonPair3d(curve1, curve2);
%     vertices = [curve1 ; curve2];
%     % display the resulting mesh
%     figure(2); clf; hold on;
%     drawMesh(vertices, tri);
%     drawPolygon3d(curve1, 'color', 'b', 'linewidth', 2);
%     drawPolygon3d(curve2, 'color', 'g', 'linewidth', 2);
%     view(3); axis equal;
%
%   References
%   Based on the paper:
%   "Optimal surface reconstruction from planar contours", 
%   Fuchs, H., Kedem, Z. M., Uselton, S.P., 1977, Graphics and Image
%   Processing, 20(10), 693-702.
%
%   See also 
%     triangulatePolygonPair, triangleArea3d, meshSurfaceArea
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2022-01-14, using Matlab 9.10.0.1739362 (R2021a) Update 5
% Copyright 2022-2023 INRAE - BIA Research Unit - BIBS Platform (Nantes)

%% Init

% number of vertices of each contour
nv1 = size(poly1, 1);
nv2 = size(poly2, 1);

% compute weights for horizontal transitions between graph vertices
% corresponding to triangles with two vertices in poly2
weightsH = inf * ones(2*nv1+1, nv2);
for iv2 = 1:nv2
    v2 = poly2(mod(iv2, nv2)+1, :);
    for iv1 = 1:nv1
        v1 = poly1(iv1, :);
        weightsH(iv1, iv2) = distancePoints3d(v1, v2);
    end
end
weightsH((nv1+1):(2*nv1+1), :) = weightsH([1:nv1 1], :);

% compute weights for vertical transitions between graph vertices
% corresponding to triangles with two vertices in poly1
weightsV = inf * ones(2*nv1, nv2+1);
for iv1 = 1:nv1
    v1 = poly1(mod(iv1, nv1)+1, :);
    for iv2 = 1:nv2
        v2 = poly2(iv2, :);
        weightsV(iv1, iv2) = distancePoints3d(v1, v2);
    end
end
weightsV(1:nv1, nv2+1) = weightsV(1:nv1, 1);
weightsV(nv1+1:2*nv1, :) = weightsV(1:nv1, :);


%% Find minimum-weight path
% Note that the original paper proposes an enhanced method that should
% reduce the total amount of computation.

pathList = cell(1, nv1);
weights = zeros(nv1, 1);
for i1 = 1:nv1
    [pathList{i1}, weights(i1)] = computePath(i1, weightsH, weightsV);
end

% choose the path
[~, ind] = min(weights);
path = pathList{ind};

weight = weights(ind);


%% Convert path into triangle list

% as many triangles as the number of transitions
nt = size(path, 1) - 1;
tri = zeros(nt, 3);

% iterate over triangles
for it = 1:nt
    iv1 = path(it, 1);
    iv2 = path(it, 2);
    if path(it + 1, 1) == iv1
        % horizontal transition -> use edge from contour 2
        iv3 = mod(path(it, 2), nv2) + 1 + nv1;
    elseif path(it + 1, 2) == iv2
        % vertical transition -> use edge from contour 1
        iv3 = mod(path(it, 1), nv1) + 1;
    else
        error('Successive path positions must share one coordinate');
    end
    
    % convert grid vertex coords to vertex indices 
    % using one-based indexing modulo
    iv1 = mod(iv1 - 1, nv1) + 1; 
    iv2 = mod(iv2 - 1, nv2) + 1 + nv1; % also add the vertex count of poly1
    tri(it, :) = [iv1 iv2 iv3];
end


function [path, pathWeight] = computePath(i10, weightsH, weightsV)
%COMPUTEPATH Computes a minimal path within an unfolded toroidal graph.
%
%   PATH = computePath(INITROW, HWEIGHTS, VWEIGHTS);
%

%% retrieve info

% size of the search graph (number of graph vertices along each dimension)
ngv1 = size(weightsH, 1);
ngv2 = size(weightsV, 2);

% compute final index for i1
i1Last = i10 + (ngv1 - 1) / 2;


%% Initialize matrix of cumulated weights

% create matrix of cumulated  weights
cumWeights = inf * ones(ngv1, ngv2);
% init first row
cumWeights(i10, 1) = 0;
for i2 = 1:ngv2-1
    cumWeights(i10, i2+1) = cumWeights(i10, i2) + weightsH(i10, i2);
end
% init each subsequent row
for i1 = i10+1:i1Last
    % first vertex in row is initialized from the vertex above
    cumWeights(i1, 1) = cumWeights(i1-1, 1) + weightsV(i1-1, 1);
    % other vertices minimize weights from left or top vertices
    for i2 = 2:ngv2
        wH = cumWeights(i1, i2 - 1) + weightsH(i1, i2 - 1);
        wV = cumWeights(i1 - 1, i2) + weightsV(i1 - 1, i2);
        cumWeights(i1, i2) = min(wH, wV);
    end
end


%% Backpropagate to find path

% allocate path array
np = (ngv1 - 1) / 2 + ngv2;
path = zeros(np, 2);

% extreme points
path(1, :) = [i10 1];
path(end, :) = [i1Last ngv2];

% index of row and column
i1 = i1Last;
i2 = ngv2;

for iPath = np-1:-1:1
    % determine the weights associated to a move in the horizontal or
    % vertical direction
    moveLeft = true;
    if i2 == 1
        moveLeft = false;
    elseif i1 > i10
        wH = cumWeights(i1, i2-1);
        wV = cumWeights(i1-1, i2);
        moveLeft = wH < wV;
    end
    
    % update position of current grid vertex
    if moveLeft
        i2 = i2 - 1;
    else
        i1 = i1 - 1;
    end
    
    path(iPath, :) = [i1 i2];
end

pathWeight = cumWeights(i1Last, ngv2);
