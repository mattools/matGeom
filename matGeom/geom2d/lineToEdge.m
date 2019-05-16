function edge = lineToEdge(line)
%LINETOEDGE Convert a straight line to a finite edge.
%
%   EDGE = lineToEdge(LINE)
%   Returns the edge with same origin as the line LINE, and with second
%   extremity corresponding to the addition of line origin and direction.
%   LINE is represented as [X0 Y0  DX DY]
%   EDGE is represented as [X1 Y1  X2 Y2]
%
%   Example
%     line = [3 4  1 2];
%     edge = lineToEdge(line)
%     edge =
%          3   4   4   6
%
%   See also
%     lines2d, edges2d, edgeToLine
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2019-05-07,    using Matlab 9.6.0.1072779 (R2019a)
% Copyright 2019 INRA - Cepia Software Platform.

edge = [line(:, 1:2) line(:,1:2)+line(:,3:4)];
