function varargout = projPointOnPolyline3d(point, poly, varargin)
%PROJPOINTONPOLYLINE3D Compute position of a 3D point projected on a 3D polyline.
%
%   POS = projPointOnPolyline3d(POINT, POLYLINE)
%   Compute the position of the orthogonal projection of a 3D point on a
%   3D polyline.
%   POINT is a 1-by-3 row vector containing point coordinates
%   POLYLINE is a N-by-3 array containing coordinates of polyline vertices
%   POS is the position of the point on the polyline, between 0 and the
%   number of vertices of the polyline. POS can be a non-integer value, in
%   this case, the integer part corresponds to the polyline edge index
%   (between 0 and Nv-1), and the floating-point part corresponds to the
%   relative position on i-th edge (between 0 and 1, 0: edge start, 1: edge
%   end).
%
%   When POINT is an array of points, returns a column vector with as many
%   rows as the number of points.
%
%   POS = projPointOnPolyline3d(POINT, POLYLINE, CLOSED)
%   Specifies if the polyline is closed or not. CLOSED can be one of:
%     'closed' -> the polyline is closed
%     'open' -> the polyline is open
%     a column vector of logical with the same number of elements as the
%       number of points -> specify individually if each polyline is
%       closed (true=closed).
%
%   [POS, DIST] = projPointOnPolyline(...)
%   Also returns the distance between POINT and POLYLINE.
%
%   Example
%     poly = [10 10 10; 20 10 10;20 20;10 20 20];
%     projPointOnPolyline([15 0 10], poly)
%     ans =
%         
%     projPointOnPolyline([0 16], poly)
%     ans =
%         
%
%   See also 
%   points2d, polygons2d, polylinePoint, projPointOnPolygon
%   distancePointPolyline
%

% ------
% Author: Guilherme Froes Silva
% E-mail: g.froessilva@qut.edu.au
% Created: 2022-09-12, using Matlab 9.12.0.1927505 (R2022a) Update 1
% Copyright 2022-2024

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
    poly = [poly ; poly(1,:)];
end

% number of points
Np = size(point, 1);

% allocate memory results
pos     = zeros(Np, 1);
minDist = inf*ones(Np, 1);

% iterate on points
for p = 1:Np
    % build set of 3D edges
    edges = [poly(1:end-1, :) poly(2:end, :)];
    
    % compute distance between current point and all edges
    [dist, edgePos] = distancePointEdge3d(point(p, :), edges);
    
    % update distance and position if necessary
    [minDist(p), edgeIndex] = min(dist);
    pos(p) = edgeIndex - 1 + edgePos(edgeIndex);   
end

% process output arguments
if nargout <= 1
    varargout{1} = pos;
elseif nargout == 2
    varargout{1} = pos;
    varargout{2} = minDist;
end

