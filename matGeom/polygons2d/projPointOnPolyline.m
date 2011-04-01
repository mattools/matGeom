function varargout = projPointOnPolyline(point, poly, varargin)
%PROJPOINTONPOLYLINE Compute position of a point projected on a polyline
%
%   POS = projPointOnPolyline(POINT, POLYLINE)
%   Compute the position of the orthogonal projection of a point on a
%   polyline.
%   POINT is a 1x2 row vector containing point coordinates
%   POLYLINE is a Nx2 array containing coordinates of polyline vertices
%   POS is the position of the point on the polyline, between 0 and the
%   number of vertices of the polyline. POS can be a non-integer value, in
%   this case, the integer part correspond to the polyline edge index
%   (between 0 and Nv-1), and the floating-point part correspond to the
%   relative position on i-th edge (between 0 and 1, 0: edge start, 1: edge
%   end).
%
%   When POINT is an array of points, returns a column vector with as many
%   rows as the number of points.
%
%   POS = projPointOnPolyline(POINT, POLYLINE, CLOSED)
%   Specify if the polyline is closed or not. CLOSED can be one of:
%     'closed' -> the polyline is closed
%     'open' -> the polyline is open
%     a column vector of logical with the same number of elements as the
%       number of points -> specify individually if each polyline is
%       closed (true=closed).
%
%   [POS DIST] = projPointOnPolyline(...)
%   Also returns the distance between POINT and POLYLINE.
%
%   Example
%   projPointOnPolyline
%
%   See also
%   points2d, polygons2d, polylinePoint
%   distancePointPolyline
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-30,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

% check if input polyline is closed or not
closed = false;
if ~isempty(varargin)
    var = varargin{1};
    if strcmp('closed', var)
        closed = true;
    elseif strcmp('open', var)
        closed = false;
    elseif islogical(var)
        closed = var;
    end
end

% closes the polyline if necessary
if closed
    poly = [poly;poly(1,:)];
end

% number of points
Np = size(point, 1);

% number of vertices in polyline
Nv = size(poly, 1);

% allocate memory results
pos     = zeros(Np, 1);
minDist = inf*ones(Np, 1);

% iterate on points
for p=1:Np
    % compute smallest distance to each edge
    for i=1:Nv-1
        % build current edge
        edge = [poly(i,:) poly(i+1,:)];
        
        % compute distance between current point and edge
        [dist edgePos] = distancePointEdge(point(p, :), edge);
        
        % update distance and position if necessary
        if dist<minDist(p)
            minDist(p) = dist;
            pos(p) = i-1 + edgePos;
        end
    end    
end

% process output arguments
if nargout<=1
    varargout{1} = pos;
elseif nargout==2
    varargout{1} = pos;
    varargout{2} = minDist;
end

