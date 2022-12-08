function [points, pos, faceInds, lineInds] = intersectLineMesh3d(line, vertices, varargin)
%INTERSECTLINEMESH3D Intersection points of a 3D line with a mesh.
%
%   INTERS = intersectLineMesh3d(LINE, VERTICES, FACES)
%   Compute the intersection points between a 3D line and a 3D mesh defined
%   by vertices and faces. The mesh data is provided as a pair of arrays,
%   with VERTICES being a NV-by-3 array of vertex coordinates, and FACES
%   being a NF-by-3 or NF-by-4 array of face vertex indices.
%   The LINE data correspond to a 1-by-6 row vector concatenating the line
%   origin and direction. LINE can also be a NL-by-6 array representing a
%   collection of lines with various origins and directions.
%
%   INTERS = intersectLineMesh3d(LINE, MESH)
%   Provides the mesh data as a struct with the fields 'vertices' and
%   'faces'.
%
%   [INTERS, POS, IFACES] = intersectLineMesh3d(...)
%   Also returns the position of each intersection point on the input line,
%   and the index of the intersected faces.
%   If POS > 0, the point is also on the ray corresponding to the line. 
%   
%   [INTERS, POS, IFACES, ILINES] = intersectLineMesh3d(...)
%   Also returns the index of the line each intersection point belong to.
%
%   Example
%     [V, F] = createCube;
%     line = [.2 .3 .4 1 0 0];
%     pts = intersectLineMesh3d(line, V, F)
%     pts =
%         1.0000    0.3000    0.4000
%              0    0.3000    0.4000
%
%   See also 
%   meshes3d, triangulateFaces, intersectLineTriangle3d
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2011-12-20, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2022 INRA - Cepia Software Platform

% tolerance for detecting if a point is on line or within edge bounds
tol = 1e-12;

% parsing
if ~isempty(varargin)
    if isscalar(varargin{1})
        tol = varargin{1};
        [vertices, faces] = parseMeshData(vertices);
    else
        faces = varargin{1};
        varargin(1) = [];
        if ~isempty(varargin)
            tol = varargin{1};
        end
    end
else
    [vertices, faces] = parseMeshData(vertices);
end

% ensure the mesh has triangular faces
tri2Face = [];
if iscell(faces) || size(faces, 2) ~= 3
    [faces, tri2Face] = triangulateFaces(faces);
end

% find triangle edge vectors
t0  = vertices(faces(:,1), :);
u   = vertices(faces(:,2), :) - t0;
v   = vertices(faces(:,3), :) - t0;

% triangle normal
n   = crossProduct3d(u, v);

% direction vectors of lines and origins of lines
dv = permute(line(:,4:6), [3 2 1]);
d0 = permute(line(:,1:3), [3 2 1]);

% vector between triangle origin and line origin
w0 = d0 - t0;

a = -sum(n .* w0, 2); % negative dot product
b = sum(n .* dv, 2);  % dot product

valid = abs(b) > tol & vectorNorm3d(n) > tol;

% compute intersection point of line with supporting plane
% If pos < 0: point before ray
% IF pos > |dir|: point after edge
pos = a ./ b;

% coordinates of intersection point
points = d0 + (pos .* dv);


%% test if intersection point is inside triangle

% normalize direction vectors of triangle edges
uu  = dot(u, u, 2);
uv  = dot(u, v, 2);
vv  = dot(v, v, 2);

% coordinates of vector v in triangle basis
w   = points - t0;
wu  = sum(w .* u, 2);
wv  = sum(w .* v, 2);

% normalization constant
D = uv.^2 - uu .* vv;

% test first coordinate
s = (uv .* wv - vv .* wu) ./ D;
ind1 = s < -tol | s > (1.0 + tol);

% test second coordinate, and third triangle edge
t = (uv .* wu - uu .* wv) ./ D;
ind2 = t < -tol | (s + t) > (1.0 + tol);

% keep only interesting points
inds = ~ind1 & ~ind2 & valid;
[faceInds, lineInds] = find(permute(inds, [1 3 2]));

% Bit of an indexing trick to get points in appropriate order
points = points(sub2ind(size(points), ...
    faceInds+[0 0 0], faceInds*0+(1:3), lineInds+[0 0 0]) );

if nargout > 1
    pos = pos(inds);
    
    % convert to face indices of original mesh
    if ~isempty(tri2Face)
        faceInds = tri2Face(faceInds);
    end
end
