function obox = orientedBox(points)
%ORIENTEDBOX Minimum-width oriented bounding box of a set of points
%
%   OBOX = orientedBox(PTS)
%   Computes the oriented bounding box of a set of points. Oriented box is
%   defined by a center, two dimensions (the length and the width), and the
%   orientation of the length axis. Orientation is counted in degrees, 
%   counter-clockwise.
%
%   Example
%     % Draw oriented bounding box of an ellipse
%     elli = [30 40 40 20 30];
%     pts = ellipseToPolygon(elli, 120);
%     obox = orientedBox(pts);
%     figure; hold on;
%     drawEllipse(elli);
%     drawOrientedBox(obox, 'm');
%
%   See also
%   drawOrientedBox, orientedBoxToPolygon
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-03-29,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.


%% initialisations

% first, compute convex hull of the polygon
inds = convhull(points(:,1), points(:,2));
hull = points(inds, :);

% if first and last points are the same, remove the last one
if inds(1) == inds(end)
    hull = hull(1:end-1, :);
end

% compute convex hull centroid, that corresponds to approximate
% location of rectangle center
center = mean(hull, 1);
hull = bsxfun(@minus, hull, center);

% number of hull vertices
nV = size(hull, 1);

% default values
rotatedAngle = 0;
minWidth = inf;
minAngle = 0;

% avoid degenerated cases
if nV < 3
    return;
end

% indices of vertices in extreme y directions
[tmp indA] = min(hull(:, 2)); %#ok<ASGLU>
[tmp indB] = max(hull(:, 2)); %#ok<ASGLU>

caliperA = [ 1 0];    % Caliper A points along the positive x-axis
caliperB = [-1 0];    % Caliper B points along the negative x-axis


%% Find the direction with minimum width (rotating caliper algorithm)

while rotatedAngle < pi
    % compute the direction vectors corresponding to each edge
    indA2 = mod(indA, nV) + 1;
    vectorA = hull(indA2, :) - hull(indA, :);
    
    indB2 = mod(indB, nV) + 1;
    vectorB = hull(indB2, :) - hull(indB, :);
    
    % Determine the angle between each caliper and the next adjacent edge
    % in the polygon 
    angleA = vectorAngle(caliperA, vectorA);
    angleB = vectorAngle(caliperB, vectorB);
    
    % Determine the smallest of these angles
    angleIncrement = min(angleA, angleB);
    
    % Rotate the calipers by the smallest angle
    caliperA = rotateVector(caliperA, angleIncrement);
    caliperB = rotateVector(caliperB, angleIncrement);
    
    rotatedAngle = rotatedAngle + angleIncrement;
    
    % compute current width, and update opposite vertex
    if angleA < angleB
        line = createLine(hull(indA, :), hull(indA2, :));
        width = distancePointLine(hull(indB, :), line);
        indA = mod(indA, nV) + 1;
    
    else
        line = createLine(hull(indB, :), hull(indB2, :));
        width = distancePointLine(hull(indA, :), line);
        indB = mod(indB, nV) + 1;

    end
    
    % update minimum width and corresponding angle if needed
    if width < minWidth
        minWidth = width;
        minAngle = rotatedAngle;
    end
end


%% Compute box dimensions

% orientation of the main axis
theta = rad2deg(minAngle);

% pre-compute trigonometric functions
cot = cos(minAngle);
sit = sin(minAngle);

% elongation in direction of rectangle length
x = hull(:,1);
y = hull(:,2);
x2  =   x * cot + y * sit;
y2  = - x * sit + y * cot;

% compute extension along main directions
xmin = min(x2);    xmax = max(x2);
ymin = min(y2);    ymax = max(y2);

% position of the center with respect to the centroid compute before
dl = (xmax + xmin)/2;
dw = (ymax + ymin)/2;

% change  coordinate from rectangle to user-space
dx  = dl * cot - dw * sit;
dy  = dl * sit + dw * cot;

% coordinates of oriented box center
center = center + [dx dy];

% size of the rectangle
rectLength  = xmax - xmin;
rectWidth   = ymax - ymin;

% concatenate rectangle data
obox = [center rectLength rectWidth theta];

