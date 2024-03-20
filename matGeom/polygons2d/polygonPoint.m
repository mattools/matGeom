function point = polygonPoint(poly, pos)
%POLYGONPOINT Extract a point from a polygon.
%
%   POINT = polygonPoint(POLYGON, POS)
%   
%
%   Example
%   polygonPoint
%
%   See also 
%   polygons2d, polylinePoint
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2009-04-30, using Matlab 7.7.0.471 (R2008b)
% Copyright 2009-2023 INRA - Cepia Software Platform

% eventually copy first point at the end to ensure closed polygon
if sum(poly(end, :) == poly(1,:))~=2
    poly = [poly; poly(1,:)];
end

% number of points to compute
nPoints = length(pos(:));

% number of vertices in polygon
Nv = size(poly, 1)-1;

% allocate memory results
point = zeros(nPoints, 2);

% iterate on points
for i = 1:nPoints
    % compute index of edge (between 0 and Nv)
    ind = floor(pos(i));
    
    % special case of last point of polyline
    if ind==Nv
        point(i,:) = poly(end,:);
        continue;
    end
    
    % format index to ensure being on polygon
    ind = min(max(ind, 0), Nv-1);
    
    % position on current edge
    t = min(max(pos(i)-ind, 0), 1);
    
    % parameters of current edge
    x0 = poly(ind+1, 1);
    y0 = poly(ind+1, 2);
    dx = poly(ind+2,1)-x0;
    dy = poly(ind+2,2)-y0;
    
    % compute position of current point
    point(i, :) = [x0+t*dx, y0+t*dy];
end
