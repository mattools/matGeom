function b = isPerpendicular(v1, v2, varargin)
%ISPERPENDICULAR  check orthogonality of two vectors
%
%   B = isPerpendicular(V1, V2)
%   where V1 and V2 are 2 [1x3] arrays, returns 1 if the vectors are
%   parallels, and 0 otherwise.
%
%   Also works when V1 and V2 are two [Nx3] arrays with same number of
%   rows. In this case, return a [Nx1] array containing 1 at the positions
%   of parallel vectors.
%
%   Also works when one of V1 or V2 is scalar and the other one is [Nx3]
%   array, in this case return [Nx1] results.
%
%   B = isPerpendicular(V1, V2, ACCURACY)
%   specifies accuracy of numerical tests, default is 1e-14.
%
%
%   Example
%   isPerpendicular([1 2 1], [2 4 2])
%   % returns 1
%   isPerpendicular([1 2 1], [1 3 2])
%   % returns 0
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
%   18/09/2007 copy from isPerpendicular, adapt to any dimension, and add
%       psb to specify precision
%   21/09/2009 fix bug for array of 3 vectors

% default accuracy
acc = 1e-14;
if ~isempty(varargin)
    acc = abs(varargin{1});
end

% adapt size of inputs
if size(v1, 1)==1 && size(v2, 1)>1
    v1 = repmat(v1, [size(v2, 1) 1]);
end
if size(v2, 1)==1 && size(v1, 1)>1
    v2 = repmat(v2, [size(v1, 1) 1]);
end

% performs test
b = abs(dot(v1, v2, 2))<acc;
