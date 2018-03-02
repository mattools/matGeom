function curv = polygonCurvature(poly, M)
%POLYGONCURVATURE Estimate curvature on polygon vertices using polynomial fit
%
%   CURV = polygonCurvature(POLY, M)
%   Estimate the curvature for each vertex of a polygon, using polynomial
%   fit from the M verties located around current vertex. M is usually an
%   odd value, resulting in a symmetric neighborhood.
%
%   Polynomial fitting is of degree 2 by default.
%   
%
%   Example
%     img = imread('circles.png');
%     img = imfill(img, 'holes');
%     imgf = imfilter(double(img), fspecial('gaussian', 7, 2));
%     figure(1), imshow(imgf);
%     contours = imContours(imgf, .5); poly = contours{1};
%     poly2 = smoothPolygon(poly, 7);
%     hold on; drawPolygon(poly2);
%     curv = polygonCurvature(poly2, 11);
%     figure; plot(curv);
%     minima = bwlabel(imextendedmin(curv, .05));
%     centroids = imCentroid(minima);
%     inds = round(centroids(:,2));
%     figure(1); hold on; drawPoint(poly2(inds, :), 'g*')
%
%   See also
%     polygons2d
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-03-02,    using Matlab 9.3.0.713579 (R2017b)
% Copyright 2018 INRA - Cepia Software Platform.

% number of vertices of polygon
n = size(poly, 1);

% allocate memory for result
curv = zeros(n, 1);

% number of vertices before and after current vertex
s1 = floor((M - 1) / 2);
s2 = ceil((M - 1) / 2);

% parametrisation basis
% As we recenter the points, the constant factor is omitted
ti = (-s1:s2)';
X = [ti ti.^2];
    
% Iteration on vertex indices
for i = 1:n
    % coordinate of current vertex, for recentring neighbor vertices
    x0 = poly(i,1);
    y0 = poly(i,2);
    
    % indices of neighbors
    inds = i-s1:i+s2;
    inds = mod(inds-1, n) + 1;
    
    % Least square estimation using mrdivide
    xc = X \ (poly(inds,1) - x0);
    yc = X \ (poly(inds,2) - y0);
    
    % compute curvature
    curv(i) = 2 * (xc(1)*yc(2) - xc(2)*yc(1) ) / power(xc(1)^2 + yc(1)^2, 3/2);
end


