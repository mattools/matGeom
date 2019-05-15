function line = reverseLine3d(line)
%REVERSELINE3D Return same 3D line but with opposite orientation.
%
%   INVLINE = reverseLine(LINE);
%   Returns the opposite line of LINE.
%   LINE has the format [x0 y0 z0 dx dy dz], then INVLINE will have
%   following parameters: [x0 y0 z0 -dx -dy -dz].
%
%   See also:
%   reverseLine, reversePlane
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-05-24,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

line(:, 4:6) = -line(:, 4:6);

