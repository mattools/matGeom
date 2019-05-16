function sphere = createSphere(varargin)
%CREATESPHERE Create a sphere containing 4 points.
%
%   s = createSphere(p1, p2, p3, p4);
%   return in s the sphere common to the 4 pointsp1, p2, p3 and p4.
%
%   Ref: P. Bourke
%   http://astronomy.swin.edu.au/~pbourke/geometry/spherefrom4/
%
%   See also
%   spheres, circles3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 22/03/2005.
%


if length(varargin)==4
    pts = [varargin{1};varargin{2};varargin{3};varargin{4}];
elseif length(varargin)==1
    pts = varargin{1};
else
    error('wrong number of arguments in createSphere');
end


m1 = det([pts ones(4,1)]);
s2 = sum(pts.*pts, 2);
m2 = det([s2 pts(:,2) pts(:,3) ones(4,1)]);
m3 = det([pts(:,1) s2 pts(:,3) ones(4,1)]);
m4 = det([pts(:,1) pts(:,2) s2 ones(4,1)]);

m5 = det([s2 pts]);

x0 = m2*.5/m1;
y0 = m3*.5/m1;
z0 = m4*.5/m1;
r  = sqrt(x0*x0 + y0*y0 + z0*z0 - m5/m1);

sphere = [x0 y0 z0 r];
