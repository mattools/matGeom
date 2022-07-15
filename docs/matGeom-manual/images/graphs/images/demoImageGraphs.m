%DEMOIMAGEGRAPHS  One-line description here, please.
%
%   output = demoImageGraphs(input)
%
%   Example
%   demoImageGraphs
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2022-04-01,    using Matlab 9.12.0.1884302 (R2022a)
% Copyright 2022 INRAE.

% create a simple 2D binary image

lx = -10:10;
ly = -10:10;
[x, y] = meshgrid(lx, ly);
img = hypot(x, y) < 8.5;

figure; 
imshow(img, 'InitialMagnification', 1000);
print(gcf, 'sample_image.png', '-dpng');

% create adjacency graph

[v, e] = imageGraph(img);
figure; imshow(ones(size(img)), 'InitialMagnification', 1000);
hold on; drawGraph(v, e);
print(gcf, 'imageGraph_2d.png', '-dpng');

% create boundary graph

[v, e] = imageBoundaryGraph(img);
figure; imshow(ones(size(img)), 'InitialMagnification', 1000);
hold on; drawGraphEdges(v, e, 'Color', 'b', 'LineWidth', 2);
print(gcf, 'imageBoundaryGraph_2d.png', '-dpng');

% save into figure
print(gcf, 'image_graphs_2d.png', '-dpng');