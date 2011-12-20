function [points pos faceInds] = intersectLineMesh3d(line, vertices, faces)
%INTERSECTLINEMESH3D Intersection points of a 3D line with a mesh
%
%   output = intersectLineMesh3d(input)
%
%   Example
%   intersectLineMesh3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-12-20,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% nf = size(faces, 1);

% pts = NaN * ones(nf, 3);

% % code using a loop:
% for i = 1:nf
%     face = faces(i,:);
%     tri = [vertices(face(1), :) vertices(face(2), :) vertices(face(3), :)];
%     
%     pts(i,:) = intersectLineTriangle3d(line, tri);
% end
% 
% pts = unique(pts(isfinite(pts(:,1)), :), 'rows');

tol = 1e-12;

% find triangle edge vectors
t0  = vertices(faces(:,1), :);
u   = vertices(faces(:,2), :) - t0;
v   = vertices(faces(:,3), :) - t0;

% triangle normal
n   = normalizeVector3d(vectorCross3d(u, v));

% direction vector of line
dir = line(4:6);

% vector between triangle origin and line origin
w0 = bsxfun(@minus, line(1:3), t0);

a = -dot(n, w0, 2);
b = dot(n, repmat(dir, size(n, 1), 1), 2);

valid = abs(b) > tol & vectorNorm3d(n) > tol;

% compute intersection point of line with supporting plane
% If pos < 0: point before ray
% IF pos > |dir|: point after edge
pos = a ./ b;

% coordinates of intersection point
points = bsxfun(@plus, line(1:3), bsxfun(@times, pos, dir));


%% test if intersection point is inside triangle

% normalize direction vectors of triangle edges
uu  = dot(u, u, 2);
uv  = dot(u, v, 2);
vv  = dot(v, v, 2);

% coordinates of vector v in triangle basis
w   = points - t0;
wu  = dot(w, u, 2);
wv  = dot(w, v, 2);

% normalization constant
D = uv.^2 - uu .* vv;

% test first coordinate
s = (uv .* wv - vv .* wu) ./ D;
ind1 = s < 0.0 | s > 1.0;
points(ind1, :) = NaN;
pos(ind1) = NaN;

% test second coordinate, and third triangle edge
t = (uv .* wu - uu .* wv) ./ D;
ind2 = t < 0.0 | (s + t) > 1.0;
points(ind2, :) = NaN;
pos(ind2) = NaN;

% keep only interesting points
inds = ~ind1 & ~ind2 & valid;
points = points(inds, :);

pos = pos(inds);
faceInds = find(inds);

