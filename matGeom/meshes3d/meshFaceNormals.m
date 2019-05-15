function normals = meshFaceNormals(varargin)
%MESHFACENORMALS Compute normal vector of faces in a 3D mesh.
%
%   NORMALS = meshFaceNormals(VERTICES, FACES)
%   VERTICES is a set of 3D points (as a N-by-3 array), and FACES is either
%   a N-by-3 index array or a cell array of indices. The function computes
%   the normal vector of each face.
%   The orientation of the normal is defined by the sign of cross product
%   between vectors joining vertices 1 to 2 and 1 to 3.
%
%
%   Example
%     [v e f] = createIcosahedron;
%     normals1 = meshFaceNormals(v, f);
%     centros1 = meshFaceCentroids(v, f);
%     figure; drawMesh(v, f); 
%     hold on; axis equal; view(3);
%     drawVector3d(centros1, normals1);
%
%     pts = rand(50, 3);
%     hull = minConvexHull(pts);
%     normals2 = meshFaceNormals(pts, hull);
%
%   See also
%   meshes3d, meshFaceCentroids, meshVertexNormals, drawFaceNormals
%   drawMesh 

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2006-07-05
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

% HISTORY
% 2011-11-24 rename from faceNormal to meshFaceNormals

% parse input data
[vertices, faces] = parseMeshData(varargin{:});

if isnumeric(faces)
    % compute vector of first edges
	v1 = vertices(faces(:,2),1:3) - vertices(faces(:,1),1:3);
    v2 = vertices(faces(:,3),1:3) - vertices(faces(:,1),1:3);
    
    % compute normals using cross product (nodes have same size)
	normals = cross(v1, v2, 2);

else
    % initialize empty array
    normals = zeros(length(faces), 3);
    
    for i = 1:length(faces)
        face = faces{i};
        % compute vector of first edges
        v1 = vertices(face(2),1:3) - vertices(face(1),1:3);
        v2 = vertices(face(3),1:3) - vertices(face(1),1:3);

        % compute normals using cross product
        normals(i, :) = cross(v1, v2, 2);
    end
end

normals = normalizeVector3d(normals);
