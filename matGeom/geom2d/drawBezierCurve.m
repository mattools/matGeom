function varargout = drawBezierCurve(points, varargin)
%DRAWBEZIERCURVE Draw a cubic bezier curve defined by 4 control points
%
%   drawBezierCurve(POINTS)
%   Draw the Bezier curve defined by the 4 control points stored in POINTS.
%   POINTS is either a 4-by-2 array (vertical concatenation of control
%   points coordinates), or a 1-by-8 array (horizontal concatenation of
%   control point coordinates). 
%
%   drawBezierCurve(..., PARAM, VALUE)
%   Specifies additional drawing parameters, see the line function for
%   details.
%
%   drawBezierCurve(AX, ...);
%   Spcifies the handle of the axis to draw on.
%
%   H = drawBezierCurve(...);
%   Return a handle to the created graphic object.
%
%
%   Example
%     drawBezierCurve([0 0;5 10;10 5;10 0]);
%     drawBezierCurve([0 0;5 10;10 5;10 0], 'linewidth', 2, 'color', 'g');
%
%   See also
%     drawPolyline, cubicBezierToPolyline
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-03-16,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

%   HISTORY
%   2011-10-11 add management of axes handle

% extract handle of axis to draw on
if isAxisHandle(points)
    ax = points;
    points = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% default number of discretization steps
N = 64;

% check if discretization step is specified
if ~isempty(varargin)
    var = varargin{1};
    if length(var) == 1 && isnumeric(var)
        N = round(var);
        varargin(1) = [];
    end
end

% convert control coordinates to polyline
poly = cubicBezierToPolyline(points, N);

% draw the curve
h = drawPolyline(ax, poly, varargin{:});

% eventually return a handle to the created object
if nargout > 0
    varargout = {h};
end
