function trans = homothecy(point, ratio)
%HOMOTHECY create a homothecy as an affine transform
%
%   TRANS = homothecy(POINT, K);
%   POINT is the center of the homothecy, K is its factor.
%
%   See also:
%   transforms2d, transformPoint, createTranslation
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 20/01/2005.
%

%   HISTORY
%   22/04/2009: copy to createHomothecy and deprecate

% deprecation warning
warning('geom2d:deprecated', ...
    '''homothecy'' is deprecated, use ''createHomothecy'' instead');

% call current implementation
trans = createHomothecy(point, ratio);
