%% Demo Medial Axis
%
%   Generate a random convex polygon, and compute its medial axis.
%
%   See also  medialAxisConvex
%
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 08/07/2005
%

%% Generate random polygon

% clean up
clear all;
close all;

% generate random points in a square
pts = rand(50, 2)*100;

% compute the polygon corersponding to their convex hull
hull = convhull(pts(:,1), pts(:,2));
poly = pts(hull, :);

%% Compute medial axis

% the result is given as graph : n are nodes (points), and e are edges,
% contaiing indices of two vertices of an edge.
[n e] = medialAxisConvex(poly);

%% Draw result

% format new  figure
figure(4);
axis([0 100 0 100]);
hold on;

% draw polygon
drawPolygon(poly);

% draw medial axis of polygon
drawGraph(n, e);

