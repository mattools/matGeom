function [intersects, edgeIndices] = intersectLinePolyline(line, poly, varargin)
%INTERSECTLINEPOLYLINE Intersection points between a line and a polyline.
%
%   P = intersectLinePolyline(LINE, POLY)
%   Returns the intersection points of the lines LINE with polyline POLY. 
%   LINE is a 1-by-4 row vector containing parametric representation of the
%   line (in the format [x0 y0 dx dy], see the function 'createLine' for
%   details). 
%   POLY is a NV-by-2 array containing coordinates of the polyline vertices
%   P is a K-by-2 array containing the coordinates of the K intersection
%   points.
%
%   P = intersectLinePolyline(LINE, POLY, TOL)
%   Specifies the tolerance for geometric tests. Default is 1e-14.
%
%   [P INDS] = intersectLinePolyline(...)
%   Also returns the indices of edges involved in intersections. INDS is a
%   K-by-1 column vector, such that P(i,:) corresponds to intersection of
%   the line with the i-th edge of the polyline. If the intersection occurs
%   at a polyline vertex, the index of only one of the two neighbor edges
%   is returned. 
%   Note that due to numerical approximations, the use of function
%   'isPointOnEdge' may give results not consistent with this function.
%
%
%   Examples
%   % compute intersections between a square and an horizontal line
%     poly = [0 0;10 0;10 10;0 10];
%     line = [5 5 1 0];
%     intersectLinePolyline(line, poly)
%     ans =
%           10     5
%     % also return indices of edges
%     [inters inds] = intersectLinePolyline(line, poly)
%     inters =
%           10     5
%     inds =
%           2
%      
%   % compute intersections between a square and a diagonal line
%     poly = [0 0;10 0;10 10;0 10];
%     line = [5 5 1 1];
%     intersectLinePolyline(line, poly)
%     ans =
%            0     0
%           10    10
%
%   See Also
%   lines2d, polylines2d, intersectLines, intersectLinePolygon
%

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2003-10-31
% Copyright 2003 INRA - TPV URPOI - BIA IMASTE

% get computation tolerance
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% create the array of edges
N = size(poly, 1);
edges = [poly(1:N-1, :) poly(2:N, :)];

% compute intersections with supporting lines of polyline edges
supportLines = edgeToLine(edges);
intersects = intersectLines(line, supportLines, tol);

% find edges that are not parallel to the input line
inds = find(isfinite(intersects(:, 1)));

% compute position of intersection points on corresponding lines
pos = linePosition(intersects(inds, :), supportLines(inds, :), 'diag');

% and keep only intersection points located on edges
b = pos > -tol & pos < 1+tol;
inds = inds(b);
intersects = intersects(inds, :);

% remove multiple vertices (can occur for intersections located at polyline
% vertices)
[intersects, I, J] = unique(intersects, 'rows'); %#ok<ASGLU>

if nargout > 1
    % return indices of edges involved in intersection
    % (in case of intersection located at a vertex, only one of the
    % neighbor edges is returned)
    edgeIndices = inds(I);
end
