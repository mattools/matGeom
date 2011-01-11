function varargout = angleSort(pts, varargin)
%ANGLESORT Sort points in the plane according to their angle to origin
%
%
%   PTS2 = angleSort(PTS);
%   Computes angle of points with origin, and sort points with increasing
%   angles in Counter-Clockwise direction.
%
%   PTS2 = angleSort(PTS, PTS0);
%   Computes angles between each point of PTS and PT0, which can be
%   different from origin.
%
%   PTS2 = angleSort(..., THETA0);
%   Specifies the starting angle for sorting.
%
%   [PTS2, I] = angleSort(...);
%   Also returns in I the indices of PTS, such that PTS2 = PTS(I, :);
%
%   See Also:
%   points2d, angles2d, angle2points, normalizeAngle
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2005-11-24
% Copyright 2010 INRA - Cepia Software Platform.


%   HISTORY :

% default values
pt0 = [0 0];
theta0 = 0;

if length(varargin)==1
    var = varargin{1};
    if size(var, 2)==1
        % specify angle
        theta0 = var;
    else
        pt0 = var;
    end
elseif length(varargin)==2
    pt0 = varargin{1};
    theta0 = varargin{2};
end


n = size(pts, 1);
pts2 = pts - repmat(pt0, [n 1]);
angle = lineAngle([zeros(n, 2) pts2]);
angle = mod(angle - theta0 + 2*pi, 2*pi);

[dummy, I] = sort(angle);

% format output
if nargout<2
    varargout{1} = pts(I, :);
elseif nargout==2
    varargout{1} = pts(I, :);
    varargout{2} = I;
end

        