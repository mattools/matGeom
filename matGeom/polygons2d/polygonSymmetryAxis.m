function axis = polygonSymmetryAxis(poly)
%POLYGONSYMMETRYAXIS Try to identify symmetry axis of polygon
%
%   LINE = polygonSymmetryAxis(POLY)
%   Returns a line that minimize difference between the polygon POLY and
%   its reflection with the line.
%   The difference metric between the two polygons is the sum of distances
%   between each vertex of original polygon to the reflected polygon.
%
%   Example
%     % identify symmetry axis of an ellipse
%     elli = [50 50 40 20 30];
%     poly = ellipseToPolygon(elli, 100);
%     line = polygonSymmetryAxis(poly);
%     figure; hold on;
%     drawEllipse(elli);
%     axis equal; axis ([0 100 0 100]);
%     drawLine(line);
%
%   See also
%   transforms2d, transformPoint, distancePointPolygon
 
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2015-04-28,    using Matlab 8.4.0.150421 (R2014b)
% Copyright 2015 INRA - Cepia Software Platform.

% start by centering the polygon
center = polygonCentroid(poly);
poly = bsxfun(@minus, poly, center);

% first performs a rough search with 8 angles
initAngles = linspace(0, pi, 9);
initAngles(end) = [];
initRes = zeros(8, 1);
for i = 1:8
    line = createLine([0 0 cos(initAngles(i)) sin(initAngles(i))]);
    rotMat = createLineReflection(line);
    polyRot = transformPoint(poly, rotMat);
    initRes(i) = sum(distancePointPolygon(poly, polyRot).^2);
end

% keep the angle that gives best result
[dummy, indMin] = min(initRes); %#ok<ASGLU>
initAngle = initAngles(indMin);

% Compute angle that best fit between polygon and its symmetric along line
thetaMin = fminbnd(...
    @(theta) sum(distancePointPolygon(transformPoint(poly, createLineReflection([0 0 cos(theta) sin(theta)])), poly).^2), ...
    initAngle-pi/4, initAngle+pi/4);

% format as a line
axis = [center cos(thetaMin) sin(thetaMin)];
