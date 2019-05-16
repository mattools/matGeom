function res = parallelPlane(plane, point)
%PARALLELPLANE Parallel to a plane through a point or at a given distance.
%
%   PL2 = parallelPlane(PL, PT)
%   Constructs the plane parallel to plane PL and containing the point PT.
%
%   PL2 = parallelPlane(PL, D)
%   Constructs the plane parallel to plane PL, and located at the given
%   signed distance D.
%
%   Example
%     % Create a plane normal to the 3D vector DIR
%     dir = [3 4 5];
%     plane = createPlane([3 4 5], dir);
%     % Create plane at a specific distance 
%     plane2 = parallelPlane(plane, 5);
%     % Create a line perpendicular to both planes
%     line = [2 4 1 3 4 5];
%     pi1 = intersectLinePlane(line, plane);
%     pi2 = intersectLinePlane(line, plane2);
%     % check the distance between intersection points
%     distancePoints3d(pi1, pi2)
%     ans = 
%         5
%
%   See also
%   geom3d, parallelLine3d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-08-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

if size(point, 2) == 1
    % use a distance. Compute position of point located at distance DIST on
    % the line normal to the plane.
    normal = normalizeVector3d(planeNormal(plane));
    point = plane(:, 1:3) + bsxfun(@times, point, normal);
end

% change origin, and keep direction vectors
res = [point plane(:, 4:9)];
