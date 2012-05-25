function plane = reversePlane(plane)
%REVERSEPLANE Return same 3D plane but with opposite orientation
%
%   IP = reversePlane(PLANE);
%   Returns the plane opposite to PLANE.
%   PLANE has the format [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2], then IP will
%   have following parameters: [x0 y0 z0 -dx1 -dy1 -dz1 -dx2 -dy2 -dz2].
%
%   See also:
%   reverseLine3d
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-05-24,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

plane(:, 4:9) = -plane(:, 4:9);

