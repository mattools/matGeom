function point = intersectLineSphere(line, sphere)
%INTERSECTLINESPHERE return intersection between a line and a sphere
%
%   GC = intersectLineSphere(LINE, SPHERE);
%   Returns the two points which are the intersection of the given line and
%   sphere. 
%   LINE   : [x0 y0 z0  dx dy dz]
%   SPHERE : [xc yc zc  R]
%   GC     : [x1 y1 z1 ; x2 y2 z2]
%   
%   See also
%   spheres, circles3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

%   HISTORY

% difference between centers
dc = line(1:3)-sphere(1:3);

a = sum(line(:, 4:6).*line(:, 4:6), 2);
b = 2*sum(dc.*line(4:6), 2);
c = sum(dc.*dc, 2) - sphere(:,4).*sphere(:,4);

delta = b.*b -4*a.*c;

if delta>1e-14
    % find two roots of second order equation
    u1 = (-b -sqrt(delta))/2/a;
    u2 = (-b +sqrt(delta))/2/a;
    
    % convert into 3D coordinate
    point = [line(1:3)+u1*line(4:6) ; line(1:3)+u2*line(4:6)];

elseif abs(delta) > 1e-14
    % find unique root, and convert to 3D coord.
    u = -b/2./a;    
    point = line(1:3) + u*line(4:6);
    
else
    point = zeros(0, 3);
    return;
end