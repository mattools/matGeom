function len = polygonLength(varargin)
%POLYGONLENGTH Compute the perimeter of a polygon
%
%   L = polygonLength(POLYGON);
%   Computes the length of the boundary of a polygon. POLYGON is given by a
%   N*2 array of vertices.
%
%   See also:
%   polygons2d, polygonCentroid, polygonArea, drawPolygon, polylineLength
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 11/05/2005.
%

%   HISTORY
%   2011-03-31 add control for empty polygons, code cleanup

% If first argument is a cell array, this is a multi-polygon, and we simply
% add the lengths of individual polygons
if iscell(varargin{1})
    var = varargin{1};
    len = 0;
    for i=1:length(var)
        len = len + polygonLength(var{i});
    end
end

% Extract X and Y coordinates
if nargin == 1
    px = var(:,1);
    py = var(:,2);
    
elseif nargin == 2
    px = varargin{1};
    py = varargin{2};
end

% check there are enough points
if size(poly, 1) < 2
    len = 0;
    return;
end

% ensure last point is the same as first one
N = length(px);
dx = px([2:N 1]) - px(1:N);
dy = py([2:N 1]) - py(1:N);

% compute length
len = sum(hypot(dx, dy));

