function theta = angle2Points(varargin)
%ANGLE2POINTS Compute horizontal angle between 2 points
%
%   ALPHA = angle2Points(P1, P2),
%   Pi are either [1*2] arrays, or [N*2] arrays, in this case ALPHA is a 
%   [N*1] array. The angle computed is the horizontal angle of the line 
%   (P1 P2)
%   Result is always given in radians, between 0 and 2*pi.
%
%   See Also:
%   points2d, angles2d, angle3points, normalizeAngle, vectorAngle
%
%
% ---------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% created the 02/03/2007.
% Copyright 2010 INRA - Cepia Software Platform.

%   HISTORY:
%   2011-01-11 use bsxfun

% process input arguments
if length(varargin)==2
    p1 = varargin{1};
    p2 = varargin{2};
elseif length(varargin)==1
    var = varargin{1};
    p1 = var(1,:);
    p2 = var(2,:);
end    

% ensure data have correct size
n1 = size(p1, 1);
n2 = size(p2, 1);
if n1~=n2 && min(n1, n2)>1
    error('angle2Points: wrong size for inputs');
end

% angle of line (P2 P1), between 0 and 2*pi.
dp = bsxfun(@minus, p2, p1);
theta = mod(atan2(dp(:,2), dp(:,1)) + 2*pi, 2*pi);

