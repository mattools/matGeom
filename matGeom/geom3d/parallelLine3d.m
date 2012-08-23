function res = parallelLine3d(line, point)
%PARALLELLINE3D  Create 3D line parallel to another one.
%
%   L2 = parallelLine3d(L, P)
%   Creates the 3D line L2, parallel to the line L, and containing the
%   point P.
%
%   Example
%
%   See also
%   geom3d, parallelLine, parallelPlane
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-08-23,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

res = [point line(:, 4:6)];
