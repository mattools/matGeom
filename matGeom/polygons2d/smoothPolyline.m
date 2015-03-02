function res = smoothPolyline(poly, M)
%SMOOTHPOLYLINE Smooth a polyline using local averaging
%
%   RES = smoothPolygon(POLY, M)
%   POLY contains the polyline vertices, and M is the size of smoothing
%   (given as the length of the convolution window).
%   Extremities of the polyline are smoothed with reduced window (last and
%   first vertices are kept identical, second and penultimate vertices are
%   smoothed with 3 values, etc.).
%
%   Example
%     img = imread('circles.png');
%     img = imfill(img, 'holes');
%     contours = bwboundaries(img');
%     poly = contours{1}(201:500,:);
%     figure; drawPolyline(poly, 'b'); hold on;
%     poly2 = smoothPolyline(poly, 21);
%     drawPolygon(poly2, 'm');
%
%   See also
%     polygons2d, smoothPolygon, simplifyPolyline, resamplePolyline
 
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2015-02-17,    using Matlab 8.4.0.150421 (R2014b)
% Copyright 2015 INRA - Cepia Software Platform.

% compute the number of elements before and after
M1 = floor((M - 1) / 2);
M2 = ceil((M - 1) / 2);

% create convolution vector
v2 = ones(M, 1) / M;

% apply filtering on central part of the polyline
res(:,1) = conv(poly(:,1), v2, 'same');
res(:,2) = conv(poly(:,2), v2, 'same');

% need to recompute the extremities
for i = 1:M1
    i2 = 2 * i - 1;
    res(i, 1) = mean(poly(1:i2, 1));
    res(i, 2) = mean(poly(1:i2, 2));
end
for i = 1:M2
    i2 = 2 * i - 1;
    res(end - i + 1, 1) = mean(poly(end-i2+1:end, 1));
    res(end - i + 1, 2) = mean(poly(end-i2+1:end, 2));
end
