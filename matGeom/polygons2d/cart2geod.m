function point = cart2geod(src, curve)
%CART2GEOD Convert cartesian coordinates to geodesic coord.
%
%   PT2 = cart2geod(PT1, CURVE)
%   PT1 is the point to transform, in Cartesian coordinates (same system
%   used for the curve).
%   CURVE is a N-by-2 array which represents coordinates of curve vertices.
%
%   The function first compute the projection of PT1 on the curve. Then,
%   the first geodesic coordinate is the length of the curve to the
%   projected point, and the second geodesic coordinate is the 
%   distance between PT1 and it projection.
%
%
%   TODO : add processing of points not projected on the curve.
%   -> use the closest end 
%
%   See also 
%   polylines2d, geod2cart, curveLength
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2004-04-08
% Copyright 2004-2023 INRA - Cepia Software Platform

% parametrization approximation
t = parametrize(curve);

% compute distance between each src point and the curve
[dist, ind] = minDistancePoints(src, curve);

% convert to 'geodesic' coordinate
point = [t(ind) dist];

% Old version:
% for i=1:size(pt1, 1)
%     [dist, ind] = minDistance(src(i,:), curve);
%     point(i,:) = [t(ind) dist];
% end
