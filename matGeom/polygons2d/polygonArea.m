function area = polygonArea(poly, varargin)
%POLYGONAREA Compute the signed area of a polygon.
%
%   A = polygonArea(POINTS);
%   Compute area of a polygon defined by POINTS. POINTS is a N-by-2 array
%   of double containing coordinates of vertices.
%   
%   Vertices of the polygon are supposed to be oriented Counter-Clockwise
%   (CCW). In this case, the signed area is positive.
%   If vertices are oriented Clockwise (CW), the signed area is negative.
%
%   If polygon is self-crossing, the result is undefined.
%
%   Examples
%     % compute area of a simple shape
%     poly = [10 10;30 10;30 20;10 20];
%     area = polygonArea(poly)
%     area = 
%         200
%
%     % compute area of CW polygon
%     area2 = polygonArea(poly(end:-1:1, :))
%     area2 = 
%         -200
%
%     % Computes area of a paper hen
%     x = [0 10 20  0 -10 -20 -10 -10  0];
%     y = [0  0 10 10  20  10  10  0 -10];
%     poly = [x' y'];
%     area = polygonArea(poly)
%     area =
%        400
%
%     % Area of unit square with 25% hole
%     pccw = [0 0; 1 0; 1 1; 0 1];
%     pcw = pccw([1 4 3 2], :) * .5 + .25;
%     polygonArea ([pccw; nan(1,2); pcw])
%     ans =
%        0.75
%
%   References
%   algo adapted from P. Bourke web page
%   http://paulbourke.net/geometry/polygonmesh/
%
%   See also 
%   polygons2d, polygonCentroid, polygonSecondAreaMoments, triangleArea
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2004-05-05
% Copyright 2004-2023 INRA - TPV URPOI - BIA IMASTE

%% Process special cases

% in case of polygon sets, computes the sum of polygon areas
if iscell(poly)
    area = 0;
    for i = 1:length(poly)
        area = area + polygonArea(poly{i});
    end
    return;
end

% check there are enough points
if size(poly, 1) < 2
    area = 0;
    return;
end

% case of polygons with holes -> computes the sum of areas
if any(isnan(poly))
    area = sum(polygonArea(splitPolygons(poly)));
    return;
end


%% Process single polygons or single rings

% extract coordinates
if nargin == 1
    % polygon given as N-by-2 array
    px = poly(:, 1);
    py = poly(:, 2);
    
elseif nargin == 2
    % poylgon given as two N-by-1 arrays
    px = poly;
    py = varargin{1};
end

% indices of next vertices
N = length(px);
iNext = [2:N 1];

% compute area (vectorized version)
area = sum(px .* py(iNext) - px(iNext) .* py) / 2;
