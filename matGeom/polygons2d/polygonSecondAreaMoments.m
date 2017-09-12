function [Ixx, Iyy, Ixy] = polygonSecondAreaMoments(poly)
%POLYGONSECONDAREAMOMENTS Compute second-order area moments of a polygon
%
%   [IXX, IYY, IXY] = polygonSecondAreaMoments(POLY)
%   Compute the second-order inertia moments of a polygon. The polygon is
%   specified by the N-by-2 list of vertex coordinates.
%
%   Example
%   polygonSecondAreaMoments
%
%   References
%   * http://paulbourke.net/geometry/polygonmesh/
%   * https://en.wikipedia.org/wiki/Second_moment_of_area
%
%   See also
%     polygons2d, polygonInertiaEllipse, polygonArea, polygonCentroid
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2017-09-08,    using Matlab 9.1.0.441655 (R2016b)
% Copyright 2017 INRA - Cepia Software Platform.

% get vertex coordinates, and recenter polygon
centroid = polygonCentroid(poly);
px = poly(:,1) - centroid(1);
py = poly(:,2) - centroid(2);

% vertex indices
N = length(px);
iNext = [2:N 1];

% compute twice signed area of each triangle
common = px .* py(iNext) - px(iNext) .* py;

% compute each term
Ixx = sum( (py.^2 + py .* py(iNext) + py(iNext).^2) .* common) / 12;
Iyy = sum( (px.^2 + px .* px(iNext) + px(iNext).^2) .* common) / 12;
Ixy = sum( ...
    (px .* py(iNext) + 2 * px .* py + 2 * px(iNext) .* py(iNext) ...
    + px(iNext) .* py ) .* common) / 24;
