function n = vecnorm3d(v)
%VECNORM3D compute norm of vector or of set of 3D vectors
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
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 21/02/2005.
%

%   HISTORY
%   19/06/2009 deprecate and replace by vectorNorm3d

% deprecation warning
warning('geom3d:deprecated', ...
    '''vecnorm3d'' is deprecated, use ''vectorNorm3d'' instead');

n = sqrt(sum(v.*v, 2));
