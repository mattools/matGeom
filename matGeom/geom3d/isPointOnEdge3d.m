function b = isPointOnEdge3d(point, edge, varargin)
% Test if a 3D point belongs to an edge.
%
%   Usage
%   B = isPointOnEdge3d(POINT, EDGE)
%   B = isPointOnEdge3d(POINT, EDGE, TOL)
%
%   Description
%   B = isPointOnEdge3d(POINT, EDGE)
%   with POINT being [xp yp zp], and EDGE being [x1 y1 z1  x2 y2 z2],
%   returns TRUE if the point is located on the edge, and FALSE otherwise.
%
%   B = isPointOnEdge3d(POINT, EDGE, TOL)
%   Specify an optilonal tolerance value TOL. The tolerance is given as a
%   fraction of the norm of the edge direction vector. Default is 1e-14. 
%
%   B = isPointOnEdge3d(POINTARRAY, EDGE)
%   B = isPointOnEdge3d(POINT, EDGEARRAY)
%   When one of the inputs has several rows, return the result of the test
%   for each element of the array tested against the single parameter.
%
%   B = isPointOnEdge3d(POINTARRAY, EDGEARRAY)
%   When both POINTARRAY and EDGEARRAY have the same number of rows,
%   returns a column vector with the same number of rows.
%   When the number of rows are different and both greater than 1, returns
%   a Np-by-Ne matrix of booleans, containing the result for each couple of
%   point and edge.
%
%   Examples
%   % create a point array
%   points = [10 10 20;15 10 20; 30 10 20];
%   % create an edge array
%   vertices = [10 10 20;20 10 20;20 20 20;10 20 20];
%   edges = [vertices vertices([2:end 1], :)];
%
%   % Test one point and one edge
%   isPointOnEdge3d(points(1,:), edges(1,:))
%   ans = 
%       1
%   isPointOnEdge3d(points(3,:), edges(1,:))
%   ans = 
%       0
%
%   % Test one point and several edges
%   isPointOnEdge3d(points(1,:), edges)'
%   ans =
%        1     0     0     1
%
%   % Test several points and one edge
%   isPointOnEdge3d(points, edges(1,:))'
%   ans =
%        1     1     0
%
%   % Test N points and N edges
%   isPointOnEdge3d(points, edges(1:3,:))'
%   ans =
%        1     0     0
%
%   % Test NP points and NE edges
%   isPointOnEdge3d(points, edges)
%   ans =
%        1     0     0     1
%        1     0     0     0
%        0     0     0     0
%
%
%   See also
%   edges3d, points3d, isPointOnLine3d
%



% extract computation tolerance
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% supporting line of the edge
line = edgeToLine3d(edge);

% check if point belong to supporting line
onLine = isPointOnLine3d(point, line, tol);

% check if position is within the [0 1] bounds
pos = linePosition3d(point, line);
withinBounds = pos > -tol & pos < 1+tol;

b = onLine & withinBounds;
