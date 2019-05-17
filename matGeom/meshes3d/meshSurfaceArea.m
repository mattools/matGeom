function area = meshSurfaceArea(vertices, edges, faces)
%MESHSURFACEAREA Surface area of a polyhedral mesh.
%
%   S = meshSurfaceArea(V, F)
%   S = meshSurfaceArea(V, E, F)
%   Computes the surface area of the mesh specified by vertex array V and
%   face array F. Vertex array is a NV-by-3 array of coordinates. 
%   Face array can be a NF-by-3 or NF-by-4 numeric array, or a Nf-by-1 cell
%   array, containing vertex indices of each face.
%
%   This functions iterates on faces, extract vertices of the current face,
%   and computes the sum of face areas.
%
%   This function assumes faces are coplanar and convex. If faces are all
%   triangular, the function "trimeshSurfaceArea" should be more efficient.
%
%
%   Example
%     % compute the surface of a unit cube (should be equal to 6)
%     [v f] = createCube;
%     meshSurfaceArea(v, f)
%     ans = 
%         6
%
%   See also
%     meshes3d, trimeshSurfaceArea, meshVolume, meshFaceAreas,
%     meshFacePolygons, polygonArea3d
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2010-10-13,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.


% check input number
if nargin == 2
    faces = edges;
end

% pre-compute normals
normals = normalizeVector3d(meshFaceNormals(vertices, faces));

% init accumulator
area = 0;


if isnumeric(faces)
    % iterate on faces in a numeric array
    for i = 1:size(faces, 1)
        poly = vertices(faces(i, :), :);        
        area = area + polyArea3d(poly, normals(i,:));
    end
    
else
    % iterate on faces in a cell array
    for i = 1:length(faces)
        poly = vertices(faces{i}, :);
        area = area + polyArea3d(poly, normals(i,:));
    end
end


function a = polyArea3d(v, normal)

nv = size(v, 1);
v0 = repmat(v(1,:), nv, 1);
products = sum(cross(v-v0, v([2:end 1], :)-v0, 2), 1);
a = abs(dot(products, normal, 2))/2;
