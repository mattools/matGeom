function point = cart2geod(src, curve)
%CART2GEOD Convert cartesian coordinates to geodesic coord.
%
%   PT2 = cart2geod(PT1, CURVE)
%   PT1 is the point to transform, in Cartesian coordinates (same system
%   used for the curve).
%   CURVE is a [N*2] array which represents positions of the curve.
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
%   ---------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% created the 08/04/2004.
% Copyright 2010 INRA - Cepia Software Platform.

%   HISTORY
%   15/02/2007 replace minDistance by minDistancePoints


% parametrization approximation
t = parametrize(curve);

% compute distance between each src point and the curve
[dist ind] = minDistancePoints(src, curve);

% convert to 'geodesic' coordinate
point = [t(ind) dist];

% Old version:
% for i=1:size(pt1, 1)
%     [dist, ind] = minDistance(src(i,:), curve);
%     point(i,:) = [t(ind) dist];
% end
