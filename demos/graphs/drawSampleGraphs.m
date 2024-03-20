% Draw various graphs obtained from the same point set.
%
%   output = drawSampleGraphs(input)
%
%   Example
%   drawSampleGraphs
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-06-04,    using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2020 INRAE.

%% Read input points

% read a set of 16 points within a [10 28]^2 bounding box
pts = load('sedgewick_points.txt');

% display the sample points
figure; axis equal; axis([10 28 10 28]); hold on;
drawPoint(pts, 'bo');
title('Sample points');


%% Delaunay Graph

% compute the graph
[nodes, edges] = delaunayGraph(pts);

% display the sample points
figure; axis equal; axis([10 28 10 28]); hold on;
drawPoint(pts, 'bo');

% display the graph
drawGraphEdges(nodes, edges);
title('Delaunay Graph');


%% Minimal Spanning Tree

% compute the graph
edges = euclideanMST(pts);

% display the sample points
figure; axis equal; axis([10 28 10 28]); hold on;
drawPoint(pts, 'bo');

% display the graph
drawGraphEdges(pts, edges);
title('Minimal Spanning Tree');


%% Relative Neighborhood Graph

% compute the graph
edges = relativeNeighborhoodGraph(pts);

% display the sample points
figure; axis equal; axis([10 28 10 28]); hold on;
drawPoint(pts, 'bo');

% display the graph
drawGraphEdges(pts, edges);
title('Relative Neighborhood Graph');


%% Gabriel Graph

% compute the graph
edges = gabrielGraph(pts);

% display the sample points
figure; axis equal; axis([10 28 10 28]); hold on;
drawPoint(pts, 'bo');

% display the graph
drawGraphEdges(pts, edges);
title('Gabriel Graph');
