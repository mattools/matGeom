function [index, minDist] = findClosestPoint(coord, points)
%FINDCLOSESTPOINT Find index of closest point in an array.
%
%   INDEX = findClosestPoint(POINT, POINTARRAY)
%
%   [INDEX, MINDIST] = findClosestPoint(POINT, POINTARRAY)
%   Also returns the distance between POINT and closest point in
%   POINTARRAY.
%
%   Example
%     pts = rand(10, 2);
%     findClosestPoint(pts(4, :), pts)
%     ans =
%         4
%
%   See also
%    points2d, minDistancePoints, distancePoints
%
 
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2015-02-24,    using Matlab 8.4.0.150421 (R2014b)
% Copyright 2015 INRA - Cepia Software Platform.
% number of points

% number of point in first input to process
np = size(coord, 1);

% allocate memory for result
index = zeros(np, 1);
minDist = zeros(np, 1);

for i = 1:np
    % compute squared distance between current point and all point in array
    dist = sum(bsxfun(@minus, coord(i,:), points) .^ 2, 2);
    
    % keep index of closest point
    [minDist(i), index(i)] = min(dist);
end
