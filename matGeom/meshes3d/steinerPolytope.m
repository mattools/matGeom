function [vertices faces] = steinerPolytope(vectors)
%STEINERPOLYTOPE Create a steiner polytope from a set of vectors
%
%   [VERTICES FACES] = steinerPolygon(VECTORS)
%   Creates the Steiner polytope defined by the set of vectors VECTORS.
%
%   Example
%     % Creates and display a planar Steiner polytope (ie, a polygon)
%     [v f] = steinerPolytope([1 0;0 1;1 1]);
%     fillPolygon(v);
%
%     % Creates and display a 3D Steiner polytope 
%     [v f] = steinerPolytope([1 0 0;0 1 0;0 0 1;1 1 1]);
%     drawMesh(v, f);
%     view(3); axis vis3d
%
%   See also
%   meshes3d, drawMesh, steinerPolygon, mergeCoplanarFaces
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2006-04-28
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

% History
% 2013-02-22 merge coplanar faces, add management of 2D case, update doc


% compute vectors dimension
nd = size(vectors, 2);

% create candidate vertices
vertices = zeros(1, size(vectors, 2));
for i = 1:length(vectors)
    nv = size(vertices, 1);
    vertices = [vertices; vertices+repmat(vectors(i,:), [nv 1])]; %#ok<AGROW>
end

if nd == 2
    % for planar case, use specific function convhull
    K = convhull(vertices(:,1), vertices(:,2));
    vertices = vertices(K, :);
    faces = 1:length(K);
    
else 
    % Process the general case (tested only for nd==3)
    
    % compute convex hull
    K = convhulln(vertices);
    
    % keep only relevant points, and update faces indices
    ind = unique(K);
    for i = 1:length(ind)
        K(K==ind(i)) = i;
    end
    
    % return results
    vertices = vertices(ind, :);
    faces = K;
    
    % in case of 3D meshes, merge coplanar faces
    if nd == 3
        faces = mergeCoplanarFaces(vertices, faces);
    end
end
