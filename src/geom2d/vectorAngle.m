function alpha = vectorAngle(v, varargin)
%VECTORANGLE Compute angle of a vector with horizontal axis
%
%   A = vectorAngle(V);
%   Returns angle between Ox axis and vector direction, in Counter
%   clockwise orientation.
%   The result is normalised between 0 and 2*PI.
%
%   A = vectorAngle(V, CENTER);
%   Specifies convention for angle interval. CENTER is the center of the
%   2*PI interval containing the result. See <a href="matlab:doc
%   ('normalizeAngle')">normalizeAngle</a> for details.
%
%   Example:
%   rad2deg(vectorAngle([2 2]))
%   ans =
%       45
%   rad2deg(vectorAngle([1 sqrt(3)]))
%   ans =
%       60
%   rad2deg(vectorAngle([0 -1]))
%   ans =
%       270
%        
%   See also:
%   vectors2d, angles2d, normalizeAngle
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-10-18
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

%   HISTORY
%   2010-04-16 add psb to specify center interval


% defines center of angle interval
center = pi;
if ~isempty(varargin)
    center = varargin{1};
end

% compute angle and format result in a 2*pi interval
alpha = normalizeAngle(atan2(v(:,2), v(:,1))+2*pi, center);
