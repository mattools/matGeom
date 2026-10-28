function polys = sphericalVoronoiDiagram(pts)
%SPHERICALVORONOIDIAGRAM Spherical Voronoi Diagram on the unit sphere.
%
%   POLYS = sphericalVoronoiDiagram(PTS)
%   Computes the spherical Voronoi diagram of the points PTS, and returns
%   the spherical polygons associated to each point. PTS is a N-by-3 array
%   of point coordinates, that are expected to correspond to points on the
%   unit sphere (i.e., distance of points to the origin should be 1).
%   The result POLYS is a cell array with as many elements as the number of
%   points. Each cell contain a polygon representing the spherical domain
%   associated to each germ point. Edges of the spherical polygons are
%   resampled such that the resulting curve can be displayed on the unit
%   sphere.
%
%   POLYS = sphericalVoronoiDiagram(PTS, SPACING)
%   Specifies the approximate spacing between resulting polygon vertices.
%   Default value is 0.1.
%
%
%   Example
%     %  create random points within the unit ball
%     n = 100; rng(42);
%     pts = rand(n, 3) - 0.5;
%     pts = pts(vectorNorm3d(pts) < 0.5, :);
%     % project remaining points on the sphere surface
%     pts = normalizeVector3d(pts);
%     figure; hold on; axis equal; axis([-1.2 1.2 -1.2 1.2 -1.2 1.2]); view(3);
%     drawSphere([0 0 0 1], 'faceColor', [0.8 0.8 0.8]);
%     drawPoint3d(pts, 'ko');
%     % compute spherical polygons
%     polys = sphericalVoronoiDiagram(pts);
%     % display the result
%     drawPolygon3d(polys, 'color', 'b')
%
%   An alternative function is the following one:
%   https://fr.mathworks.com/matlabcentral/fileexchange/40989-voronoi-sphere/files/VoronoiSphere/voronoisphere.m
%
%   See also
%      drawSphericalPolygon, sphericalVoronoiDomain

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2026-10-15,    using Matlab 26.1.0.3251617 (R2026a) Update 2
% Copyright 2026 INRAE.


% the unit sphere
sphere = [0 0 0 1];
maxStep = 0.1;

% ensure points lie on the unit sphere
pts = normalizeVector3d(pts);
nPoints = size(pts, 1);

% compute 3D convex hull to retrieve neighbors of each point
tri = convexHull(delaunayTriangulation(pts));

% allocate memory for result array
polys = cell(nPoints, 1);

% iterate on germ points
for iPoint = 1:nPoints
    refPoint = pts(iPoint, :);

    % find index of neighbor points
    neighs = unique(tri(sum(tri == iPoint, 2) > 0, :));
    neighs(neighs == iPoint) = [];
    nNeighs = length(neighs);

    % re-order neighbor points according to their angle around current point
    tangentPlane = createPlane(refPoint, refPoint);
    neighs2d = planePosition(projPointOnPlane(pts(neighs, :), tangentPlane), tangentPlane);
    [~, order] = angleSort(neighs2d);
    neighs = neighs(order);

    % compute planes containing separating circles
    planes = zeros(nNeighs, 9);
    for iNeigh = 1:nNeighs
        planes(iNeigh,:) = medianPlane(refPoint, pts(neighs(iNeigh), :));
    end

    % compute circle-circle intersections
    lines = zeros(nNeighs, 6);
    intersects = zeros(nNeighs * 2, 3);
    for i = 1:nNeighs
        indP2 = mod(i, nNeighs) + 1;
        lines(i, :) = intersectPlanes(planes(i,:), planes(indP2,:));
        intersects(2*i-1:2*i, :) = intersectLineSphere(lines(i,:), sphere);
    end

    % keep intersections in the same 'direction' as the reference point
    intersects(dot(intersects, repmat(refPoint, nNeighs*2, 1), 2) < 0, :) = [];

    % create 3D polygon by interpolating between intersection points
    poly = zeros(0, 3);
    for i = 1:nNeighs
        v1 = intersects(i, :);
        v2 = intersects(mod(i, nNeighs) + 1, :);
        pts2 = subdivideEdge(v1, v2, maxStep);
        poly = [poly ; pts2(1:end-1,:)]; %#ok<AGROW>
    end

    % project points onto the unit sphere
    polys{iPoint} = normalizeVector3d(poly);
end

function res = subdivideEdge(v1, v2, maxStep)
% generate a polyline between two vertices, providing approximate distance
% between adjacent resulting points.
d12 = distancePoints(v1, v2);
nDivs = floor(d12 / maxStep) + 1;
ti = linspace(0, 1, nDivs+1)';
res = v1 .* (1-ti) + v2 .* ti;