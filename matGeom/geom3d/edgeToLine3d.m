function line = edgeToLine3d(edge)
%EDGETOLINE3D Convert a 3D edge to a 3D straight line
%
%   LINE = edgeToLine3d(EDGE)
%
%   Example
%   edgeToLine3d
%
%   See also
%     lines3d, edgeToLine
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-04-12,    using Matlab 9.3.0.713579 (R2017b)
% Copyright 2018 INRA - Cepia Software Platform.

line = [edge(:, 1:3) edge(:, 4:6)-edge(:, 1:3)];