function n = vectorNorm(v, varargin)
%VECTORNORM Compute norm of a vector, or of a set of vectors.
%
%   N = vectorNorm(V);
%   Returns the euclidean norm of vector V.
%
%   N = vectorNorm(V, N);
%   Specifies the norm to use. N can be any value greater than 0. 
%   N=1 -> city lock norm
%   N=2 -> euclidean norm
%   N=inf -> compute max coord.
%
%   When V is a MxN array, compute norm for each vector of the array.
%   Vector are given as rows. Result is then a [M*1] array.
%
%   Example
%   n1 = vectorNorm([3 4])
%   n1 =
%       5
%
%   n2 = vectorNorm([1, 10], inf)
%   n2 =
%       10
%
%   See also 
%     vectors2d, vectorAngle
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-02-21
% Copyright 2005-2022 INRA - TPV URPOI - BIA IMASTE

% extract the type of norm to compute
d = 2;
if ~isempty(varargin)
    d = varargin{1};
end

if d==2
    % euclidean norm: sum of squared coordinates, and take square root
    n = sqrt(sum(v.*v, ndims(v)));
    
elseif d==1 
    % absolute norm: sum of absolute coordinates
    n = sum(abs(v), ndims(v));

elseif d==inf
    % infinite norm: uses the maximal corodinate
    n = max(v, [], ndims(v));

else
    % Other norms, use explicit but slower expression  
    n = power(sum(power(v, d), ndims(v)), 1/d);
    
end
