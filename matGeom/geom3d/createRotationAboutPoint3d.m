function TFM = createRotationAboutPoint3d(ROT, point)
%ROTATIONABOUTPOINT3D Rotate about a point using a given rotation matrix.
%
%   TFM = rotationAboutPoint3d(ROT, POINT); Returns the transformation 
%   matrix corresponding to a translation(-POINT), rotation with ROT and 
%   translation(POINT). Ignores a possible translation in ROT(1:3,4).
%
%   See also:
%   transforms3d, transformPoint3d, createRotationOx, createRotationOy, 
%   createRotationOz, createRotation3dLineAngle, createRotationVector3d,
%   createRotationVectorPoint3d
%
% ---------
% Author: oqilipo
% Created: 2021-01-31
% Copyright 2021

% Extract only the rotation
ROT = [ROT(1:3,1:3), [0 0 0]'; [0 0 0 1]];

TFM = createTranslation3d(point) * ROT * createTranslation3d(-point);

end
    

