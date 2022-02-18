%BOXES3D_DEMO  One-line description here, please.
%
%   output = boxes3d_demo(input)
%
%   Example
%   boxes3d_demo
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2021-09-06,    using Matlab 9.10.0.1684407 (R2021a) Update 3
% Copyright 2021 INRAE.


%% Input Data

% generate data
box1 = [10 60  10 50  10 40];
box2 = [30 90  30 80  30 70];

% draw boxes
figure; axis equal; view(3); axis([0 100 0 100 0 80]); hold on;
h1 = drawBox3d(box1, 'b');
h2 = drawBox3d(box2, 'r');


%% Intersection

boxI = intersectBoxes3d(box1, box2);
h3 = drawBox3d(boxI, 'linewidth', 2, 'color', 'k');


%% Union

boxU = mergeBoxes3d(box1, box2);
h4 = drawBox3d(boxU, 'linewidth', 2, 'linestyle', '--', 'color', 'k');


%% Display legend

legend([h1 h2 h3 h4], {'Box 1', 'Box2', 'Intersection', 'Merge'}, 'Location', 'EastOutside');

print(gcf, 'boxes3d_intersect_merge.png', '-dpng');