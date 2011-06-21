function point = intersectLineSphere(line, sphere, varargin)
%INTERSECTLINESPHERE Return intersection points between a line and a sphere
%
%   GC = intersectLineSphere(LINE, SPHERE);
%   Returns the two points which are the intersection of the given line and
%   sphere. 
%   LINE   : [x0 y0 z0  dx dy dz]
%   SPHERE : [xc yc zc  R]
%   GC     : [x1 y1 z1 ; x2 y2 z2]
%   
%   See also
%   spheres, circles3d, intersectPlaneSphere
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

%   HISTORY
%   2011-06-21 bug for tangent lines, add tolerance

% check if user-defined tolerance is given
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% difference between centers
dc = line(1:3) - sphere(1:3);

% equation coefficients
a = sum(line(:, 4:6) .* line(:, 4:6), 2);
b = 2*sum(dc.*line(4:6), 2);
c = sum(dc.*dc, 2) - sphere(:,4).*sphere(:,4);

% solve equation
delta = b.*b - 4*a.*c;

if delta > tol
    % delta positive: find two roots of second order equation
    u1 = (-b -sqrt(delta)) / 2 / a;
    u2 = (-b +sqrt(delta)) / 2 / a;
    
    % convert into 3D coordinate
    point = [line(1:3)+u1*line(4:6) ; line(1:3)+u2*line(4:6)];

elseif abs(delta) < tol
    % delta around zero: find unique root, and convert to 3D coord.
    u = -b/2./a;    
    point = line(1:3) + u*line(4:6);
    
else
    % delta negative: no solution
    point = ones(2, 3);
    point(:) = NaN;
end
