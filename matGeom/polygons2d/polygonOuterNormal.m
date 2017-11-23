function vect = polygonOuterNormal(poly, iVertex)
%POLYGONOUTERNORMAL  Outer normal vector for a given vertex(ices)
%
%   VECT = polygonOuterNormal(POLY, VIND)
%   Where POLY is a polygon and VIND is index of a vertex, returns the
%   outer normal as a vector.
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
%   polygons2d, polygonPoint, polygonNormalAngle
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2017-11-23,    using Matlab 8.6.0.267246 (R2015b)
% Copyright 2017 INRA - Cepia Software Platform.

n = size(poly, 1);
vect = zeros(length(iVertex), 2);

for i = 1:length(iVertex)
    iNext = mod(iVertex(i), n) + 1;
    iPrev = mod(iVertex(i)-2, n) + 1;
    tangent = (poly(iNext,:) - poly(iPrev,:)) / 2;
    vect(i,:) = [tangent(2) -tangent(1)];
end