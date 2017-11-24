function centroids = meshFaceCentroids(nodes, faces)
%MESHFACECENTROIDS Compute centroids of faces in a mesh
%
%   CENTROIDS = meshFaceCentroids(VERTICES, FACES)
%   VERTICES is a set of 3D points  (as a N-by-3 array), and FACES is
%   either a N-by-3 index array or a cell array of indices. The function
%   computes the centroid of each face, and returns a Nf-by-3 array
%   containing their coordinates.
%
%   Example
%     [v e f] = createIcosahedron;
%     normals1 = faceNormal(v, f);
%     centros1 = meshFaceCentroids(v, f);
%     figure; drawMesh(v, f); 
%     hold on; axis equal; view(3);
%     drawVector3d(centros1, normals1);
%
%
%   See also:
%   meshes3d, drawMesh, meshFaceNormals, convhull, convhulln
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2006-07-05
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

% HISTORY
% 2007-09-18 fix: worked only for 2D case, now works also for 3D
% 2011-11-24 rename from faceCentroids to meshFaceCentroids

if isnumeric(faces)
    % trimesh or quadmesh
    nf = size(faces, 1);
    centroids = zeros(nf, size(nodes, 2));
    if size(nodes, 2) == 2
        % planar case
        for f = 1:nf
            centroids(f,:) = polygonCentroid(nodes(faces(f,:), :));
        end
    else
        % 3D case
        for f = 1:nf
            centroids(f,:) = polygonCentroid3d(nodes(faces(f,:), :));
        end
    end        
else
    % mesh with faces stored as cell array
    nf = length(faces);
    centroids = zeros(nf, size(nodes, 2));
    if size(nodes, 2) == 2
        % planar case
        for f = 1:nf
            centroids(f,:) = polygonCentroid(nodes(faces{f}, :));
        end
    else
        % 3D case
        for f = 1:nf
            centroids(f,:) = polygonCentroid3d(nodes(faces{f}, :));
        end
    end
end

