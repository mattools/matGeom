%LINES2D_DATA  One-line description here, please.
%
%   output = lines2d_data(input)
%
%   Example
%   lines2d_data
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2020-01-09,    using Matlab 9.7.0.1247435 (R2019b) Update 2
% Copyright 2020 INRA - Cepia Software Platform.

% global settings
center = [50 50];
dirVector = [20 15];

% create one sample from each data type
edgeCenter = center - [20 -10];
edge = [edgeCenter - dirVector, edgeCenter + dirVector];
rayCenter = center;
ray = [rayCenter - dirVector, dirVector];
lineCenter = center + [20 -10];
line = [lineCenter - dirVector, dirVector];

% draw each item
figure; set(gca, 'fontsize', 14); axis equal; axis([0 100 0 100]); hold on;
drawEdge(edge, 'linewidth', 2, 'color', [0 0 .7]);
drawPoint([edge(1:2) ; edge(3:4)], 'linewidth', 2, 'color', [0 0 .7], 'marker', 'o', 'markerFaceColor', [0 0 .7]);
drawRay(ray, 'linewidth', 2, 'color', [0 .7 0]);
drawPoint(ray(1:2), 'linewidth', 2, 'color', [0 .7 0], 'marker', 'o', 'markerFaceColor', [0 .7 0]);
drawLine(line, 'linewidth', 2, 'color', [.7 0 0]);

print(gcf, 'lines2d_data.png', '-dpng');
