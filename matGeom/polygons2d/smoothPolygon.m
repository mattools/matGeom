function res = smoothPolygon(poly, M)
%SMOOTHPOLYGON Smooth a polygon using local averaging
%
%   RES = smoothPolygon(POLY, M)
%   POLY contains the polygon vertices, and M is the size of smoothing
%   (given as the length of the convolution window).
%
%
%   Example
%     img = imread('circles.png');
%     img = imfill(img, 'holes');
%     contours = bwboundaries(img');
%     contour = contours{1};
%     imshow(img); hold on; drawPolygon(contour, 'b');
%     contourf = smoothPolygon(contour, 11);
%     drawPolygon(contourf, 'm');
%
%   See also
%     polygons2d, smoothPolyline, simplifyPolygon, resamplePolygon
 
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2015-02-17,    using Matlab 8.4.0.150421 (R2014b)
% Copyright 2015 INRA - Cepia Software Platform.

% compute the number of elements before and after
M1 = floor((M - 1) / 2);
M2 = ceil((M - 1) / 2);

% repeat beginning and end of contour
poly2 = [poly(end-M1+1:end, :) ; poly ; poly(1:M2,:)];

% create convolution vector
v2 = ones(M, 1) / M;

% apply contour filtering
res(:,1) = conv(poly2(:,1), v2, 'same');
res(:,2) = conv(poly2(:,2), v2, 'same');

% keep the interesting part
res = res(M1+1:end-M2, :);
