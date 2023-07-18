function vn = normalizeVector3d(v)
%NORMALIZEVECTOR3D Normalize a 3D vector to have norm equal to 1.
%
%   V2 = normalizeVector3d(V);
%   Returns the normalization of vector V, such that ||V|| = 1. Vector V is
%   given as a row vector.
%
%   If V is a N-by-3 array, normalization is performed for each row of the
%   input array.
%
%   If V is a M-by-N-by-3 array, normalization is performed along the last
%   dimension of the array.
%
%   See also 
%     vectors3d, vectorNorm3d
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2004-11-29
% Copyright 2004-2023 INRA - TPV URPOI - BIA IMASTE

if ismatrix(v)
    vn = bsxfun(@rdivide, v, sqrt(sum(v.^2, 2)));
else
    vn = bsxfun(@rdivide, v, sqrt(sum(v.^2, ndims(v))));
end
