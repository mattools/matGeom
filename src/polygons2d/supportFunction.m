function h = supportFunction(polygon, varargin)
%SUPPORTFUNCTION Compute support function of a polygon
% 
%   H = supportFunction(POLYGON, N)
%   uses N points for suport function approximation
%
%   H = supportFunction(POLYGON)
%   assume 24 points for approximation
%
%   H = supportFunction(POLYGON, V)
%   where V is a vector, uses vector V of angles to compute support
%   function.
%   
%   See also:
%   polygons2d, convexification
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 20/12/2004.
%

N = 24;
u = 0:2*pi/N:2*pi*(1-1/N);
    
if length(varargin)==1
    var = varargin{1};
    if length(var)==1
        N = var;
        u = 0:2*pi/N:2*pi*(1-1/N);
    else
        u = var;
    end
end

% ensure u vertical vector
if size(u, 1)==1
    u=u';
end


h = zeros(size(u));

for i=1:length(u)
    
    v = repmat([cos(u(i)) sin(u(i))], [size(polygon, 1), 1]);

    h(i) = max(dot(polygon, v, 2));
end
