function checkClipLine(varargin)
%CHECKCLIPRAY  One-line description here, please.
%   output = checkClipLine(input)
%
%   Example
%   checkClipLine
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-05-13,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% generate 2D rays in -50->150 in each direction
N = 50;
origins = rand(N, 2)*200 - 50;
theta = rand(N, 1)*2*pi;
directions = [cos(theta) sin(theta)];
lines = [origins directions];

% create new figure
figure(1); clf;
axis([-50 150 -50 150]);
hold on;

% draw all rays
drawLine(lines);

% clip rays
box = [0 100 0 100];
clipped = clipLine(lines, box);

% draw clipped edges
drawBox(box);
drawEdge(clipped, 'linewidth', 2);
drawPoint(origins, 'bo');
