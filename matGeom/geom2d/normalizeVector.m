function vn = normalizeVector(v)
%NORMALIZEVECTOR Normalize a vector to have norm equal to 1.
%
%   V2 = normalizeVector(V);
%   Returns the normalization of vector V, such that ||V|| = 1. V can be
%   either a row or a column vector.
%
%   When V is a M-by-N array, normalization is performed for each row of
%   the array.
%
%   When V is a M-by-N-by-2 array, normalization is performed along the
%   last dimension of the array.
%
%   Example:
%   vn = normalizeVector([3 4])
%   vn =
%       0.6000   0.8000
%   vectorNorm(vn)
%   ans =
%       1
%
%   See Also:
%     vectors2d, vectorNorm
%

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2004-11-29
% Copyright 2004 INRA - TPV URPOI - BIA IMASTE

if ismatrix(v)
    vn = bsxfun(@rdivide, v, sqrt(sum(v.^2, 2)));
else
    vn = bsxfun(@rdivide, v, sqrt(sum(v.^2, ndims(v))));
end
