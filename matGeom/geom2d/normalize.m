function vn = normalize(v)
%NORMALIZE Normalize a vector.
%
%   V2 = normalize(V);
%   Returns the normalization of vector V, such that ||V|| = 1. V can be
%   either a row or a column vector.
%
%   When V is a MxN array, normalization is performed for each row of the
%   array.
%
%   See Also:
%   vectors2d, normalizeVector, vectorNorm
%

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2004-11-29
% Copyright 2004 INRA - TPV URPOI - BIA IMASTE

dim = size(v);

if dim(1)==1 || dim(2)==1
    vn = v/sqrt(sum(v.*v));
else
    vn = v./repmat(sqrt(sum(v.*v, 2)), [1 dim(2)]);
end
