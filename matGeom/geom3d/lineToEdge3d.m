function edge = lineToEdge3d(line)
%LINETOEDGE3D Convert a 3D straight line to a 3D finite edge.
%
%   EDGE = lineToEdge3d(LINE)
%   Returns the edge with same origin as the line LINE, and with second
%   extremity corresponding to the addition of line origin and direction.
%   LINE is represented as [X0 Y0 Z0  DX DY DZ]
%   EDGE is represented as [X1 Y1 Z1  X2 Y2 Z2]
%
%   Example
%     line = [3 4 5  1 2 3];
%     edge = lineToEdge3d(line)
%     edge =
%          3   4   5   4   6   8
%
%   See also
%     lines3d, edges3d, edgeToLine3d
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2019-05-07,    using Matlab 9.6.0.1072779 (R2019a)
% Copyright 2019 INRA - Cepia Software Platform.

edge = [line(:, 1:3) line(:,1:3)+line(:,4:6)];
