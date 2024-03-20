function b = isPointOnEdge(point, edge, varargin)
%ISPOINTONEDGE Test if a point belongs to an edge.
%
%   Usage
%   B = isPointOnEdge(POINT, EDGE)
%   B = isPointOnEdge(POINT, EDGE, TOL)
%
%   Description
%   B = isPointOnEdge(POINT, EDGE)
%   with POINT being [xp yp], and EDGE being [x1 y1 x2 y2], returns TRUE if
%   the point is located on the edge, and FALSE otherwise.
%
%   B = isPointOnEdge(POINT, EDGE, TOL)
%   Specify an optilonal tolerance value TOL. The tolerance is given as a
%   fraction of the norm of the edge direction vector. Default is 1e-14. 
%
%   B = isPointOnEdge(POINTARRAY, EDGE)
%   B = isPointOnEdge(POINT, EDGEARRAY)
%   When one of the inputs has several rows, return the result of the test
%   for each element of the array tested against the single parameter.
%
%   B = isPointOnEdge(POINTARRAY, EDGEARRAY)
%   When both POINTARRAY and EDGEARRAY have the same number of rows,
%   returns a column vector with the same number of rows.
%   When the number of rows are different and both greater than 1, returns
%   a Np-by-Ne matrix of booleans, containing the result for each couple of
%   point and edge.
%
%   Examples
%   % create a point array
%   points = [10 10;15 10; 30 10];
%   % create an edge array
%   vertices = [10 10;20 10;20 20;10 20];
%   edges = [vertices vertices([2:end 1], :)];
%
%   % Test one point and one edge
%   isPointOnEdge(points(1,:), edges(1,:))
%   ans = 
%       1
%   isPointOnEdge(points(3,:), edges(1,:))
%   ans = 
%       0
%
%   % Test one point and several edges
%   isPointOnEdge(points(1,:), edges)'
%   ans =
%        1     0     0     1
%
%   % Test several points and one edge
%   isPointOnEdge(points, edges(1,:))'
%   ans =
%        1     1     0
%
%   % Test N points and N edges
%   isPointOnEdge(points, edges(1:3,:))'
%   ans =
%        1     0     0
%
%   % Test NP points and NE edges
%   isPointOnEdge(points, edges)
%   ans =
%        1     0     0     1
%        1     0     0     0
%        0     0     0     0
%
%
%   See also 
%   edges2d, points2d, isPointOnLine
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-10-31
% Copyright 2003-2023 INRA - TPV URPOI - BIA IMASTE

% extract computation tolerance
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% number of edges and of points
nPoints = size(point, 1);
nEdges = size(edge, 1);

% adapt size of inputs if needed, and extract elements for computation
if nPoints == nEdges
    % When the number of points and edges is the same, the one-to-one test
    % will be computed, so there is no need to repeat matrices
    dx = edge(:,3) - edge(:,1);
    dy = edge(:,4) - edge(:,2);
    lx = point(:,1) - edge(:,1);
    ly = point(:,2) - edge(:,2);
    
elseif nPoints == 1
    % one point, several edges
    dx = edge(:, 3) - edge(:, 1);
    dy = edge(:, 4) - edge(:, 2);
    lx = point(ones(nEdges, 1), 1) - edge(:, 1);
    ly = point(ones(nEdges, 1), 2) - edge(:, 2);
    
elseif nEdges == 1
    % several points, one edge
    dx = (edge(3) - edge(1)) * ones(nPoints, 1);
    dy = (edge(4) - edge(2)) * ones(nPoints, 1);
    lx = point(:, 1) - edge(1);
    ly = point(:, 2) - edge(2);

else
    % Np points and Ne edges:
    % Create an array for each parameter, so that the result will be a
    % Np-by-Ne matrix of booleans (requires more memory, and uses repmat)

    x0 = repmat(edge(:, 1)', nPoints, 1);
    y0 = repmat(edge(:, 2)', nPoints, 1);
    dx = repmat(edge(:, 3)', nPoints,  1) - x0;
    dy = repmat(edge(:, 4)', nPoints,  1) - y0;
    
    lx = repmat(point(:, 1), 1, nEdges) - x0;
    ly = repmat(point(:, 2), 1, nEdges) - y0;
end

% test if point is located on supporting line
b1 = abs(lx.*dy - ly.*dx) ./ (dx.*dx + dy.*dy) < tol;

% compute position of point with respect to edge bounds
% use different tests depending on line angle
ind     = abs(dx) > abs(dy);
t       = zeros(size(dx));
t(ind)  = lx( ind) ./ dx( ind);
t(~ind) = ly(~ind) ./ dy(~ind);

% check if point is located between edge bounds
b = t >- tol & t-1 < tol & b1;
