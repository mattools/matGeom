function area = polygonArea(varargin)
%POLYGONAREA Compute the signed area of a polygon
%
%   A = polygonArea(POINTS);
%   Compute area of a polygon defined by POINTS. POINTS is a N-by-2 array
%   of double containing coordinates of vertices.
%   
%   Vertices of the polygon are supposed to be oriented Counter-Clockwise
%   (CCW). In this case, the signed area is positive.
%   If vertices are oriented Clockwise (CW), the signed area is negative.
%
%   If polygon is self-crossing, the result is undefined.
%
%   Examples
%     % compute area of a simple shape
%     poly = [10 10;30 10;30 20;10 20];
%     area = polygonArea(poly)
%     area = 
%         200
%
%     % compute area of CW polygon
%     area2 = polygonArea(poly(end:-1:1, :))
%     area2 = 
%         -200
%
%   References
%   algo adapted from P. Bourke web page
%   http://local.wasp.uwa.edu.au/~pbourke/geometry/polyarea/
%
%   See also :
%   polygons2d, polygonCentroid, drawPolygon, triangleArea
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 05/05/2004.
%

%   HISTORY
%   25/04/2005: add support for multiple polygons
%   12/10/2007: update doc

% in case of polygon sets, computes several areas
if nargin > 0
    var = varargin{1};
    if iscell(var)
        area = zeros(length(var), 1);
        for i = 1:length(var)
            area(i) = polygonArea(var{i}, varargin{2:end});
        end
        return;
    end
end

% extract coordinates
if nargin == 1
    var = varargin{1};
    px = var(:, 1);
    py = var(:, 2);
elseif nargin == 2
    px = varargin{1};
    py = varargin{2};
end

% indices of next vertices
N = length(px);
iNext = [2:N 1];

% compute area (vectorized version)
area = sum(px .* py(iNext) - px(iNext) .* py) / 2;
