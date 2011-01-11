function varargout = makeDemo0(varargin)
%MAKEDEMO0  One-line description here, please.
%   output = makeDemo0(input)
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
poly = [150 100;200 100;200 150;150 150;150 200;50 200;150 100];

dist = 20;


%% Polygone final

% calcul l'expansion
poly2 = expandPolygon(poly, dist);

% affiche
figure(1); clf; hold on; axis equal;
drawPolygon(poly, 'lineWidth', 2, 'color', 'k');
drawPolygon(poly2);


%% Sauvegarde

axis square
axis([0 250 50 250])
axis off
fillfigure(gca);


print(gcf, 'poly0Expand.eps', '-depsc');

