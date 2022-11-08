function [points, edgeInds, linePositions] = intersectLinePolygon(line, poly, varargin)
%INTERSECTLINEPOLYGON Intersection points between a line and a polygon.
%
%   P = intersectLinePolygon(LINE, POLY)
%   Returns the intersection points of the lines LINE with polygon POLY. 
%   LINE is a 1-by-4 row vector containing parametric representation of the
%   line (in the format [x0 y0 dx dy], see the function 'createLine' for
%   details). 
%   POLY is a NV-by-2 array containing coordinates of the polygon vertices
%   P is a K-by-2 array containing the coordinates of the K intersection
%   points.
%
%   P = intersectLinePolygon(LINE, POLY, TOL)
%   Specifies the tolerance for geometric tests. Default is 1e-14.
%
%   [P, INDS] = intersectLinePolygon(...)
%   Also returns the indices of edges involved in intersections. INDS is a
%   K-by-1 column vector, such that P(i,:) corresponds to intersection of
%   the line with the i-th edge of the polygon. If the intersection occurs
%   at a polygon vertex, the index of only one of the two neighbor edges is
%   returned. 
%   Note that due to numerical approximations, the use of function
%   'isPointOnEdge' may give results not consistent with this function.
%
%   [P, INDS, POS] = intersectLinePolygon(...)
%   Also returns the relative position of each intersection point along the
%   line. The position can be used to sort the points.
%
%   Examples
%   % compute intersections between a square and an horizontal line
%     poly = [0 0;10 0;10 10;0 10];
%     line = [5 5 1 0];
%     intersectLinePolygon(line, poly)
%     ans =
%           10     5
%            0     5
%     % also return indices of edges
%     [inters, inds] = intersectLinePolygon(line, poly)
%     inters =
%           10     5
%            0     5
%     inds =
%           4
%           2
%     
%     % Potentially prolematic case
%     % create a polygon with various configurations at y=50
%     poly = [10 30;30 50;45 30; 50 50; 60 70; 70 50; ...
%         90 30; 80 80; 50 80; 40 50; 30 80; 20 80];
%     figure; axis([0 100 0 100]); hold on;
%     drawPolygon(poly, 'b'); drawPoint(poly, 'b.');
%     % Computes intersection with horizontal line at y=50
%     line = [10 50 2 0]; drawLine(line, 'm');
%     points = intersectLinePolygon(line, poly);
%     % result is a 6-by-2 numeric array, with a double intersection
%     % (indices 2 and 3), resulting in five displayed intersections.
%     drawPoint(points, 'ko');
%     % sort intersection points according to x-coordinate
%     points2 = sortrows(points, 1);
%     % display pairs of successive intersection points as colored lines
%     for i = 1:2:size(points2, 1)
%         drawEdge(points2(i,:), points2(i+1,:), 'linewidth', 2);
%     end
%
%   References
%     https://web.cs.ucdavis.edu/~ma/ECS175_S00/Notes/0411_b.pdf
%     https://alienryderflex.com/polygon_fill/
%
%   See Also
%   lines2d, polygons2d, intersectLines, intersectRayPolygon, polygonEdges
%

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2003-10-31,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% 2022-02-14: new algorithm, more robust to numerical issues, but that can
% change behaviour compared to previous implementation

% line origin and angle
ox = line(1);
oy = line(2);
dx = line(3);
dy = line(4);

% create transform matrix that project line onto the horizontal axis
% (then, computation of intersections rely only on the y-coordinate)
theta = atan2(dy, dx);
s = hypot(dx, dy);
cot = cos(theta) / s;
sit = sin(theta) / s;
transfo = [cot sit 0; -sit cot 0; 0 0 1] * [1 0 -ox; 0 1 -oy; 0 0 1];

% number of vertices in polygon
nVertices = size(poly, 1);

%  create arrays for storing x-coordinates and edge inds of intersections
linePositions = [];
edgeInds = [];

% retrieve previous vertex and its y-coordinate
ivp = nVertices;
previousVertex = transformPoint(poly(ivp,:), transfo);
yvp = previousVertex(2);

% iterate over indices of first edge vertex
for iv = 1:nVertices
    % current vertex and its y-coordinate
    currentVertex = transformPoint(poly(iv,:), transfo);
    yv = currentVertex(2);
    
    % check conditions for intersection
    % either if:
    % 1) previous vertex is above or on, and current vertex is strictly below
    % 2) previous vertex is strictly below, and current vertex is above or on
    if  yvp >= 0 && yv < 0 || yvp < 0 && yv >= 0
        % slope of current edge (dy cannot be zero due to above condition)
        edgeDx = currentVertex(1) - previousVertex(1);
        edgeDy = currentVertex(2) - previousVertex(2);
        % position of intersection on the horizontal line
        currentPos = currentVertex(1) - yv * edgeDx / edgeDy ;
        % add to list of intersections
        linePositions = [linePositions ; currentPos]; %#ok<AGROW>
        % keep list if edge indices
        edgeInds = [edgeInds ; ivp]; %#ok<AGROW>
    end
    
    % switch current vertex to previous vertex
    previousVertex = currentVertex;
    ivp = iv; % keep edge index for optional output
    yvp = yv;
end

% format output result into a N-by-2 array of points
if ~isempty(linePositions)
    points = [linePositions zeros(size(linePositions))];
    points = transformPoint(points, inv(transfo));
    linePositions = linePositions;
else
    points = [];
end
