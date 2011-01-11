function [nodes faces] = steinerPolytope(points)
%STEINERPOLYTOPE  Create a steiner polytope from a set of vectors
%
%   [NODES FACES] = steinerPolygon(POINTS)
%   create the steiner polytope defined by points POINTS.
%
%   Example
%   [n f] = steinerPolytope([1 0 0;0 1 0;0 0 1;1 1 1]);
%   drawMesh(n, f);
%
%   See also
%   meshes3d, drawMesh
%
% ------
% Author: David Legland
% e-mail: david.legland@jouy.inra.fr
% Created: 2006-04-28
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

% create candidate points
nodes = zeros(1, size(points, 2));
for i=1:length(points)
    nodes = [nodes; nodes+repmat(points(i,:), [size(nodes, 1) 1])];
end

% compute convex hull
K = convhulln(nodes);

% keep only relevant points, and update faces indices
ind = unique(K);
for i=1:length(ind)
    K(K==ind(i))=i;
end 

% return results
nodes = nodes(ind, :);
faces = K;
    