function areas = meshFaceAreas(vertices, faces)
%MESHFACEAREAS Surface area of each face of a mesh.
%
%   areas = meshFaceAreas(vertices, faces)
%
%   Example
%     [v, f] = createOctahedron;
%     meshFaceAreas(v, f)'
%     ans =
%         1.7321  1.7321  1.7321  1.7321  1.7321  1.7321  1.7321  1.7321
%
%   See also
%     meshes3d, meshSurfaceArea, meshFaceCentroids
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-06-21,    using Matlab 9.4.0.813654 (R2018a)
% Copyright 2018 INRA - Cepia Software Platform.


if isnumeric(faces)
    % trimesh or quadmesh
    nf = size(faces, 1);
    areas = zeros(nf, 1);
    if size(vertices, 2) == 2
        % planar case
        for f = 1:nf
            areas(f,:) = polygonArea(vertices(faces(f,:), :));
        end
    else
        % 3D case
        if size(faces, 2) == 3
            % For triangular meshes, uses accelerated method
            v1 = vertices(faces(:,1), :);
            v12 = vertices(faces(:,2), :) - v1;
            v13 = vertices(faces(:,3), :) - v1;
            areas = vectorNorm3d(crossProduct3d(v12, v13))/2;
            
        else
            % for quad (or larger) meshes, use slower but more precise method
            for f = 1:nf
                areas(f) = polygonArea3d(vertices(faces(f,:), :));
            end
        end
    end
    
else
    % mesh with faces stored as cell array
    nf = length(faces);
    areas = zeros(nf, 1);
    if size(vertices, 2) == 2
        % planar case
        for f = 1:nf
            areas(f) = polygonArea(vertices(faces{f}, :));
        end
    else
        % 3D case
        for f = 1:nf
            areas(f) = polygonArea3d(vertices(faces{f}, :));
        end
    end
end

