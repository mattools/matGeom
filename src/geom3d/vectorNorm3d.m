function n = vectorNorm3d(v)
%VECTORNORM3D Norm of a 3D vector or of set of 3D vectors
%
%   N = vectorNorm3d(V);
%   Returns the norm of vector V.
%
%   When V is a N-by-3 array, compute norm for each vector of the array.
%   Vector are given as rows. Result is then a N-by-1 array.
%
%   NOTE: compute only euclidean norm.
%
%   See Also
%   vectors3d, normalizeVector3d, vectorAngle3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 21/02/2005.

%   HISTORY
%   19/06/2009 rename as vectorNorm3d

n = sqrt(sum(v.*v, 2));
