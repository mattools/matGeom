function varargout = drawSphericalTriangle(sphere, p1, p2, p3, varargin)
%DRAWSPHERICALTRIANGLE Draw a triangle on a sphere
%
%   drawsphericaltriangle(SPHERE, PT1, PT2, PT3);
%
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 22/02/2005
%

%   HISTORY
%   27/06/2007 manage spheres other than origin
%   30/10/2008 replace intersectPlaneLine by intersectLinePlane

% extract data of the sphere
ori = sphere(:, 1:3);
r   = sphere(4);

% extract direction vectors for each point
v1  = normalizeVector3d(p1 - ori);
v2  = normalizeVector3d(p2 - ori);
v3  = normalizeVector3d(p3 - ori);

% create a plane tangent to the sphere containing first point
plane = createPlane(v1, v1);

% position on the plane of the direction vectors
pp2 = planePosition(intersectLinePlane([ori v2], plane), plane);
pp3 = planePosition(intersectLinePlane([ori v3], plane), plane);

% create rough parametrization with 2 variables
s  = 0:.2:1;
t  = 0:.2:1;
ns = length(s);
nt = length(t);
s  = repmat(s, [nt, 1]);
t  = repmat(t', [1, ns]);

% convert to plane coordinates
xp = s * pp2(1) + t .* (1-s) * pp3(1);
yp = s * pp2(2) + t .* (1-s) * pp3(2);

% convert to 3D coordinates (still on the 3D plane)
x  = plane(1) * ones(size(xp)) + plane(4) * xp + plane(7) * yp - ori(1);
y  = plane(2) * ones(size(xp)) + plane(5) * xp + plane(8) * yp - ori(2);
z  = plane(3) * ones(size(xp)) + plane(6) * xp + plane(9) * yp - ori(3);

% project on the sphere
norm = hypot(hypot(x, y), z);
xn = x ./ norm * r + ori(1);
yn = y ./ norm * r + ori(2);
zn = z ./ norm * r + ori(3);


if nargout == 0
    surf(xn, yn, zn, 'FaceColor', 'g', 'EdgeColor', 'none', varargin{:});
else
    varargout{1} = x;
    varargout{2} = y;
    varargout{3} = z;
end
