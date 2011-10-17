function area = trimeshSurfaceArea(v, e, f)
%TRIMESHSURFACEAREA Surface area of a triangular mesh
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
%   See also
%   meshes3d, meshSurfaceArea
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-08-26,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% check input number
if nargin == 2
    f = e;
end

% compute two direction vectors, using first face vertex as origin
v1 = v(f(:, 2), :) - v(f(:, 1), :);
v2 = v(f(:, 3), :) - v(f(:, 1), :);

% area of each triangle is half the cross product norm
vn = vectorNorm(vectorCross3d(v1, v2));

% sum up and normalize
area = sum(vn) / 2;
