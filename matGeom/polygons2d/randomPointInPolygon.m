function points = randomPointInPolygon(poly, varargin)
%RANDOMPOINTINPOLYGON Generate random point(s) in a polygon
%
%   POINT = randomPointInPolygon(POLY)
%   POINTS = randomPointInPolygon(POLY, NPTS)
%
%   Example
%     % generate an ellipse-like polygon, and fill it with points
%     elli = [50 50 50 30 30];
%     poly = ellipseToPolygon(elli, 200);
%     pts = randomPointInPolygon(poly, 500);
%     figure; hold on;
%     drawPolygon(poly, 'k');
%     drawPoint(pts, 'b.');
%     axis equal; axis([0 100 0 100]);
%
%   See also
%     polygons2d, randomPointInBox, drawPolygon
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2017-08-28,    using Matlab 9.1.0.441655 (R2016b)
% Copyright 2017 INRA - Cepia Software Platform.

% determine number of points to generate
nPts = 1;
if nargin > 1
    nPts = varargin{1};
end

% polygon extreme coordinates
box = polygonBounds(poly);
xmin = box(1);  xmax = box(2);
ymin = box(3);  ymax = box(4);

% compute size of box
boxSizeX = xmax - xmin;
boxSizeY = ymax - ymin;

% allocate memory for result
points = zeros(nPts, 2);

% iterate until all points have been sampled within the polygon
ind = (1:nPts)';
while ~isempty(ind)
    NI = length(ind);
    x = rand(NI, 1) * boxSizeX + xmin;
    y = rand(NI, 1) * boxSizeY + ymin;
    points(ind, :) = [x y];
    
    ind = ind(~polygonContains(poly, points(ind, :)));
end
    
