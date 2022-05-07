%DEMOPOLYGONBOUNDS  One-line description here, please.
%
%   output = demoPolygonBounds(input)
%
%   Example
%   demoPolygonBounds
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2022-02-16,    using Matlab 9.9.0.1570001 (R2020b) Update 4
% Copyright 2022 INRAE.

%% Create polygon

% create a polygon with arbitrary vertices
poly = [...
    10 60; 30 40; 20 20; 60 40; 70 10; ...
    90 50; 80 80; 70 70; 60 80; 50 60; 40 80; 30 60];
% poly = [...
%     10 60; 20 40; 30 40; 20 10; 60 40; 80 20; ...
%     90 50; 80 80; 70 70; 60 80; 50 60; 40 80; 30 60];

% display polygon
figure; hold on; 
drawPolygon(poly, 'lineWidth', 2, 'color', 'k');
axis equal; axis([0 100 0 90]);
drawnow;

% draw bounding box
bbox = boundingBox(poly);
drawBox(bbox, 'b')

% draw vertices
elli = polygonEquivalentEllipse(poly);
drawEllipse(elli, 'lineWidth', 2, 'color', [.8 0 0]);

print(gcf, 'polygons_bounds_ellipse.png', '-dpng');
