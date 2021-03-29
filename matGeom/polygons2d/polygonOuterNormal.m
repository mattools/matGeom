function vect = polygonOuterNormal(poly, iVertex)
% Outer normal vector for a given vertex(ices).
%
%   NV = polygonOuterNormal(POLY, VIND)
%   Where POLY is a polygon and VIND is the index of a vertex, returns the
%   outer normal vector of the specified vertex.
%   The normal is computed by averaging the tangent vectors of the two
%   neighbor edges, i.e. by computing a finite difference of the neighbor
%   vertices.
%   
%   NV = polygonOuterNormal(POLY)
%   Returns an array with as many vectors as the number of vertices of the
%   input polygon, containing the outer normal of each vertex.
%
%
%   Example
%     % compute outer normals to an ellipse
%     elli = [50 50 40 20 30];
%     poly = ellipseToPolygon(elli, 200);
%     figure; hold on;
%     drawPolygon(poly, 'b'); axis equal; axis([0 100 10 90]);
%     inds = 1:10:200; pts = poly(inds, :); drawPoint(pts, 'bo')
%     vect = polygonOuterNormal(poly, inds);
%     drawVector(pts, vect*10, 'b');
%
%   See also
%     polygons2d, polygonPoint, polygonNormalAngle
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2017-11-23,    using Matlab 8.6.0.267246 (R2015b)
% Copyright 2017 INRA - Cepia Software Platform.

% number of vertices
nv = size(poly, 1);

% if indices not specified, compute for all vertices
if nargin == 1
    iVertex = 1:nv;
end

% allocate memory
vect = zeros(length(iVertex), 2);

% compute normal vector of each result vertex
for i = 1:length(iVertex)
    iNext = mod(iVertex(i), nv) + 1;
    iPrev = mod(iVertex(i)-2, nv) + 1;
    tangent = (poly(iNext,:) - poly(iPrev,:)) / 2;
    vect(i,:) = [tangent(2) -tangent(1)];
end
