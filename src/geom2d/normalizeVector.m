function vn = normalizeVector(v)
%NORMALIZEVECTOR normalize a vector
%
%   V2 = normalizeVector(V);
%   Returns the normalization of vector V, such that ||V|| = 1. V can be
%   either a row or a column vector.
%
%   When V is a MxN array, normalization is performed for each row of the
%   array.
%
%   Example:
%   normalizeVector([3 3])
%       [ 0.7071   0.7071 ]
%
%   See Also:
%   vectors2d, vecnorm
%
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 29/11/2004.
%

%   HISTORY
%   2005-01-14 correct bug
%   2009-05-22 rename as normalizeVector
%   2011-01-20 use bsxfun

dim = size(v);

if dim(1)==1 || dim(2)==1
    vn = v / sqrt(sum(v.^2));
else
    %same as: vn = v./repmat(sqrt(sum(v.*v, 2)), [1 dim(2)]);
    vn = bsxfun(@rdivide, v, sqrt(sum(v.^2, 2)));
end
