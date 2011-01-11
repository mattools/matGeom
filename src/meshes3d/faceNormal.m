function normals = faceNormal(nodes, faces)
%FACENORMAL Compute normal vector of faces in a 3D mesh
%
%   NORMALS = faceNormal(VERTICES, FACES)
%   VERTICES is a set of 3D points  (as a Nx3 array), and FACES is either a
%   [Nx3] indices array or a cell array of indices. The function computes
%   the normal of each face.
%   The orientation of the normal is undefined.
%
%
%   Example
%   [n e f] = createCube;
%   normals1 = faceNormal(n, f);
%
%   pts = rand(50, 3);
%   hull = minConvexHull(pts);
%   normals2 = faceNormal(pts, hull);
%
%   See also
%   meshes3d, drawMesh, convhull, convhulln
%
%
% ------
% Author: David Legland
% e-mail: david.legland@jouy.inra.fr
% Created: 2006-07-05
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

if isnumeric(faces)
    % compute vector of first edge
	v1 = nodes(faces(:,2),1:3) - nodes(faces(:,1),1:3);
    v2 = nodes(faces(:,3),1:3) - nodes(faces(:,1),1:3);
    
    % normalize vectors
    v1 = normalizeVector3d(v1);
    v2 = normalizeVector3d(v2);
   
    % compute normals using cross product
	normals = cross(v1, v2, 2);

else
    normals = zeros(length(faces), 3);
    
    for i=1:length(faces)
        face = faces{i};
        % compute vector of first edges
        v1 = nodes(face(2),1:3) - nodes(face(1),1:3);
        v2 = nodes(face(3),1:3) - nodes(face(1),1:3);
        
        % normalize vectors
        v1 = normalizeVector3d(v1);
        v2 = normalizeVector3d(v2);
        
        % compute normals using cross product
        normals(i, :) = cross(v1, v2, 2);
    end
end

