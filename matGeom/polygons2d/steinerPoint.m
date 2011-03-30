function pt = steinerPoint(varargin)
%STEINERPOINT Compute steiner point (weighted centroid) of a polygon
%
%   PT = steinerPoint(POINTS);
%   PT = steinerPoint(PTX, PTY);
%   Computes steiner point of a polygon defined by POINTS. POINTS is a
%   [N*2] array of double.
%
%   The steiner point is computed the same way as the polygon centroid,
%   except that a weight depending on the angle is given to each vertex.
%
%   See also:
%   polygons2d, polygonArea, polygonCentroid, drawPolygon
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 11/11/2004.
%


if nargin==1
    var = varargin{1};
    px = var(:,1);
    py = var(:,2);
elseif nargin==2
    px = varargin{1};
    py = varargin{2};
end

% Algorithme P. Bourke
sx = 0;
sy = 0;
N = length(px);
for i=1:N-1
    sx = sx + (px(i)+px(i+1))*(px(i)*py(i+1) - px(i+1)*py(i));
    sy = sy + (py(i)+py(i+1))*(px(i)*py(i+1) - px(i+1)*py(i));
end
sx = sx + (px(N)+px(1))*(px(N)*py(1) - px(1)*py(N));
sy = sy + (py(N)+py(1))*(px(N)*py(1) - px(1)*py(N));

pt = [sx sy]/6/polygonArea(px, py);