function varargout = makeDemo(varargin)
%MAKEDEMO  One-line description here, please.
%   output = makeDemo(input)
%
%   Example
%   makeDemo
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-17,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.


%% Initialisations

% polygone de base, double le dernier sommet
poly = [50 50;200 50;200 150;100 150;180 70;70 70;120 120;50 120;50 50];

dist = 10;

% number of vertices of the polygon
N = size(poly, 1)-1;


%% Calcul des droites

% droites paralleles
lines = zeros(N, 4);
for i=1:N
    side = createLine(poly(i,:), poly(i+1,:));
    lines(i, 1:4) = parallelLine(side, dist);
end

figure(1); clf; hold on;
axis equal; axis ([0 250 0 200]);
drawPolygon(poly, 'linewidth', 3, 'color', 'k')
drawLine(lines);


%% Intersections

% double la derniere droite pour calculer la derniere intersection
lines = [lines;lines(1,:)];

% compute intersection points of consecutive lines
poly2 = zeros(N, 2);
for i=1:N
    poly2(i,1:2) = intersectLines(lines(i,:), lines(i+1,:));
end

% dessine les intersections
drawPoint(poly2, 'ro');


%% Polygone final

figure(1); clf; hold on;
axis equal; axis ([0 250 0 200]);
drawPolygon(poly, 'linewidth', 3, 'color', 'k')
drawPolygon(poly2)

drawPoint(polylineSelfIntersections(poly2, 'closed'), 'ro');

% Sauvegarde

fillfigure(gca);
print(gcf, 'poly2Expand.eps', '-depsc');



%% Polygone final

figure(1); clf; hold on;
axis equal; axis ([0 250 0 200]);
drawPolygon(poly, 'linewidth', 3, 'color', 'k')

drawPolygon(expandPolygon(poly, 10));


% Sauvegarde

fillfigure(gca);
print(gcf, 'poly2Final.eps', '-depsc');

