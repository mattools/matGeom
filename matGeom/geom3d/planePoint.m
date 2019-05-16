function coord = planePoint(plane, point)
%PLANEPOINT Compute 3D position of a point in a plane.
%
%   POINT = planePoint(PLANE, POS)
%   PLANE is a 9 element row vector [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2]
%   POS is the coordinate of a point in the plane basis,
%   POINT is the 3D coordinate in global basis.
%
%   Example
%     plane = [10 20 30  1 0 0  0 1 1];
%     pos2d = [3 4];
%     pt = planePoint(plane, pos2d)
%     pt = 
%           13  24   34
%
%   See also
%   geom3d, planes3d, planePosition

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-09-18,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

%   HISTORY
%   2013-10-09 remove repmat

% size of input arguments
npl = size(plane, 1);
npt = size(point, 1);

% check inputs have compatible sizes
if npl ~= npt && npl > 1 && npt > 1
    error('geom3d:planePoint:inputSize', ...
        'plane and point should have same size, or one of them must have 1 row');
end

% basis origin, eventually resized
origin = plane(:, 1:3);
if npl == 1 && npt > 1
    origin = origin(ones(npt,1), :);
end

% compute 3D coordinate
coord = origin + ...
    bsxfun(@times, plane(:,4:6), point(:,1)) + ...
    bsxfun(@times, plane(:,7:9), point(:,2)) ;
