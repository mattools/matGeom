function alpha = normalizeAngle(alpha, varargin)
%NORMALIZEANGLE  Normalize an angle value within a 2*PI interval
%
%   ALPHA2 = normalizeAngle(ALPHA);
%   ALPHA2 is the same as ALPHA modulo 2*PI and is positive.
%
%   ALPHA2 = normalizeAngle(ALPHA, CENTER);
%   Specifies the center of the angle interval.
%   If CENTER==0, the interval is [-pi ; +pi]
%   If CENTER==PI, the interval is [0 ; 2*pi] (default).
%
%   Example:
%   % normalization between 0 and 2*pi (default)
%   normalizeAngle(5*pi)
%   ans =
%       3.1416
%
%   % normalization between -pi and +pi
%   normalizeAngle(7*pi/2, 0)
%   ans =
%       -1.5708
%
%   See also
%   vectorAngle, lineAngle
%
%   References
%   Follows the same convention as apache commons library, see:
%   http://commons.apache.org/math/api-2.2/org/apache/commons/math/util/MathUtils.html
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2008-03-10,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% HISTORY
% 2010-03-31 rename as normalizeAngle, and add psb to specify interval
%   center

center = pi;
if ~isempty(varargin)
    center = varargin{1};
end

alpha = mod(alpha-center+pi, 2*pi) + center-pi;
