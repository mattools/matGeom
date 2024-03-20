function point = intersectEdgePlane(edge, plane, varargin)
%INTERSECTEDGEPLANE Return intersection point between a plane and a edge.
%
%   PT = intersectEdgePlane(edge, PLANE) return the intersection point of
%   the given edge and the given plane.
%   PLANE : [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2]
%   edge :  [x1 y1 z1 x2 y2 z2]
%   PT :    [xi yi zi]
%   If EDGE and PLANE are parallel, return [NaN NaN NaN].
%   If EDGE (or PLANE) is a matrix with 6 (or 9) columns and N rows, result
%   is an array of points with N rows and 3 columns.
%   
%   Example:
%   edge = [5 5 -1 5 5 1];
%   plane = [0 0 0 1 0 0 0 1 0];
%   intersectEdgePlane(edge, plane)     % should return [5 5 0].
%   ans =
%       5   5   0
%
%   See also 
%   planes3d, intersectLinePlane, createLine3d, createPlane
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2007-04-24, from intersectLinePlane
% Copyright 2007-2023 INRA - TPV URPOI - BIA IMASTE

% extract tolerance for determination of parallel edges and planes
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% number of planes and edges
np = size(plane, 1);
ne = size(edge, 1);

% unify sizes of data
if np ~= ne
    if ne == 1
        % one edge and many planes
        edge = edge(ones(np, 1), :);
    elseif np == 1
        % one plane possible many edges
        plane = plane(ones(ne, 1), :);
    else
        % N planes and M edges, not allowed for now.
        error('Should have the same number of planes and edges');
    end
end

% initialize empty arrays
point = zeros(size(plane, 1), 3);
t = zeros(size(plane,1),3);

% plane normal
n = cross(plane(:,4:6), plane(:,7:9), 2);

% create line supporting edge
line = createLine3d(edge(:,1:3), edge(:,4:6));

% get indices of edge and plane which are parallel
par = abs(dot(n, line(:,4:6), 2)) < tol;
point(par,:) = NaN;
t(par) = NaN;

% difference between origins of plane and edge
dp = plane(:, 1:3) - line(:, 1:3);

% relative position of intersection on line
%t = dot(n(~par,:), dp(~par,:), 2)./dot(n(~par,:), line(~par,4:6), 2);
t(~par) = dot(n(~par,:), dp(~par,:), 2) ./ dot(n(~par,:), line(~par,4:6), 2);

% compute coord of intersection point
%point(~par, :) = line(~par,1:3) + repmat(t,1,3).*line(~par,4:6);
point(~par, :) = line(~par,1:3) + repmat(t(~par),1,3) .* line(~par,4:6);

% set points outside of edge to [NaN NaN NaN]
point(t<0, :) = NaN;
point(t>1, :) = NaN;
