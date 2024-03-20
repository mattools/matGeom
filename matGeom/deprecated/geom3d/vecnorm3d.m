function n = vecnorm3d(v)
%VECNORM3D compute norm of vector or of set of 3D vectors.
%
%   N = vecnorm(V);
%   Returns norm of vector V.
%
%   When V is a Nx3 array, compute norm for each vector of the array.
%   Vector are given as rows. Result is then a [N*1] array.
%
%   NOTE: compute only euclidean norm.
%
%   See Also
%   vectors3d, normalize3d

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2005-02-21
% Copyright 2005 INRA - TPV URPOI - BIA IMASTE

% deprecation warning
warning('geom3d:deprecated', ...
    '''vecnorm3d'' is deprecated, use ''vectorNorm3d'' instead');

n = sqrt(sum(v.*v, 2));
