function point = geod2cart(src, curve, normal)
%GEOD2CART Convert geodesic coordinates to cartesian coord.
%
%   PT2 = geod2cart(PT1, CURVE, NORMAL)
%   CURVE and NORMAL are both [N*2] array with the same length, and
%   represent positions of the curve, and normal to each point.
%   PT1 is the point to transform, in geodesic  coordinate (first coord is
%   distance from the curve start, and second coord is distance between
%   point and curve).
%
%   The function return the coordinate of PT1 in the same coordinate system
%   than for the curve.
%
%   See also 
%   polylines2d, cart2geod, curveLength

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2004-04-08
% Copyright 2004-2023 INRA - TPV URPOI - BIA IMASTE

t = parametrize(curve);
N = size(src, 1);
ind = zeros(N, 1);
for i = 1:N
    indices = find(t >= src(i,1));
    if ~isempty(indices)
        ind(i) = indices(1);
    else
        ind(i) = 1;
    end
end

theta = lineAngle([zeros(N,2) normal(ind,:)]);
d = src(:,2);
point = [curve(ind,1)+d.*cos(theta), curve(ind,2)+d.*sin(theta)];
