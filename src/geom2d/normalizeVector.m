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
%   14/01/2005 correct bug
%   22/05/2009 rename as normalizeVector


dim = size(v);

if dim(1)==1 || dim(2)==1
    vn = v/sqrt(sum(v.*v));
else
    vn = v./repmat(sqrt(sum(v.*v, 2)), [1 dim(2)]);
end