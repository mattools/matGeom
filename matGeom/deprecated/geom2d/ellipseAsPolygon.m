function varargout = ellipseAsPolygon(ellipse, N)
%ELLIPSEASPOLYGON Convert an ellipse into a series of points.
%
%   Deprecated, use ellipseToPolygon instead.
%
%   P = ellipseAsPolygon(ELL, N);
%   converts ELL given as [x0 y0 a b] or [x0 y0 a b theta] into a polygon
%   with N edges. The result P is (N+1)-by-2 array containing coordinates
%   of the N+1 vertices of the polygon.
%   The resulting polygon is closed, i.e. the last point is the same as the
%   first one.
%
%   P = ellipseAsPolygon(ELL);
%   Use a default number of edges equal to 72. This result in one piont for
%   each 5 degrees.
%   
%   [X Y] = ellipseAsPolygon(...);
%   Return the coordinates o fvertices in two separate arrays.
%
%   See also:
%   ellipses2d, circleAsPolygon, rectAsPolygon, drawEllipse

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2005-04-06
% Copyright 2005 INRA - TPV URPOI - BIA IMASTE

warning('matGeom:deprecated', ...
    'function "ellipseAsCurve" is deprecated, use "ellipseToPolygon" instead');

% format output
if nargout <= 1
    varargout = {ellipseToPolygon(ellipse, N)};
else
    [x, y] = ellipseToPolygon(ellipse, N);
    varargout = {x, y};
end
