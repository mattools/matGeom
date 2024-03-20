function transforms3d(varargin)
%TRANSFORMS3D  Conventions for manipulating 3D affine transforms.
%
%   By 'transform' we mean an affine transform. A 3D affine transform
%   is represented by a 4*4 matrix. The last row of the matrix is equal to
%   [0 0 0 1].
%
%   
%
%   Example:
%   % create a translation by the vector [10 20 30]:
%   T = createTranslation3d([10 20 30]);
%   % Transform a basic point:
%   PT1 = [4 5 6];
%   PT2 = transformPoint3d(PT1, T)
%   % returns:
%   PT2 = 
%       14   25   36
%
%   See also 
%   composeTransforms3d, createBasisTransform3d, createRotation3dLineAngle,
%   createRotationAboutPoint3d, createRotationOx, createRotationOy, 
%   createRotationOz, createRotationVector3d, createRotationVectorPoint3d, 
%   createScaling3d, createTranslation3d, eulerAnglesToRotation3d, 
%   fitAffineTransform3d, isTransform3d, recenterTransform3d, 
%   rotation3dAxisAndAngle, rotation3dToEulerAngles
%   transformCircle3d, transformLine3d, transformPlane3d, transformPoint3d, 
%   transformPolygon3d, transformVector3d
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2008-10-13, using Matlab 7.4.0.287 (R2007a)
% Copyright 2008-2023 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas
