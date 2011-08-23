function area = triangleArea3d(pt1, pt2, pt3)
%TRIANGLEAREA3D Area of a 3D triangle
%
%   AREA = triangleArea3d(P1, P2, P3)
%   Computes area of the 3D triangle whose vertices are given by P1, P2 and
%   P3. Each vertex is a 1-by-3 row vector.
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
%
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
area = vectorNorm(cross(v12, v13, 2)) / 2;
