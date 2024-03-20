function normals = vertexNormal(vertices, faces)
%VERTEXNORMAL Compute normals to a mesh vertices.
%
%   N = vertexNormal(V, F)
%   Computes vertex normals of the mesh given by vertices V and F. 
%   V is a vertex array with 3 columns, F is either a NF-by-3 or NF-by-4
%   index array, or a cell array with NF elements.
%
%   Example
%     % Draw the vertex normals of a sphere
%     s = [10 20 30 40];
%     [v f] = sphereMesh(s);
%     drawMesh(v, f);
%     view(3);axis equal; light; lighting gouraud;
%     normals = vertexNormal(v, f);
%     drawVector3d(v, normals);
%
%   See also 
%     meshes3d, meshFaceNormals, triangulateFaces

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2011-12-19, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2023 INRA - Cepia Software Platform

warning('matGeom:deprecated', ...
    'The function ''vertexNormal'' is deprecated. Use ''meshVertexNormals'' instead.');

nv = size(vertices, 1);
nf = size(faces, 1);

% unit normals to the faces
faceNormals = normalizeVector3d(meshFaceNormals(vertices, faces));

% compute normal of each vertex: sum of normals to each face
normals = zeros(nv, 3);
if isnumeric(faces)
    for i = 1:nf
        face = faces(i, :);
        for j = 1:length(face)
            v = face(j);
            normals(v, :) = normals(v,:) + faceNormals(i,:);
        end
    end
else
    for i = 1:nf
        face = faces{i};
        for j = 1:length(face)
            v = face(j);
            normals(v, :) = normals(v,:) + faceNormals(i,:);
        end
    end
end

% normalize vertex normals to unit vectors
normals = normalizeVector3d(normals);


