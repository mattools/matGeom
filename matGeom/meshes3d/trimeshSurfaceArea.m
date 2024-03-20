function area = trimeshSurfaceArea(v, e, f)
%TRIMESHSURFACEAREA Surface area of a triangular mesh.
%
%   S = trimeshSurfaceArea(V, F)
%   S = trimeshSurfaceArea(V, E, F)
%   Computes the surface area of the mesh specified by vertex array V and
%   face array F. Vertex array is a NV-by-3 array of coordinates. 
%   Face array is a NF-by-3, containing vertex indices of each face.
%
%   Example
%     % Compute area of an octahedron (equal to 2*sqrt(3)*a*a, with 
%     % a = sqrt(2) in this case)
%     [v f] = createOctahedron;
%     trimeshSurfaceArea(v, f)
%     ans = 
%         6.9282
%
%     % triangulate a compute area of a unit cube
%     [v f] = createCube;
%     f2 = triangulateFaces(f);
%     trimeshSurfaceArea(v, f2)
%     ans =
%         6
%
%   See also 
%   meshes3d, meshSurfaceArea, trimeshMeanBreadth, triangulateFaces

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2011-08-26, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2023 INRA - Cepia Software Platform

% check input number
if nargin == 2
    f = e;
end

% compute two direction vectors, using first vertex of each face as origin
v1 = v(f(:, 2), :) - v(f(:, 1), :);
v2 = v(f(:, 3), :) - v(f(:, 1), :);

% area of each triangle is half the cross product norm
vn = vectorNorm3d(crossProduct3d(v1, v2));

% sum up and normalize
area = sum(vn) / 2;
