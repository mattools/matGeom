function [vertices, facets] = triangulatePolygonPair(poly1, poly2)
%TRIANGULATEPOLYGONPAIR Compute triangulation between a pair of 3D closed curves
%
%   [V, F] = triangulatePolygonPair(POLY1, POLY2)
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
%     [vertices, faces] = triangulatePolygonPair(curve1, curve2);
%     % display the resulting mesh
%     figure(2); clf; hold on;
%     drawMesh(vertices, faces);
%     drawPolygon3d(curve1, 'color', 'b', 'linewidth', 2);
%     drawPolygon3d(curve2, 'color', 'g', 'linewidth', 2);
%     view(3); axis equal;
%
%   See also
%     meshes3D, triangulateCurvePair, meshSurfaceArea
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2017-05-18,    using Matlab 9.1.0.441655 (R2016b)
% Copyright 2017 INRA - Cepia Software Platform.


%% Memory allocation

% concatenate vertex coordinates for creating mesh
vertices = [poly1 ; poly2];

% number of vertices on each polygon
n1 = size(poly1, 1);
n2 = size(poly2, 1);

% allocate the array of facets (each edge of each polygon provides a facet)
nFacets = n1 + n2;
facets = zeros(nFacets, 3);


%% Init iteration

% find the pair of points with smallest distance.
% This will be the current diagonal.
[dists, inds] = minDistancePoints(poly1, poly2);
[dummy, ind1] = min(dists); %#ok<ASGLU>
ind2 = inds(ind1);

% consider two consecutive vertices on each polygon
currentIndex1 = ind1;
currentIndex2 = ind2;


%% Main iteration
% For each diagonal, consider the two possible facets (one for each 'next'
% vertex on each polygon), each create current facet according to the
% closest one. 
% Then update current diagonal for next iteration.

for i = 1:nFacets
    nextIndex1 = mod(currentIndex1, n1) + 1;
    nextIndex2 = mod(currentIndex2, n2) + 1;
    
    % compute lengths of diagonals
    dist1 = distancePoints(poly1(currentIndex1, :), poly2(nextIndex2,:));
    dist2 = distancePoints(poly1(nextIndex1, :), poly2(currentIndex2,:));
    
    if dist1 < dist2
        % keep current vertex of curve1, use next vertex on curve2
        facet = [currentIndex1 currentIndex2+n1 nextIndex2+n1];
        currentIndex2 = nextIndex2;
    else
        % keep current vertex of curve2, use next vertex on curve1
        facet = [currentIndex1 currentIndex2+n1 nextIndex1];
        currentIndex1 = nextIndex1;
    end
    
    % create the facet
    facets(i, :) = facet;
end

