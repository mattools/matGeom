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
poly = [50 50;160 50;160 90;100 90;100 120;50 120;50 50];

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
axis ([0 200 0 150]); axis equal;
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

drawPolygon(poly2, 'lineWidth', 3);


%% Sauvegarde

axis([20 190 20 150]);
fillfigure(gca);
save(gcf, 'poly1Expand.eps', '-depsc');

