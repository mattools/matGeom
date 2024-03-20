function line = edgeToLine(edge)
%EDGETOLINE Convert an edge to a straight line.
%
%   LINE = edgeToLine(EDGE);
%   Returns the straight line containing the edge EDGE.
%   EDGE is represented as [X1 Y1  X2 Y2]
%   LINE is represented as [X0 Y0  DX DY]
%
%   Example
%       edge = [2 3 4 5];
%       line = edgeToLine(edge);
%       figure(1); hold on; axis([0 10 0 10]);
%       drawLine(line, 'color', 'g')
%       drawEdge(edge, 'linewidth', 2)
%   
%   See also 
%   edges2d, lines2d, lineToEdge
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2009-07-23, using Matlab 7.7.0.471 (R2008b)
% Copyright 2009-2023 INRA - Cepia Software Platform

line = [edge(:, 1:2) edge(:, 3:4)-edge(:, 1:2)];
