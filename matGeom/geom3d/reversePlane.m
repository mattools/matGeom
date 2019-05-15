function plane = reversePlane(plane)
%REVERSEPLANE Return same 3D plane but with opposite orientation.
%
%   IP = reversePlane(PLANE);
%   Returns a plane contining the same ppints but with normal opposite to
%   that of PLANE. 
%   If PLANE has the format [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2], then IP
%   will have following parameters: [x0 y0 z0 dx1 dy1 dz1 -dx2 -dy2 -dz2].
%
%   See also:
%   createPlane, reverseLine3d
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2012-05-24,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

plane(:, 7:9) = -plane(:, 7:9);

