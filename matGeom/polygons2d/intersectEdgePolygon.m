function [intersects inds] = intersectEdgePolygon(edge, poly, varargin)
%INTERSECTEDGEPOLYGON  Intersection point of an edge with a polygon
%
%   INTER = intersectEdgePolygon(EDGE, POLY)
%   Computes intersection(s) point(s) between the edge EDGE and the polygon
%   POLY. EDGE is given by [x1 y1 x2 y2]. POLY is a N-by-2 array of vertex
%   coordinates.
%   INTER is a M-by-2 array containing coordinates of intersection(s). It
%   can be empty if no intersection is found.
%
%   [INTER INDS] = intersectEdgePolygon(EDGE, POLY)
%   Also returns index/indices of edge(s) involved in intersections.
%
%   Example
%   % Intersection of an edge with a square
%     poly = [0 0;10 0;10 10;0 10];
%     edge = [9 2 9+3*1 2+3*2];
%     exp = [10 4];
%     inter = intersectEdgePolygon(edge, poly)
%     ans =
%         10   4
%
%   See also
%   edges2d, polygons2d, intersectLinePolygon, intersectRayPolygon
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-02-24,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% get computation tolerance
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

line = edgeToLine(edge);

[intersects inds] = intersectLinePolygon(line, poly, tol);

if ~isempty(intersects)
    pos = linePosition(intersects, line);
    keep = pos >= 0 & pos <= 1;
    intersects = intersects(keep, :);
    inds = inds(keep);
end
