function normals = faceNormal(nodes, faces)
%FACENORMAL Compute normal vector of faces in a 3D mesh
%
%   NORMALS = faceNormal(VERTICES, FACES)
%   VERTICES is a set of 3D points (as a N-by-3 array), and FACES is either
%   a N-by-3 index array or a cell array of indices. The function computes
%   the normal vector of each face.
%   The orientation of the normal is defined by the sign of cross product
%   between vectors joining vertices 1 to 2 and 1 to 3.
%
%
%   Example
%     [v e f] = createIcosahedron;
%     normals1 = faceNormal(v, f);
%     centros1 = faceCentroids(v, f);
%     figure; drawMesh(v, f); 
%     hold on; axis equal; view(3);
%     drawVector3d(centros1, normals1);
%
%     pts = rand(50, 3);
%     hull = minConvexHull(pts);
%     normals2 = faceNormal(pts, hull);
%
%   See also
%   meshes3d, drawMesh, convhull, convhulln, drawVector3d

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2006-07-05
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

if isnumeric(faces)
    % compute vector of first edges
	v1 = nodes(faces(:,2),1:3) - nodes(faces(:,1),1:3);
    v2 = nodes(faces(:,3),1:3) - nodes(faces(:,1),1:3);
    
%     % normalize vectors
%     v1 = normalizeVector3d(v1);
%     v2 = normalizeVector3d(v2);
   
    % compute normals using cross product (nodes have same size)
	normals = normalizeVector3d(cross(v1, v2, 2));

else
    % initialize empty array
    normals = zeros(length(faces), 3);
    
    for i = 1:length(faces)
        face = faces{i};
        % compute vector of first edges
        v1 = nodes(face(2),1:3) - nodes(face(1),1:3);
        v2 = nodes(face(3),1:3) - nodes(face(1),1:3);
        
%         % normalize vectors
%         v1 = normalizeVector3d(v1);
%         v2 = normalizeVector3d(v2);
        
        % compute normals using cross product
        normals(i, :) = normalizeVector3d(cross(v1, v2, 2));
    end
end

