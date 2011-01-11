function res = isPointOnPolyline(point, poly, varargin)
%ISPOINTONPOLYLINE  check if a point belongs to a polyline
%
%   B = isPointOnPolyline(POINT, POLY)
%
%   Example
%       pt1 = [30 20];
%       pt2 = [30 10];
%       poly = [10 10;50 10;50 50;10 50];
%       isPointOnPolyline([pt1;pt2], poly)
%       ans =
%            0
%            1
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-19,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.


% extract computation tolerance
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% return true if distance is below a given threshold
res = distancePointPolyline(point, poly)<tol;
