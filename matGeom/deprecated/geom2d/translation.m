function trans = translation(varargin)
%TRANSLATION return 3*3 matrix of a translation.
%
%   TRANS = translation(DX, DY);
%   Returns the translation corresponding to DX and DY.
%   The returned matrix has the form :
%   [1 0 DX]
%   [0 1 DY]
%   [0 0  1]
%
%   TRANS = translation(POINT);
%   Returns the translation corresponding to the given point [x y].
%
%
%   See also:
%   transforms2d, transformPoint, rotation, scaling

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2004-04-06
% Copyright 2004 INRA - TPV URPOI - BIA IMASTE

% deprecation warning
warning('geom2d:deprecated', ...
    '''translation'' is deprecated, use ''createTranslation'' instead');

% call current implementation
trans = createTranslation(varargin{:});
