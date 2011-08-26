function centroids = faceCentroids(nodes, faces)
%FACECENTROIDS Compute centroids of a mesh faces
%
%   NORMALS = faceCentroids(VERTICES, FACES)
%   VERTICES is a set of 3D points  (as a Nx3 array), and FACES is either a
%   [Nx3] indices array or a cell array of indices. The function computes
%   the centroid of each face.
%
%   
%
%   See also:
%   meshes3d, drawMesh, faceNormal, convhull, convhulln
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2006-07-05
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

%   HISTORY
%   2007/09/18 fix: worked only for 2D case, now works also for 3D


if isnumeric(faces)
    nf = size(faces, 1);
    centroids = zeros(nf, size(nodes, 2));
    if size(nodes, 2)==2
        for f=1:nf
            centroids(f,:) = polygonCentroid(nodes(faces(f,:), :));
        end
    else
        for f=1:nf
            centroids(f,:) = polygonCentroid3d(nodes(faces(f,:), :));
        end
    end        
else
    nf = length(faces);
    centroids = zeros(nf, size(nodes, 2));
    if size(nodes, 2)==2
        for f=1:nf
            centroids(f,:) = polygonCentroid(nodes(faces{f}, :));
        end
    else
        for f=1:nf
            centroids(f,:) = polygonCentroid3d(nodes(faces{f}, :));
        end
    end
end

