function res = parallelEdge(edge, dist)
%PARALLELEDGE Edge parallel to another edge
%
%   EDGE2 = parallelEdge(EDGE, DIST)
%   Computes the edge parallel to the input edge EDGE and located at the
%   given signed distance DIST.
%
%   Example
%     obox = [30 40 80 40 30];
%     figure; hold on; axis equal;
%     drawOrientedBox(obox, 'LineWidth', 2);
%     edge1 = centeredEdgeToEdge(obox([1 2 3 5]));
%     edge2 = centeredEdgeToEdge(obox([1 2 4 5])+[0 0 0 90]);
%     drawEdge(edge1, 'LineWidth', 2, 'color', 'g');
%     drawEdge(edge2, 'LineWidth', 2, 'color', 'g');
%     drawEdge(parallelEdge(edge1, -30), 'LineWidth', 2, 'color', 'k');
%     drawEdge(parallelEdge(edge2, -50), 'LineWidth', 2, 'color', 'k');
%
%   See also
%     edges2d, parallelLine, drawEdge, centeredEdgeToEdge, edgeToLine
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-07-31,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% compute the line parallel to the supporting line of edge
line = parallelLine(edgeToLine(edge), dist);

% result edge is given by line positions 0 and 1.
res = [line(:, 1:2) line(:, 1:2)+line(:, 3:4)];
