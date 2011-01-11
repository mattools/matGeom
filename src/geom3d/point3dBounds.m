function box = point3dBounds(points)
%POINT3DBOUNDS Bounding box of a set of 3D points
%
%   BOX = point3dBounds(POINTS);
%   POINTS is a N-by-3 array of points, each coordinate being given in a
%   column. The result BOX contains extreme coordinates in the form:
%   BOX = [XMIN XMAX YMIN YMAX ZMIN ZMAX].
%
%
%   Example
%   % compute bounding box of a cubeoctehedron
%   [n e f] = createCubeOctahedron;
%   box = point3dBounds(n)
%   box = 
%       -1     1    -1     1    -1     1
%
%
%   See also
%   points3d, boxes3d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-07-26,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% comput extreme coords
mini = min(points, [], 1);
maxi = max(points, [], 1);

% format to obtain have box format
box = [mini ; maxi];
box = box(:)';
