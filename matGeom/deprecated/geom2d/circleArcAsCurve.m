function varargout = circleArcAsCurve(arc, N)
%CIRCLEARCASCURVE Convert a circle arc into a series of points.
%
%   deprecated: replaced by circleArcToPolyline
%

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2006-05-22
% Copyright 2006 INRA - Cepia Software Platform

warning('matGeom:deprecated', ...
    'function "circleArcAsCurve" is deprecated, use "circleArcToPolygon" instead');

% format output
if nargout <= 1
    varargout = {circleArcToPolyline(arc, N)};
else
    [x, y] = circleArcToPolyline(arc, N);
    varargout = {x, y};
end
