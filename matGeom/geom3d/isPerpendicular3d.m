function b = isPerpendicular3d(v1, v2, varargin)
%ISPERPENDICULAR3D Check orthogonality of two 3D vectors
%
%   B = isPerpendicular3d(V1, V2)
%   where V1 and V2 are two 1-by-3 arrays, returns 1 if the vectors are
%   orthogonal, and 0 otherwise.
%
%   Also works when V1 and V2 are two N-by-3 arrays with same number of
%   rows. In this case, return a N-by-1 array containing 1 at the positions
%   of orthogonal vectors.
%
%   Also works when one of V1 or V2 is 1-by-3 and the other one is N-by-3
%   array, in this case return N-by-1 results.
%
%   B = isPerpendicular3d(V1, V2, TOL)
%   Specifies the absolute tolerance (default is 1e-14).
%
%
%   Example
%   isPerpendicular3d([1 0 0], [0 1 0])
%   ans =
%       1
%
%   isPerpendicular3d([1 0 1], [1 0 0])
%   ans =
%       0
%
%   See also
%   vectors3d, isParallel3d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2006-04-25
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

% 2011.03.20 add support for tolerance, fix computation

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

% compute perpendicularity test
b = abs(dot(v1, v2, 2)) < tol;
