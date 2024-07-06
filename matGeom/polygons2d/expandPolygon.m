function loops = expandPolygon(poly, dist, varargin)
%EXPANDPOLYGON Expand a polygon by a given (signed) distance.
%
%   POLY2 = expandPolygon(POLY, DIST);
%   Associates to each edge of the polygon POLY the parallel line located
%   at distance DIST from the current edge, and compute intersections with
%   neighbor parallel lines. The input polygon POLY must be oriented
%   counter-clockwise. Otherwise, distance is computed inside the polygon.
%   The resulting polygon is simplified to remove inner "loops", and can
%   eventually be disconnected. 
%   The result POLY2 is a cell array, each cell containing a simple linear
%   ring. 
%   
%   This is a kind of dilation, but behaviour on corners is different.
%   This function keeps angles of polygons, but there is no direct relation
%   between the lengths of each polygon.
%
%   It is also possible to specify negative distance, and get all points
%   inside the polygon. If the polygon is convex, the result equals
%   morphological erosion of polygon by a ball with radius equal to the
%   given distance.
%
%   Example:
%   % Computes the negative offset of a non-convex polygon
%     poly = [10 10;30 10;30 30;20 20;10 30];
%     poly2 = expandPolygon(poly, -3);
%     figure;
%     drawPolygon(poly, 'linewidth', 2);
%     hold on; drawPolygon(poly2, 'm')
%     axis equal; axis([0 40 0 40]);
%
%   See also 
%   polygons2d, polygonLoops, polygonSelfIntersections 
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-05-14
% Copyright 2005-2024 INRA - TPV URPOI - BIA IMASTE

% default options
cleanupLoops = false;

% process input argument
while length(varargin) > 1
    paramName = varargin{1};
    switch lower(paramName)
        case 'cleanuploops'
            cleanupLoops = varargin{2};
        otherwise
            error(['Unknown parameter name: ' paramName]);
    end
    varargin(1:2) = [];
end

% eventually copy first point at the end to ensure closed polygon
if sum(poly(end, :) == poly(1,:)) ~= 2
    poly = [poly; poly(1,:)];
end

% number of vertices of the polygon
N = size(poly, 1)-1;

% find lines parallel to polygon edges located at distance DIST
lines = zeros(N, 4);
for i = 1:N
    side = createLine(poly(i,:), poly(i+1,:));
    lines(i, 1:4) = parallelLine(side, dist);
end

% compute intersection points of consecutive lines
lines = [lines;lines(1,:)];
poly2 = zeros(N, 2);
for i = 1:N
    poly2(i,1:2) = intersectLines(lines(i,:), lines(i+1,:));
end

% split result polygon into set of loops (simple polygons)
loops = polygonLoops(poly2);

% keep only loops whose distance to original polygon is correct
if cleanupLoops
    distLoop = zeros(length(loops), 1);
    for i = 1:length(loops)
        distLoop(i) = distancePolygons(loops{i}, poly);
    end
    loops = loops(abs(distLoop-abs(dist)) < abs(dist)/1000);
end
