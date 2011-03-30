function points = polyhedronSlice(nodes, faces, plane)
%POLYHEDRONSLICE Intersect a convex polyhedron with a plane.
%
%   SLICE = polyhedronSlice(NODES, FACES, PLANE)
%   NODES: a Nx3 array
%   FACES: either a cell array or a Nf*3 or Nf*4 array
%   PLANE: a plane representation [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2].
%   return the intersection polygon of the polyhedra with the plane, in the
%   form of a set of ordered points.
%
%   Works only for convex polyhedra.
%
%   Example
%   polyhedronSlice
%
%   See also
%   polyhedra, clipConvexPolyhedronHP
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2007-09-18,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% if faces is a numeric array, convert it to cell array
if isnumeric(faces)
    faces2 = cell(size(faces, 1), 1);
    for f=1:length(faces2)
        faces2{f} = faces(f,:);
    end
    faces = faces2;
else
    % ensure we have face with horizontal vectors...
    for f=1:length(faces)
        face = faces{f};
        faces{f} = face(:)';
    end
end

% compute edges of the polyhedron
inds = zeros(0, 2);
for f=1:length(faces)
    face = faces{f}';
    inds = [inds ; sort([face face([2:end 1])], 2)];
end
inds = unique(inds, 'rows');
edges = [nodes(inds(:,1), :) nodes(inds(:,2), :)];

% intersection of edges with plane
points = intersectEdgePlane(edges, plane);
points = points(sum(isfinite(points), 2)==3, :);

if ~isempty(points)
    points = angleSort3d(points);
end
