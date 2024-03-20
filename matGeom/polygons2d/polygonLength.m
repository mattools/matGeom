function len = polygonLength(poly, varargin)
%POLYGONLENGTH Perimeter of a polygon.
%
%   L = polygonLength(POLYGON);
%   Computes the boundary length of a polygon. POLYGON is given by a N-by-2
%   array of vertices. 
%
%   Example
%     % Perimeter of a circle approximation
%     poly = circleToPolygon([0 0 1], 200);
%     polygonLength(poly)
%     ans =
%         6.2829
%
%   See also 
%   polygons2d, polygonCentroid, polygonArea, drawPolygon, polylineLength
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-05-11
% Copyright 2005-2023 INRA - TPV URPOI - BIA IMASTE

% If first argument is a cell array, this is a multi-polygon, and we simply
% add the lengths of individual polygons
if iscell(poly)
    len = 0;
    for i = 1:length(poly)
        len = len + polygonLength(poly{i});
    end
    return;
end

% case of a polygon given as two coordinate arrays
if nargin == 2
    poly = [poly varargin{1}];
end

% check there are enough points
if size(poly, 1) < 2
    len = 0;
    return;
end

% compute length
if size(poly, 2) == 2
    % polygon in dimension 2 (classical case)
    dp = diff(poly([1:end 1], :), 1, 1);
    len = sum(hypot(dp(:, 1), dp(:, 2)));
else
    % polygon of larger dimension
    len = sum(sqrt(sum(diff(poly([2:end 1], :), 1, 1).^2, 2)));
end
