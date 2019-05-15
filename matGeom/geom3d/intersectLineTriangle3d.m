function [point, pos, isInside] = intersectLineTriangle3d(line, triangle, varargin)
%INTERSECTLINETRIANGLE3D Intersection point of a 3D line and a 3D triangle.
%
%   POINT = intersectLineTriangle3d(LINE, TRI)
%   Compute coordinates of the intersection point between the line LINE and
%   the triangle TRI.
%   LINE is a 1-by-6 row vector given as: [X0 Y0 Z0 DX DY DZ]
%   TRI is given either as a row vector [X1 Y1 Z1 X2 Y2 Z2 X3 Y3 Z3], or as
%   a 3-by-3 array, each row containing coordinates of one of the triangle
%   vertices.
%   The result is a 1-by-3 array containing coordinates of the intesection
%   point, or [NaN NaN NaN] if the line and the triangle do not intersect.
%
%   [POINT POS] = intersectLineTriangle3d(LINE, TRI)
%   Also returns the position of the intersection point on the line, or NaN
%   if the line and the supporting plane of the triangle are parallel.
%
%   [POINT POS ISINSIDE] = intersectLineTriangle3d(LINE, TRI)
%   Also returns a boolean value, set to true if the line and the triangle
%   intersect each other. Can be used for testing validity of result.
%
%   Example
%     line = [1 1 0 0 0 1];
%     tri = [0 0 5;5 0 0;0 5 0];
%     intersectLineTriangle3d(line, tri)
%     ans = 
%         1   1   3
%
%   See also
%   points3d, lines3d, polygons3d, intersectRayPolygon3d,
%   distancePointTriangle3d
%
%   References
%   Algorithm adapted from SoftSurfer Ray/Segment-Triangle intersection
%   http://softsurfer.com/Archive/algorithm_0105/algorithm_0105.htm
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-04-08,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


%% Default values

% default return value
point = [NaN NaN NaN];
pos = NaN;
isInside = false;

tol = 1e-13;
if ~isempty(varargin)
    tol = varargin{1};
end


%% Process inputs

% triangle edge vectors
if size(triangle, 2) > 3
    % triangle is given as a 1-by-9 row vector
    t0  = triangle(1:3);
    u   = triangle(4:6) - t0;
    v   = triangle(7:9) - t0;
else
    % triangle is given as a 3-by-3 array
    t0  = triangle(1, 1:3);
    u   = triangle(2, 1:3) - t0;
    v   = triangle(3, 1:3) - t0;
end


%% Compute intersection

% triangle normal
n   = cross(u, v);

% test for degenerate case of flat triangle
if vectorNorm3d(n) < tol
    return;
end

% line direction vector
dir = line(4:6);

% vector between triangle origin and line origin
w0 = line(1:3) - t0;

% compute projection of each vector on the plane normal
a = -dot(n, w0);
b = dot(n, dir);

% test case of line parallel to the triangle
if abs(b) < tol
    return;    
end

% compute intersection point of line with supporting plane
% If r < 0: point before ray
% If r > 1: point after edge
pos = a / b;

% coordinates of intersection point
point = line(1:3) + pos * dir;


%% test if intersection point is inside triangle

% normalize direction vectors of triangle edges
uu  = dot(u, u);
uv  = dot(u, v);
vv  = dot(v, v);

% coordinates of vector v in triangle basis
w   = point - t0;
wu  = dot(w, u);
wv  = dot(w, v);

% normalization constant
D = uv^2 - uu * vv;

% test first coordinate
s = (uv * wv - vv * wu) / D;
if s < 0.0 || s > 1.0
    point = [NaN NaN NaN];
    pos = NaN;
    return;
end

% test second coordinate, and third triangle edge
t = (uv * wu - uu * wv) / D;
if t < 0.0 || (s + t) > 1.0
    point = [NaN NaN NaN];
    pos = NaN;
    return;
end

% set the validity flag
isInside = true;

