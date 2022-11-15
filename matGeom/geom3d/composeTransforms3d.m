function trans = composeTransforms3d(varargin)
%COMPOSETRANSFORMS3D Concatenate several space transformations.
%
%   TRANS = composeTransforms3d(TRANS1, TRANS2, ...);
%   Computes the affine transform equivalent to performing successively
%   TRANS1, TRANS2, ...
%   
%   Example:
%   PTS  = rand(20, 3);
%   ROT1 = createRotationOx(pi/3);
%   ROT2 = createRotationOy(pi/4);
%   ROT3 = createRotationOz(pi/5);
%   ROTS = composeTransforms3d(ROT1, ROT2, ROT3);
%   Then:
%   PTS2 = transformPoint3d(PTS, ROTS);
%   will give the same result as:
%   PTS3 = transformPoint3d(transformPoint3d(transformPoint3d(PTS, ...
%       ROT1), ROT2), ROT3);
%
%   See also:
%   transforms3d, transformPoint3d

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2006-09-29
% Copyright 2006 INRA - TPV URPOI - BIA IMASTE

trans = varargin{nargin};
for i=length(varargin)-1:-1:1
    trans = trans * varargin{i};
end
