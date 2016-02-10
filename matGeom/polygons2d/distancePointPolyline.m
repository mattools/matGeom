function [minDist, pos] = distancePointPolyline(point, poly, varargin)
%DISTANCEPOINTPOLYLINE  Compute shortest distance between a point and a polyline
%
%   DIST = distancePointPolyline(POINT, POLYLINE)
%   Returns the shortest distance between a point given as a 1-by-2 row
%   vector, and a polyline given as a NV-by-2 array of coordinates.
%
%   If POINT is a NP-by-2 array, the result DIST is a NP-by-1 array,
%   containig the distance of each point to the polyline.
%
%   [DIST, POS] = distancePointPolyline(POINT, POLYLINE)
%   Also returns the relative position of the point projected on the
%   polyline, between 0 and NV, the number of polyline vertices.
%
%   ... = distancePointPolyline(POINT, POLYLINE, CLOSED)
%   Specifies if the polyline is closed or not. CLOSED can be one of:
%   * 'closed' -> the polyline is closed
%   * 'open' -> the polyline is open
%     a column vector of logical with the same number of elements as the
%       number of points -> specify individually if each polyline is
%       closed (true=closed).
%
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
% Author: Juan Pablo Carbajal
% e-mail: ajuanpi+dev@gmail.com

%   HISTORY
%   2009-06-23 compute all distances in one call
%   2016-02-04 Vectorize

% check if input polyline is closed or not
closed = false;
if ~isempty(varargin)
    c = varargin{1};
    if strcmp('closed', c)
        closed = true;
    elseif strcmp('open', c)
        closed = false;
    elseif islogical(c)
        closed = c;
    end
end

% closes the polyline if necessary
if closed
    poly = [poly; poly(1,:)];
end

% number of points
Np = size(point, 1);

% construct the set of edges
edges = [poly(1:end-1, :) poly(2:end, :)];

% compute distance between current each point and all edges, and also
% returns the position of projection on corresponding edge, between 0 and 1
[dist, edgePos] = distancePointEdge(point, edges);

% get the minimum distance, and index of edge providing minimum distance
[minDist, edgeIndex] = min(dist, [], 2);

% if required, compute projections
pos = [];
if nargout == 2
    Ne = size(edgePos, 2);
    j  = sub2ind([Np, Ne], (1:Np)', edgeIndex);
    pos = edgeIndex - 1 + edgePos(j);
end
