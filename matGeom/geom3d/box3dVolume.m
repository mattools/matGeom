function vol = box3dVolume(box)
%BOX3DVOLUME Volume of a 3-dimensional box.
%
%   V = box3dVolume(BOX)
%
%   A box is represented as a set of limits in each direction:
%   BOX = [XMIN XMAX YMIN YMAX ZMIN ZMAX].
%
%   Example
%   [n e f] = createCubeOctahedron;
%   box = boundingBox3d(n);
%   vol = box3dVolume(box)
%   vol = 
%       8
%
%
%   See also
%   boxes3d, boundingBox3d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-07-26,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

vol = prod(box(:, 2:2:end) - box(:, 1:2:end), 2);
