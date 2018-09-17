function elli = polygonInertiaEllipse(poly)
%POLYGONINERTIAELLIPSE Compute ellipse with same inertia moments as polygon
%
%   ELLI = polygonInertiaEllipse(POLY)
%
%   Example
%     % convert an ellipse to polygon, and check that inertia ellipse is
%     % close to original ellipse
%     elli = [50 50 50 30 20];
%     poly = ellipseToPolygon(elli, 1000);
%     polygonInertiaEllipse(poly)
%     ans =
%        50.0000   50.0000   49.9998   29.9999   20.0000
%
%     % compute inertia ellipse of more complex figure
%     img = imread('circles.png');
%     img = imfill(img, 'holes');
%     figure; imshow(img); hold on;
%     B = bwboundaries(img);
%     poly = B{1}(:,[2 1]);
%     drawPolygon(poly, 'r');
%     elli = polygonInertiaEllipse(poly);
%     drawEllipse(elli, 'color', 'g', 'linewidth', 2);
%
%
%   See also
%     polygons2d, polygonSecondAreaMoments, polygonCentroid, inertiaEllipse
%     ellipseToPolygon
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2017-09-08,    using Matlab 9.1.0.441655 (R2016b)
% Copyright 2017 INRA - Cepia Software Platform.

% first re-center the polygon
centroid = polygonCentroid(poly);
poly = bsxfun(@minus, poly, centroid);

% compute non-normalized inertia moments
[Ix, Iy, Ixy] = polygonSecondAreaMoments(poly);

% noralaize with polygon area
area = polygonArea(poly);
Ix = Ix / area;
Iy = Iy / area;
Ixy = Ixy / area;

% compute ellipse semi-axis lengths
common = sqrt( (Ix - Iy)^2 + 4 * Ixy^2);
ra = sqrt(2) * sqrt(Ix + Iy + common);
rb = sqrt(2) * sqrt(Ix + Iy - common);

% compute ellipse angle and convert into degrees
% (different formula from the inertiaEllipse function, as the definition
% for Ix and Iy do not refer to same axes)
theta = atan2(2 * Ixy, Iy - Ix) / 2;
theta = theta * 180 / pi;

% compute centroid and concatenate results into ellipse format
elli = [centroid ra rb theta];
