function b = isPerpendicular(v1, v2, varargin)
%ISPERPENDICULAR Check orthogonality of two vectors
%
%   B = isPerpendicular(V1, V2)
%   where V1 and V2 are two 1-by-2 row arrays, returns 1 if the vectors are
%   perpendicular, and 0 otherwise.
%
%   Also works when V1 and V2 are two N-by-2 arrays with same number of
%   rows. In this case, return a N-by-1 array containing 1 at the positions
%   of perpendicular vectors.
%
%   Also works when one of V1 or V2 is 1-by-2 and the other one is a N-by-2
%   array. In this case the result has size N-by-1.
%
%   B = isPerpendicular(V1, V2, ACCURACY)
%   specifies accuracy of numerical tests, default is 1e-14.
%
%
%   Example
%   isPerpendicular([1 2 1], [2 4 2])
%   ans =
%       1
%
%   isPerpendicular([1 2 1], [1 3 2])
%   ans =
%       0
%
%   See also
%   vectors2d, isParallel, lines2d
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2006-04-25
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

%   HISTORY
%   2007-09-18 copy from isPerpendicular, adapt to any dimension, and add
%       psb to specify precision
%   2009-09-21 fix bug for array of 3 vectors
%   2011-01-20 replace repmat by ones-indexing (faster)

% default accuracy
acc = 1e-14;
if ~isempty(varargin)
    acc = abs(varargin{1});
end

% adapt size of inputs
n1 = size(v1, 1);
n2 = size(v2, 1);
if n1~=n2
    if n1==1
        v1 = v1(ones(n2, 1), :);
    elseif n2==1
        v2 = v2(ones(n1, 1), :);
    else
        error('Inputs must either have same size, or one must be scalar');
    end
end

% performs test
b = abs(dot(v1, v2, 2)) < acc;
