function alpha = formatAngle(alpha)
%FORMATANGLE  Ensure an angle value is comprised between 0 and 2*PI
%   ALPHA2 = formatAngle(ALPHA)
%   ALPHA2 is the same as ALPHA modulo 2*PI and is positive.
%
%   Example:
%   formatAngle(5*pi)
%   ans =
%       3.1416
%
%   See also
%   vectorAngle, lineAngle
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2008-03-10,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% HISTORY
% 2010-03-31 deprecate and replace by function 'normalizeAngle'

% deprecation warning
warning('geom2d:deprecated', ...
    '''formatAngle'' is deprecated, use ''normalizeAngle'' instead');

alpha = mod(alpha, 2*pi);
alpha(alpha<0) = 2*pi + alpha(alpha<0);
