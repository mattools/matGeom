%DEMOVORONOI2D  One-line description here, please.
%
%   output = demoVoronoi2d(input)
%
%   Example
%   demoVoronoi2d
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2022-02-21,    using Matlab 9.10.0.1739362 (R2021a) Update 5
% Copyright 2022 INRAE.

%% initialisations

% define the bounding box
box = [10 90 10 90];

% generate a set of points
rng(42);
germs = rand(15, 2) * 80 + 10;


%% Voronoi diagram

% compute voronoi
[v, e] = boundedVoronoi2d(box, germs);

% display
figure; hold on; axis square; axis([0 100 0 100]);
drawGraph(v, e);
drawPoint(germs, 'bo');
drawBox(box, 'linewidth', 2, 'color', 'k');

% print as image
print(gcf, 'boundedVoronoi2d_demo.png', '-dpng');


%% Cenrtoidal Voronoi diagram

% compute voronoi
nIters = 50;
[v2, e2, f2, g2] = boundedCentroidalVoronoi2d(germs, box, nIters);

% display
figure; hold on; axis square; axis([0 100 0 100]);
drawGraph(v2, e2);
drawPoint(g2, 'bo');
drawBox(box, 'linewidth', 2, 'color', 'k');

% print as image
print(gcf, 'boundedCVD2d_demo.png', '-dpng');


