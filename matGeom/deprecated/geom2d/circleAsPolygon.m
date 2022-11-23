function varargout = circleAsPolygon(circle, varargin)
%CIRCLEASPOLYGON Convert a circle into a series of points.
%
%   Note: this function is deprecated, use "circleToPolygon" instead
%
%   P = circleAsPolygon(CIRCLE, N);
%   convert circle given as [x0 y0 r], where x0 and y0 are coordinate of
%   center, and r is the radius, into an array of  [(N+1)x2] double, 
%   containing x and y values of points. 
%   The polygon is closed
%
%   P = circleAsPolygon(CIRCLE);
%   uses a default value of N=64 points
%
%   Example
%   circle = circleAsPolygon([10 0 5], 16);
%   figure;
%   drawPolygon(circle);
%
%   See also:
%   circles2d, circleToPolygon
%

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2005-04-06
% Copyright 2005 INRA - Cepia Software Platform

warning('matGeom:deprecated', ...
    'function "circleAsPolygon" is deprecated, use "circleToPolygon" instead');

% format output
if nargout <= 1
    varargout = {circleToPolygon(circle, varargin{:})};
else
    [x, y] = circleToPolygon(circle, varargin{:});
    varargout = {x, y};
end
