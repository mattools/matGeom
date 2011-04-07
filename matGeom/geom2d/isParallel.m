function b = isParallel(v1, v2, varargin)
%ISPARALLEL Check parallelism of two vectors
%
%   B = isParallel(V1, V2)
%   where V1 and V2 are 2 row vectors of length Nd, Nd being the dimension, 
%   returns 1 if the vectors are parallel, and 0 otherwise.
%
%   Also works when V1 and V2 are two [NxNd] arrays with same number of
%   rows. In this case, return a [Nx1] array containing 1 at the positions
%   of parallel vectors.
%
%   Also works when one of V1 or V2 is scalar and the other one is [NxNd]
%   array, in this case return [Nx1] results.
%
%   B = isParallel(V1, V2, ACCURACY)
%   specifies the accuracy of numerical computation. Default value is 1e-14.
%   
%
%   Example
%   isParallel([1 2], [2 4])
%   % returns 1
%   isParallel([1 2], [1 3])
%   % returns 0
%
%   See also
%   vectors2d, isPerpendicular, lines2d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2006-04-25
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

%   HISTORY
%   2007-09-18 copy from isParallel3d, adapt to any dimension, and add psb
%       to specify precision
%   2007-01-16 fix bug
%   2009-09-21 fix bug for array of 3 vectors
%   2011-01-20 replace repmat by ones-indexing (faster)


% default accuracy
acc = 1e-14;
if ~isempty(varargin)
    acc = abs(varargin{1});
end

% adds a zero at the end of 2D vectors
if size(v1, 2) < 3
    v1(1,3) = 0;
end
if size(v2, 2) < 3
    v2(1,3) = 0;
end

% adapt size of inputs
n1 = size(v1, 1);
n2 = size(v2, 1);
if n1==1 && n2>1
    v1 = v1(ones(n2,1), :);
end
if n2==1 && n1>1
    v2 = v2(ones(n1,1), :);
end

% performs computation
b = vectorNorm(cross(v1, v2, 2)) < acc;
