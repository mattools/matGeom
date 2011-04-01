function res = isPointOnPolyline(point, poly, varargin)
%ISPOINTONPOLYLINE Test if a point belongs to a polyline
%
%   B = isPointOnPolyline(POINT, POLY)
%   Returns TRUE of the point POINT belong to the polyline defined by the
%   set of points in POLY.
%
%   B = isPointOnPolyline(POINT, POLY, TOL)
%   Specify the absolute tolerance for testing the distance between the
%   point and the polyline.
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
%   points2d, polygons2d
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
res = distancePointPolyline(point, poly) < tol;
