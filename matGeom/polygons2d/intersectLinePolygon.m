function [intersects edgeIndices] = intersectLinePolygon(line, poly, varargin)
%INTERSECTLINEPOLYGON Intersection points between a line and a polygon
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
%   [P INDS] = intersectLinePolygon(...)
%   Also returns the indices of edges involved in intersections. INDS is a
%   K-by-1 column vector, such that P(i,:) corresponds to intersection of
%   the line with the i-th edge of the polygon. If the intersection occurs
%   at a polygon vertex, the index of only one of the two neighbor edges is
%   returned. 
%   Note that due to numerical approximations, the use of function
%   'isPointOnEdge' may give results not consistent with this function.
%
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
%     [inters inds] = intersectLinePolygon(line, poly)
%     inters =
%           10     5
%            0     5
%     inds =
%           4
%           2
%      
%   % compute intersections between a square and a diagonal line
%     poly = [0 0;10 0;10 10;0 10];
%     line = [5 5 1 1];
%     intersectLinePolygon(line, poly)
%     ans =
%            0     0
%           10    10
%
%   See Also
%   lines2d, polygons2d, intersectLines, intersectRayPolygon
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

%   HISTORY
%   2008-11-24 rename 'pi' as 'intersects', update doc
%   2009-07-23 removed forgotten occurence of 'pi' variable (thanks to Bala
%       Krishnamoorthy)
%   2010-01-26 rewrite using vectorisation
%   2011-05-20 returns unique results
%   2011-07-20 returns intersected edge indices

% get computation tolerance
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% create the array of edges
N = size(poly, 1);
edges = [poly(1:N, :) poly([2:N 1], :)];

% compute intersections with supporting lines of polygon edges
supportLines = edgeToLine(edges);
intersects = intersectLines(line, supportLines, tol);

% find edges that are not parallel to the input line
inds = find(isfinite(intersects(:, 1)));

% compute position of intersection points on corresponding lines
pos = linePosition(intersects(inds, :), supportLines(inds, :));

% and keep only intersection points located on edges
b = pos > -tol & pos < 1+tol;
inds = inds(b);
intersects = intersects(inds, :);

% remove multiple vertices (can occur for intersections located at polygon
% vertices)
[intersects I J] = unique(intersects, 'rows'); %#ok<NASGU>

if nargout > 1
    % return indices of edges involved in intersection
    % (in case of intersection located at a vertex, only one of the
    % neighbor edges is returned)
    edgeIndices = inds(I);
end
