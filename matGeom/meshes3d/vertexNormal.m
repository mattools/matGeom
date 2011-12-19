function normals = vertexNormal(vertices, faces)
%VERTEXNORMAL Compute normals to a mesh vertices
%
%   output = vertexNormal(input)
%
%   Example
%   vertexNormal
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-12-19,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


nv = size(vertices, 1);
nf = size(faces, 1);

% unit normals to the faces
faceNormals = normalizeVector3d(faceNormal(vertices, faces));

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


