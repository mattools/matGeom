function vn = normalize(v)
%NORMALIZE normalize a vector
%
%   V2 = normalize(V);
%   Returns the normalization of vector V, such that ||V|| = 1. V can be
%   either a row or a column vector.
%
%   When V is a MxN array, normalization is performed for each row of the
%   array.
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
%   14/01/2005 : correct bug


dim = size(v);

if dim(1)==1 || dim(2)==1
    vn = v/sqrt(sum(v.*v));
else
    vn = v./repmat(sqrt(sum(v.*v, 2)), [1 dim(2)]);
end