function b = isParallel(v1, v2, varargin)
%ISPARALLEL Check parallelism of two vectors.
%
%   B = isParallel(V1, V2)
%   where V1 and V2 are two row vectors of length ND, ND being the
%   dimension, returns 1 if the vectors are parallel, and 0 otherwise.
%
%   Also works when V1 and V2 are two N-by-ND arrays with same number of
%   rows. In this case, return a N-by-1 array containing 1 at the positions
%   of parallel vectors.
%
%   Also works when one of V1 or V2 is N-by-1 and the other one is N-by-ND
%   array, in this case return N-by-1 results.
%
%   B = isParallel(V1, V2, ACCURACY)
%   specifies the accuracy for numerical computation. Default value is
%   1e-14. 
%   
%
%   Example
%   isParallel([1 2], [2 4])
%   ans =
%       1
%   isParallel([1 2], [1 3])
%   ans =
%       0
%
%   See also 
%   vectors2d, isPerpendicular, lines2d
%

% ------
% Author: David Legland
% E-mail: david.legland@inra.fr
% Created: 2006-04-25
% Copyright 2006-2022 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas)

% default accuracy
acc = 1e-14;
if ~isempty(varargin)
    acc = abs(varargin{1});
end

% normalize vectors
v1 = normalizeVector(v1);
v2 = normalizeVector(v2);

% adapt size of inputs if needed
n1 = size(v1, 1);
n2 = size(v2, 1);
if n1 ~= n2
    if n1 == 1
        v1 = v1(ones(n2,1), :);
    elseif n2 == 1
        v2 = v2(ones(n1,1), :);
    end
end

% performs computation
if size(v1, 2) == 2
    % computation for plane vectors
    b = abs(v1(:, 1) .* v2(:, 2) - v1(:, 2) .* v2(:, 1)) < acc;
else
    % computation in greater dimensions 
    b = vectorNorm(cross(v1, v2, 2)) < acc;
end

