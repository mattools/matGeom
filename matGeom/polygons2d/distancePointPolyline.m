function minDist = distancePointPolyline(point, poly, varargin)
%DISTANCEPOINTPOLYLINE  Compute shortest distance between a point and a polyline
%
%   DIST = distancePointPolyline(POINT, POLYLINE)
%   Returns the shortest distance between a point given as a 1-by-2 row
%   vector, and a polyline given as a NV-by-2 array of coordinates.
%
%   If POINT is a NP-by-2 array, the result DIST is a NP-by-1 array,
%   containig the distance of each point to the polyline.
%
%   Example:
%       pt1 = [30 20];
%       pt2 = [30 5];
%       poly = [10 10;50 10;50 50;10 50];
%       distancePointPolyline([pt1;pt2], poly)
%       ans =
%           10
%            5
%
%   See also
%   polygons2d, points2d
%   distancePointEdge, distancePointPolygon, projPointOnPolyline
%

% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2009-04-30,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

%   HISTORY
%   2009-06-23 compute all distances in one call

% number of points
Np = size(point, 1);

% allocate memory for result
minDist = inf * ones(Np, 1);

% process each point
for p = 1:Np
    % construct the set of edges
    edges = [poly(1:end-1, :) poly(2:end, :)];
    
    % compute distance between current each point and all edges
    dist = distancePointEdge(point(p, :), edges);

    % update distance if necessary
    minDist(p) = min(dist);
end

