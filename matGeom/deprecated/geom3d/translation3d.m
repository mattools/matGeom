function trans = translation3d(varargin)
%TRANSLATION3D return 4x4 matrix of a 3D translation.
%
%   usage :
%   TRANS = translation3d(DX, DY, DZ);
%   return the translation corresponding to DX and DY.
%   The returned matrix has the form :
%   [1 0 0 DX]
%   [0 1 0 DY]
%   [0 0 1 DZ]
%   [0 0 0  1]
%
%   TRANS = translation3d(VECT);
%   return the translation corresponding to the given vector [x y z].
%
%
%   See also:
%   vectors3d, transforms3d, transformPoint, rotation

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2004-04-06
% Copyright 2004 INRA - TPV URPOI - BIA IMASTE

% deprecation warning
warning('geom3d:deprecated', ...
    [mfilename ' is deprecated, use ''createTranslation3d'' instead']);

% call current implementation
trans = createTranslation3d(varargin{:});
