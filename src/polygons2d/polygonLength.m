function len = polygonLength(varargin)
%POLYGONLENGTH compute perimeter of a polygon
%
%   L = polygonLength(POLYGON);
%   Computes the length of the boundary of a polygon. POLYGON is given by a
%   N*2 array of vertices.
%
%   See also:
%   polygons2d, polygonCentroid, polygonArea, drawPolygon
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 11/05/2005.
%


if nargin==1
    var = varargin{1};
    if iscell(var)
        len = 0;
        for i=1:length(var)
            len = len + polygonLength(var{i});
        end
        return;
    end
    
    px = var(:,1);
    py = var(:,2);
elseif nargin==2
    px = varargin{1};
    py = varargin{2};
end

N = length(px);
dx = px([2:N 1])-px(1:N);
dy = py([2:N 1])-py(1:N);
len = sum(sqrt(dx.*dx+dy.*dy));
   
