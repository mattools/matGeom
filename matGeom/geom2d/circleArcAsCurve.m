function varargout = circleArcAsCurve(arc, N)
%CIRCLEARCASCURVE Convert a circle arc into a series of points
%
%   deprecated: replaced by circleArcToPolyline
%
%
% ---------
% author : David Legland 
% created the 22/05/2006.
% Copyright 2010 INRA - Cepia Software Platform.
%

% HISTORY
% 2011-03-30 use angles in degrees, add default value for N
% 2011-12-09 deprecate


warning('matGeom:deprecated', ...
    'function "circleArcAsCurve" is deprecated, use "circleArcToPolygon" instead');

% format output
if nargout <= 1
    varargout = {circleArcToPolyline(arc, N)};
else
    [x y] = circleArcToPolyline(arc, N);
    varargout = {x, y};
end
