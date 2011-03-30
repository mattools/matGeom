function varargout = polygonSelfIntersections(poly, varargin)
%POLYGONSELFINTERSECTIONS Find-self intersection points of a polygon
%
%   PTS = polygonSelfIntersections(POLY)
%   Return the position of self intersection points
%
%   [PTS POS1 POS2] = polygonSelfIntersections(POLY)
%   Also return the 2 positions of each intersection point (the position
%   when meeting point for first time, then position when meeting point
%   for the second time).
%
%   Example
%       % use a '8'-shaped polygon
%       poly = [10 0;0 0;0 10;20 10;20 20;10 20];
%       polygonSelfIntersections(poly)
%       ans = 
%           10 10
%
%   See also
%   polygons2d, polylineSelfIntersections
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-15,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

% ensure the last point equals the first one
if sum(abs(poly(end, :)-poly(1,:))<1e-14)~=2
    poly = [poly; poly(1,:)];
end

% compute intersections by calling algo for polylines
[points pos1 pos2] = polylineSelfIntersections(poly);

% If the first vertex was found as an intersection, it is removed
dist = distancePoints(points, poly(1,:));
[minDist ind] = min(dist); %#ok<ASGLU>
points(ind,:) = [];
pos1(ind)   = [];
pos2(ind)   = [];


%% Post-processing

% process output arguments
if nargout<=1
    varargout{1} = points;
elseif nargout==3
    varargout{1} = points;
    varargout{2} = pos1;
    varargout{3} = pos2;
end
