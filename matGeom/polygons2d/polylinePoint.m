function point = polylinePoint(poly, pos)
%POLYLINEPOINT Extract a point from a 2D or 3D polyline.
%
%   POINT = polylinePoint(POLYLINE, POS)
%   POLYLINE is a N*2 or N*3 array containing coordinate of polyline vertices
%   POS is comprised between 0 (first point of polyline) and Nv-1 (last
%   point of the polyline).
%   
%
%   Example
%   poly = [10 10;20 10;20 20;30 30];
%   polylinePoint(poly, 0)
%       [10 10]
%   polylinePoint(poly, 3)
%       [30 30]
%   polylinePoint(poly, 1.4)
%       [20 14]
%
%
%   See also 
%   polygons2d

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2009-04-30, using Matlab 7.7.0.471 (R2008b)
% Copyright 2009-2024 INRA - Cepia Software Platform

% number of points to compute
Np = length(pos(:));

% number of vertices in polyline
Nv = size(poly, 1);

% allocate memory results
point = zeros(Np, size(poly,2));

% iterate on points
for i=1:Np
    % compute index of edge (between 0 and Nv)
    ind = floor(pos(i));
    
    % special case of last point of polyline
    if ind==Nv-1
        point(i,:) = poly(end,:);
        continue;
    end
    
    % format index to ensure being on polyline
    ind = min(max(ind, 0), Nv-2);
    
    % position on current edge
    t = min(max(pos(i)-ind, 0), 1);
    
    % parameters of current edge
    x0 = poly(ind+1, 1);
    y0 = poly(ind+1, 2);
    dx = poly(ind+2,1)-x0;
    dy = poly(ind+2,2)-y0;
    if size(poly,2)>2
        z0 = poly(ind+1, 3);
        dz = poly(ind+2,3)-z0;
    end
    % compute position of current point    
    if size(poly,2)>2
        point(i, :) = [x0+t*dx, y0+t*dy, z0+t*dz];
    else
        point(i, :) = [x0+t*dx, y0+t*dy];
    end
end
