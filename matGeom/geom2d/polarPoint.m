function point = polarPoint(varargin)
%POLARPOINT Create a point from polar coordinates (rho + theta)
%
%   POINT = polarPoint(RHO, THETA);
%   Creates a point using polar coordinate. THETA is angle with horizontal
%   (counted counter-clockwise, and in radians), and RHO is the distance to
%   origin.
%
%   POINT = polarPoint(THETA)
%   Specify angle, radius RHO is assumed to be 1.
%
%   POINT = polarPoint(POINT, RHO, THETA)
%   POINT = polarPoint(X0, Y0, RHO, THETA)
%   Adds the coordinate of the point to the coordinate of the specified
%   point. For example, creating a point with :
%     P = polarPoint([10 20], 30, pi/2);
%   will give a result of [40 20].
%   
%
%   See Also:
%   points2d
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 03/05/2004
%


% default values
x0 = 0; y0=0;
rho = 1;
theta =0;

% process input parameters
if length(varargin)==1
    theta = varargin{1};
elseif length(varargin)==2
    rho = varargin{1};
    theta = varargin{2};
elseif length(varargin)==3
    var = varargin{1};
    x0 = var(:,1);
    y0 = var(:,2);
    rho = varargin{2};
    theta = varargin{3};
elseif length(varargin)==4
    x0 = varargin{1};
    y0 = varargin{2};
    rho = varargin{3};
    theta = varargin{4};
end


point = [x0 + rho.*cos(theta) , y0+rho.*sin(theta)];
