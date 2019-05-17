function polygons = splitPolygons3d(polygon)
%SPLITPOLYGONS3D Convert a NaN separated polygon list to a cell array of polygons.
%
%   Same function as splitpolygons for planar case, included in private
%   directory of geom3d to avoid missing file problems.
%

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-10-12,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

if iscell(polygon)
    % case of a cell array
    polygons = polygon;
    
elseif sum(isnan(polygon(:))) == 0
    % single polygon -> no break
    polygons = {polygon};
    
else
    % find indices of NaN couples
    inds = find(sum(isnan(polygon), 2) > 0);
    
    % number of polygons
    N = length(inds) + 1;
    polygons = cell(N, 1);

    % iterate over NaN-separated regions to create new polygon
    inds = [0; inds; size(polygon, 1)+1];
    for i = 1:N
        polygons{i} = polygon((inds(i)+1):(inds(i+1)-1), :);    
    end
end
