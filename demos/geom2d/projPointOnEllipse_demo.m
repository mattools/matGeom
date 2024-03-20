%PROJPOINTONELLIPSE_DEMO  One-line description here, please.
%
%   output = projPointOnEllipse_demo(input)
%
%   Example
%   projPointOnEllipse_demo
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2022-09-11,    using Matlab 9.9.0.1570001 (R2020b) Update 4
% Copyright 2022 INRAE.


%% Display ellipse

elli = [50 50  40 20  30];

figure; hold on; axis equal; axis([0 100 0 100]);
drawEllipse(elli, 'LineWidth', 2, 'Color', 'k');


%% Choose points and compute projections

p1 = [90 50];
p2 = [50 90];
p3 = [10 70];
pts = [p1 ; p2 ; p3];
drawPoint(pts, 'bo');

% compute projections
proj = projPointOnEllipse(pts, elli);

% draw projections and display connection
drawPoint(proj, 'ko');
drawEdge([pts proj], 'b');


%% compute distance point to ellipse

dist = distancePointEllipse(pts, elli);

mid = midPoint(pts, proj);
drawLabels(mid + [1 2], dist);
