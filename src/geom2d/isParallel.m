function b = isParallel(v1, v2, varargin)
%ISPARALLEL  check parallelism of two vectors
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
%   18/09/2007 copy from isParallel3d, adapt to any dimension, and add psb
%       to specify precision
%   16/01/2007 fix bug
%   21/09/2009 fix bug for array of 3 vectors


% default accuracy
acc = 1e-14;
if ~isempty(varargin)
    acc = abs(varargin{1});
end

% adds a zero at the end of vectors
v1(1,3) = 0;
v2(1,3) = 0;

% adapt size of inputs
if size(v1, 1)==1 && size(v2, 1)>1
    v1 = repmat(v1, [size(v2, 1) 1]);
end
if size(v2, 1)==1 && size(v1, 1)>1
    v2 = repmat(v2, [size(v1, 1) 1]);
end

% performs computation
b = vectorNorm(cross(v1, v2, 2))<acc;
