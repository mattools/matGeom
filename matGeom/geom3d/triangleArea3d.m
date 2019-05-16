function area = triangleArea3d(pt1, pt2, pt3)
%TRIANGLEAREA3D Area of a 3D triangle.
%
%   AREA = triangleArea3d(P1, P2, P3)
%   Computes area of the 3D triangle whose vertices are given by P1, P2 and
%   P3. Each vertex is either a 1-by-3 row vector, or an array with 3
%   columns, each column representing coordinate of a vertex.
%   The result AREA has as many rows as the number of rows of the largest
%   input array.
%   Compared to polygonArea3d, this function is assumed to be faster, as it
%   does not requires iteration over vertices. Moreover, it can be used to
%   computes the area of several triangles simultaneously.
%
%   AREA = triangleArea3d(PTS)
%   Concatenates vertex coordinates in a 3-by-3 array. Each row of the
%   array contains coordinates of one vertex.
%
%
%   Example
%   triangleArea3d([10 10 10], [30 10 10], [10 40 10])
%   ans = 
%       300
%
%   See also
%   polygons3d, polygonArea3d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-08-23,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% if data is given as one array, split vertices
if nargin == 1
    pt2 = pt1(2,:);
    pt3 = pt1(3,:);
    pt1 = pt1(1,:);
end

% compute individual vectors
v12 = bsxfun(@minus, pt2, pt1);
v13 = bsxfun(@minus, pt3, pt1);

% compute area from cross product
area = vectorNorm3d(cross(v12, v13, 2)) / 2;
