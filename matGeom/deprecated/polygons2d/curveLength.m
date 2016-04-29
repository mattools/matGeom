function len = curveLength(varargin)
%CURVELENGTH return length of a curve (a list of points)
%
%   Compute the length of a curve given as a list of following points. 
%
%   L = curveLength(X, Y);
%   L = curveLength(POINTS);
%   POINTS should be a [NxD] array, with N being the numbe of points and D
%   the dimension of the points.
%
%   PT = curveLength(..., TYPE);
%   Specifies if the last point is connected to the first one. TYPE can be
%   either 'closed' or 'open'.
%
%   TODO : specify norm (euclidian, taxi, ...).
%
%   Example:
%   Compute the perimeter of a circle with radius 1
%   curveLength(circleAsPolygon([0 0 1], 500), 'closed')
%   -> return 6.2831
%
%   See also:
%   polygons2d, curveCentroid
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 14/06/2004
%

%   HISTORY
%   22/05/2006 manage any dimension for points, closed and open curves, 
%       and update doc accordingly.
%   30/06/2009 deprecate and replace by 'polylineLength'.

% deprecation warning
warning('geom2d:deprecated', ...
    '''curveLength'' is deprecated, use ''polylineLength'' instead');

% check whether the curve is closed
closed = false;
var = varargin{end};
if ischar(var)
    if strcmpi(var, 'closed')
        closed = true;
    end
    varargin = varargin(1:end-1);
end

% extract point coordinates
if length(varargin)==1
    points = varargin{1};
elseif length(varargin)==2
    points = [varargin{1} varargin{2}];
end

% compute lengths of each line segment
if closed
    len = sum(sqrt(sum(diff(points([1:end 1],:)).^2, 2)));
else
    len = sum(sqrt(sum(diff(points).^2, 2)));
end
