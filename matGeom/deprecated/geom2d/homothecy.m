function trans = homothecy(point, ratio)
%HOMOTHECY create a homothecy as an affine transform.
%
%   TRANS = homothecy(POINT, K);
%   POINT is the center of the homothecy, K is its factor.
%
%   See also:
%   transforms2d, transformPoint, createTranslation

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2005-01-20
% Copyright 2005 INRA - TPV URPOI - BIA IMASTE

% deprecation warning
warning('geom2d:deprecated', ...
    '''homothecy'' is deprecated, use ''createHomothecy'' instead');

% call current implementation
trans = createHomothecy(point, ratio);
