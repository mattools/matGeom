function line = edgeToLine3d(edge)
%EDGETOLINE3D Convert a 3D edge to a 3D straight line.
%
%   LINE = edgeToLine3d(EDGE)
%   Returns the 3D straight line containing the 3D edge EDGE.
%   EDGE is represented as [X1 Y1 Z1  X2 Y2 Z2]
%   LINE is represented as [X0 Y0 Z0  DX DY DZ]
%
%   Example
%       edge = [3 4 5  4 6 8];
%       line = edgeToLine3d(edge)
%       line = 
%            3   4   5   1   2   3
%
%   See also
%     lines3d, edges3d, edgeToLine, lineToEdge3d
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-04-12,    using Matlab 9.3.0.713579 (R2017b)
% Copyright 2018 INRA - Cepia Software Platform.

line = [edge(:, 1:3) edge(:, 4:6)-edge(:, 1:3)];