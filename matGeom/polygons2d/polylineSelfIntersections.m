function varargout = polylineSelfIntersections(poly, varargin)
%POLYLINESELFINTERSECTIONS Find self-intersections points of a polyline
%
%   PTS = polylineSelfIntersections(POLY);
%   Return the position of self intersection points
%
%   [PTS POS1 POS2] = polylineSelfIntersections(POLY);
%   Also return the 2 positions of each intersection point (the position
%   when meeting point for first time, then position when meeting point
%   for the second time).
%
%   Example
%       % use a gamma-shaped polyline
%       poly = [0 0;0 10;20 10;20 20;10 20;10 0];
%       polylineSelfIntersections(poly)
%       ans = 
%           10 10
%
%       % use a 'S'-shaped polyline
%       poly = [10 0;0 0;0 10;20 10;20 20;10 20];
%       polylineSelfIntersections(poly)
%       ans = 
%           10 10
%
%   See also
%   polygons2d, intersectPolylines, polygonSelfIntersections
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-15,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

%   HISTORY
%   2009/06/18 check bounding boxes before computing intersections


%% Initialisations

% determine whether the polyline is closed
closed = false;
if ~isempty(varargin)
    closed = varargin{1};
    if ischar(closed)
        if strcmp(closed, 'closed')
            closed = true;
        elseif strcmp(closed, 'open')
            closed = false;
        end
    end
end

% if polyline is closed, ensure the last point equals the first one
if closed
    if sum(abs(poly(end, :)-poly(1,:))<1e-14)~=2
        poly = [poly; poly(1,:)];
    end
end

% arrays for storing results
points  = zeros(0, 2);
pos1    = zeros(0, 1);
pos2    = zeros(0, 1);

% number of vertices
Nv = size(poly, 1);


%% Main processing

% index of current intersection
ip = 0;

% iterate over each couple of edge ( (N-1)*(N-2)/2 iterations)
for i=1:Nv-2
    % create first edge
    edge1 = [poly(i, :) poly(i+1, :)];
    for j=i+2:Nv-1
        % create second edge
        edge2 = [poly(j, :) poly(j+1, :)];

        % check conditions on bounding boxes
        if min(edge1([1 3]))>max(edge2([1 3]))
            continue;
        end
        if max(edge1([1 3]))<min(edge2([1 3]))
            continue;
        end
        if min(edge1([2 4]))>max(edge2([2 4]))
            continue;
        end
        if max(edge1([2 4]))<min(edge2([2 4]))
            continue;
        end
        
        % compute intersection point
        inter = intersectEdges(edge1, edge2);
        
        if sum(isfinite(inter))==2
            % add point to the list
            ip = ip + 1;
            points(ip, :) = inter;
            
            % also compute positions on the polyline
            pos1(ip, 1) = i+edgePosition(inter, edge1)-1;
            pos2(ip, 1) = j+edgePosition(inter, edge2)-1;
        end
    end
end

% if polyline is closed, the first vertex was found as an intersection, so
% we need to remove it
if closed
    dist = distancePoints(points, poly(1,:));
    [minDist ind] = min(dist); %#ok<ASGLU>
    points(ind,:) = [];
    pos1(ind)   = [];
    pos2(ind)   = [];
end

%% Post-processing

% process output arguments
if nargout<=1
    varargout{1} = points;
elseif nargout==3
    varargout{1} = points;
    varargout{2} = pos1;
    varargout{3} = pos2;
end
