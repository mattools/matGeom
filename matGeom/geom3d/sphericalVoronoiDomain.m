function poly = sphericalVoronoiDomain(refPoint, neighbors)
%SPHERICALVORONOIDOMAIN Compute a spherical voronoi domain.
%
%   POLY = sphericalVoronoiDomain(GERM, NEIGHBORS)
%   GERM is a 1-by-3 row vector representing cartesian coordinates of a
%   point on the unit sphere (in X, Y Z order)
%   NEIGHBORS is a N-by-3 array representing cartesian coordinates of the
%   germ neighbors. It is expected that NEIGHBORS contains only neighbors
%   that effectively contribute to the voronoi domain.
%
%   Example
%   sphericalVoronoiDomain
%
%   See also
%   drawSphericalPolygon
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-11-17,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% reference sphere
sphere = [0 0 0 1];

% number of neigbors, and number of sides of the domain
nbSides = size(neighbors, 1);

% compute planes containing separating circles
planes = zeros(nbSides, 9);
for i = 1:nbSides
    planes(i,1:9) = normalizePlane(medianPlane(refPoint, neighbors(i,:)));
end

% allocate memory
lines       = zeros(nbSides, 6);
intersects  = zeros(2 * nbSides, 3);

% compute circle-circle intersections
for i = 1:nbSides
    ind2 = mod(i, nbSides) + 1;
    lines(i,1:6) = intersectPlanes(planes(i,:), planes(ind2,:));
    intersects(2*i-1:2*i,1:3) = intersectLineSphere(lines(i,:), sphere);
end

% keep only points in the same direction than refPoint
ind = dot(intersects, repmat(refPoint, [2 * nbSides 1]), 2) > 0;
poly = intersects(ind,:);
