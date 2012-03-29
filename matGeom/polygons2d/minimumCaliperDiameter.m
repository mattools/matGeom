function [min_width min_angle] = minimumCaliperDiameter(points)
%MINIMUMCALIPERDIAMETER Minimum caliper diameter of a set of points
%
%   WIDTH = minimumCaliperDiameter(POINTS)
%   Computes the minimum width of a set of points. As polygons and
%   polylines are represented as point lists, this function works also for
%   polygons and polylines.
%
%   [WIDTH THETA] = minimumCaliperDiameter(POINTS)
%   Also returns the direction of minimum width. The direction corresponds
%   to the horizontal angle of the edge that minimizes the width. THETA is
%   given in radians, between 0 and PI.
%
%
%   Example
%   % Compute minimal caliper diameter, and check coords of rotated points
%   % have expected extent
%     points = randn(30, 2);
%     [width theta] = minimumCaliperDiameter(points);
%     points2 = transformPoint(points, createRotation(-theta));
%     diff = max(points2) - min(points2);
%     abs(width - diff(2)) < 1e-10
%     ans =
%         1
%
%   References
%   Algorithms use rotating caliper. Implementation was based on that of
%   Wikipedia:
%   http://en.wikipedia.org/wiki/Rotating_calipers
%
%   See also
%   polygons2d, convexHull, orientedBox
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-04-08,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% first, compute convex hull of the polygon
inds = convhull(points(:,1), points(:,2));
hull = points(inds, :);

% if first and last points are the same, remove the last one
if inds(1) == inds(end)
    hull = hull(1:end-1, :);
end

% number of hull vertices
nV = size(hull, 1);

% default values
rotated_angle = 0;
min_width = inf;
min_angle = 0;

% avoid degenerated cases
if nV < 3
    return;
end

[tmp p_a] = min(hull(:, 2)); %#ok<ASGLU>
[tmp p_b] = max(hull(:, 2)); %#ok<ASGLU>

caliper_a = [ 1 0];    % Caliper A points along the positive x-axis
caliper_b = [-1 0];    % Caliper B points along the negative x-axis

while rotated_angle < pi
    % compute the direction vectors corresponding to each edge
    ind_a2 = mod(p_a, nV) + 1;
    vector_a = hull(ind_a2, :) - hull(p_a, :);
    
    ind_b2 = mod(p_b, nV) + 1;
    vector_b = hull(ind_b2, :) - hull(p_b, :);
    
    % Determine the angle between each caliper and the next adjacent edge
    % in the polygon 
    angle_a = vectorAngle(caliper_a, vector_a);
    angle_b = vectorAngle(caliper_b, vector_b);
    
    % Determine the smallest of these angles
    minAngle = min(angle_a, angle_b);
    
    % Rotate the calipers by the smallest angle
    caliper_a = rotateVector(caliper_a, minAngle);
    caliper_b = rotateVector(caliper_b, minAngle);
    
    rotated_angle = rotated_angle + minAngle;
    
    % compute current width, and update opposite vertex
    if angle_a < angle_b
        line = createLine(hull(p_a, :), hull(ind_a2, :));
        width = distancePointLine(hull(p_b, :), line);
        p_a = mod(p_a, nV) + 1;
    
    else
        line = createLine(hull(p_b, :), hull(ind_b2, :));
        width = distancePointLine(hull(p_a, :), line);
        p_b = mod(p_b, nV) + 1;

    end
    
    % update minimum width and corresponding angle if needed
    if width < min_width
        min_width = width;
        min_angle = rotated_angle;
    end

end

