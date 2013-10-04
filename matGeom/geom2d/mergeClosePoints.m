function points = mergeClosePoints(points, varargin)
%MERGECLOSEPOINTS Merge points that are closer than a given distance
%
%   PTS2 = mergeClosePoints(PTS, DIST)
%   Remove points in the array PTS such that no points closer than the
%   distance DIST remain in the array.
%
%   PTS2 = mergeClosePoints(PTS)
%   If the distance is not specified, the default value 1e-14 is used.
%
%
%   Example
%     pts = rand(200, 2);
%     pts2 = mergeClosePoints(pts, .1);
%     figure; drawPoint(pts, '.');
%     hold on; drawPoint(pts2, 'mo');
%
%   See also
%     points2d, removeMultipleVertices
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-10-04,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.

% default values
minDist = 1e-14;
if ~isempty(varargin)
    minDist = varargin{1};
end

i = 1;
while i < size(points, 1)
    dist = distancePoints(points(i,:), points);
    inds = dist < minDist;
    inds(i) = 0;
    
    points(inds, :) = [];
    
    % switch to next point
    i = i + 1;
end
