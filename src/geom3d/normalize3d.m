function vn = normalize3d(v)
%NORMALIZE3D normalize a 3D vector
%
%   V2 = normalize3d(V);
%   Returns the normalization of vector V, such that ||V|| = 1. Vector V is
%   given as a row vector.
%
%   When V is a Nx3 array, normalization is performed for each row of the
%   array.
%
%   See also:
%   vectors3d, vecnorm3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 29/11/2004.
%

%   HISTORY
%   30/11/2005 correct a bug
%   19/06/2009 deprecate and replace by normalizeVector3d

% deprecation warning
warning('geom3d:deprecated', ...
    '''normalize3d'' is deprecated, use ''normalizeVector3d'' instead');

n = sqrt(v(:,1).*v(:,1) + v(:,2).*v(:,2) + v(:,3).*v(:,3));
vn = v./[n n n];
