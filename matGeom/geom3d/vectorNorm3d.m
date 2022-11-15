function n = vectorNorm3d(v)
%VECTORNORM3D Norm of a 3D vector or of set of 3D vectors.
%
%   N = vectorNorm3d(V);
%   Returns the norm of vector V.
%
%   When V is a N-by-3 array, compute norm for each vector of the array.
%   Vectors are given as rows. Result is then a N-by-1 array.
%
%   NOTE: Computes only the Euclidean norm.
%
%   See also:
%     vectors3d, normalizeVector3d, vectorAngle3d, hypot3
%

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2005-02-21.
% Copyright 2005 INRA - TPV URPOI - BIA IMASTE

%   HISTORY
%   19/06/2009 rename as vectorNorm3d

n = sqrt(sum(v.*v, ndims(v)));
