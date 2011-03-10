function theta = vectorAngle3d(v1, v2)
%VECTORANGLE3D Angle between two 3D vectors
%
%   THETA = vectorAngle3d(V1, V2)
%   Computes the angle between the 2 3D vectors V1 and V2. The result THETA
%   is given in radians, between 0 and PI.
%
%
%   Example
%   % angle between 2 orthogonal vectors
%   vectorAngle3d([1 0 0], [0 1 0])
%   ans = 
%       1.5708
%
%   % angle between 2 parallel vectors
%   v0 = [3 4 5];
%   vectorAngle3d(3*v0, 5*v0)
%   ans = 
%       0
%
%   See also
%   vectors3d, vectorNorm3d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-10-04,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% number of vectors
n1 = size(v1, 1);
n2 = size(v2, 1);

% ensures inputs have same dimension
if n1~=n2
    if n1==1
        v1 = repmat(v1, [n2 1]);
    elseif n2==1
        v2 = repmat(v2, [n1 1]);
    else
        error('Arguments V1 and V2 must have the same size');
    end
end

% compute angle using arc-tangent to get better precision for angles near
% zero, see the discussion in: 
% http://www.mathworks.com/matlabcentral/newsreader/view_thread/151925#381952
theta = atan2(vectorNorm3d(cross(v1, v2, 2)), dot(v1, v2, 2));

% equivalent to:
% v1 = normalizeVector3d(v1);
% v2 = normalizeVector3d(v2);
% theta = acos(dot(v1, v2, 2));
