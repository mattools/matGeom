function demoNapoleon(varargin)
%DEMONAPOLEON  Small demo of a theorem on triangles
%
%   output = demoNapoleon(input)
%
%   Example
%   demoNapoleon
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-08-19,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.

%% base triangle 

% choose 3 points on the plane
A = [10 8];
B = [3 2];
C = [12 3];

% create a polygon for the base triangle
ABC = [A ; B ; C];

% Draw the base triangle
figure;
drawPolygon(ABC, 'color', 'k', 'lineWidth', 2);
axis equal;
axis([-5 20 -8 12]);
hold on;


%% Equliateral triangles

% create an equilateral triangle from each side, pointing outwards
tAB = createTriangle(B, A);
tBC = createTriangle(C, B);
tAC = createTriangle(A, C);

% draw each equilateral triangle
drawPolygon(tAB, 'color', 'b');
drawPolygon(tBC, 'color', 'b');
drawPolygon(tAC, 'color', 'b');


%% Compute centroid of each triangle

% compute centroids
c1 = polygonCentroid(tAB);
c2 = polygonCentroid(tBC);
c3 = polygonCentroid(tAC);

% draw the triangle formed by the centroids
triC = [c1; c2; c3];
drawPolygon(triC, 'lineWidth', 2, 'color', [0 .8 0]);
drawPoint(triC, 'marker', 'o', 'markerSize', 8, 'markerfacecolor', [0 .8 0]);


function tri = createTriangle(p1, p2)

d12 = distancePoints(p1, p2);
c1 = [p1 d12];
c2 = [p2 d12];
inters = intersectCircles(c1, c2);

indPos = isCounterClockwise(p1, p2, inters) > 0;
p3 = inters(indPos, :);

tri = [p1; p2; p3];
