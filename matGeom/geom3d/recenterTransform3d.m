function res = recenterTransform3d(transfo, center)
%RECENTERTRANSFORM3D Change the fixed point of an affine 3D transform
%
%   TRANSFO2 = recenterTransform3d(TRANSFO, CENTER)
%   where TRANSFO is a 4x4 transformation matrix, and CENTER is a 1x3 row
%   vector, computes the new transformations that uses the same linear part
%   (defined by the upper-left 3x3 corner of the transformation matrix) as
%   the initial transform, and that will leave the point CENTER unchanged.
%
%   
%
%   Example
%   % creating a re-centered rotation using:   
%   rot1 = createRotationOx(pi/3);
%   rot2 = recenterTransform3d(rot1, [3 4 5]);
%   % will give the same result as:
%   rot3 = createRotationOx([3 4 5], pi/3);
%   
%
%   See also
%   transforms3d, createRotationOx, createRotationOy, createRotationOz
%   createTranslation3d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-07-27,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% remove former translation part
res = eye(4);
res(1:3, 1:3) = transfo(1:3, 1:3);

% create translations
t1 = createTranslation3d(-center);
t2 = createTranslation3d(center);

% compute translated transform
res = t2*res*t1;
