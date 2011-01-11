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


%% Lecture polygone

% repertoire contenant les contours apres simplification (pour reduire les
% temps de calcul)
repMaize = fullfile('d:', 'dlegland', 'projets', 'maizewall', 'dec2007', 'macro');
repCnt = fullfile(...
    repMaize, 'outline', 'extract', 'tables', 'cntMuDec100');

name ='m02a';

% lecture du tableau de donnees
tab = tableRead(fullfile(repCnt, [name 'CntMuDec100.txt']));

% extrait le polygone, et convertit en millimetres
poly = tab.d/1000;

% renverse le polygone en vertical, avec une origine arbitraire
poly(:,2) = 15-poly(:,2);

%% Dessin de base

figure(1); clf; hold on; axis equal;
drawPolygon(poly, 'linewidth', 2);
axis off;

% save
print(gcf, 'm02aContour.eps', '-depsc');


%% Dessine plusieurs contours imbriques

for d = .5:.5:7.5
    poly2 = expandPolygon(poly, d);
    drawPolygon(poly2);
end

print(gcf, 'm02aFrontWave.eps', '-depsc');
