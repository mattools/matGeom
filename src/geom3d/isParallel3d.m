function b = isParallel3d(v1, v2, varargin)
%ISPARALLEL3D  check parallelism of two vectors
%
%   B = isParallel3d(V1, V2)
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
%   Example
%   isParallel3d([1 2 1], [2 4 2])
%   % returns 1
%   isParallel3d([1 2 1], [1 3 2])
%   % returns 0
%
%   See also
%   vectors3d, isPerpendicular3d
%
% ------
% Author: David Legland
% e-mail: david.legland@jouy.inra.fr
% Created: 2006-04-25
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

% ensure inputs have same size
if size(v1, 1)==1 && size(v2, 1)>1
    v1 = repmat(v1, [size(v2, 1) 1]);
end
if size(v2, 1)==1 && size(v1, 1)>1
    v2 = repmat(v2, [size(v1, 1) 1]);
end

% check if tolerance is specified
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% compute
b = vectorNorm3d(cross(v1, v2))<tol;
