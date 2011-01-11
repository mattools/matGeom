function area = meshArea(vertices, edges, faces)
%MESHSURFACEAREA Surface area of a polyhedral mesh
%
%   output = meshArea(input)
%
%   Example
%   meshArea
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-10-13,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

if nargin==2
    faces = edges;
end

% pre-compute normals
normals = normalizeVector3d(faceNormal(vertices, faces));

area = 0;

if isnumeric(faces)
    for i=1:size(faces, 1)
        poly = vertices(faces(i, :), :);        
        area = area + polyArea3d(poly, normals(i,:));
    end
else
    for i=1:size(faces, 1)
        poly = vertices(faces{i}, :);
        area = area + polyArea3d(poly, normals(i,:));
    end
end


function a = polyArea3d(v, normal)

nv = size(v, 1);
v0 = repmat(v(1,:), nv, 1);
products = sum(cross(v-v0, v([2:end 1], :)-v0, 2), 1);
a = abs(dot(products, normal, 2))/2;
