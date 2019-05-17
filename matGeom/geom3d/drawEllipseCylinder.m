function varargout = drawEllipseCylinder(cyl, varargin)
%DRAWELLIPSECYLINDER Draw a cylinder with ellipse cross-section.
%
%   drawEllipseCylinder(CYL)
%   draws the cylinder CYL on the current axis.
%   CYL is a cylinder defined by [x1 y1 z1 x2 y2 z2 r1 r2 roll], with:
%   * [x1 y2 z1] are coordinates of starting point,
%   * [x2 y2 z2] are coordinates of ending point, 
%   * R1 and R2 are the lengths of the ellipse semi axes, and
%   * ROLL is the rotation of the cylinder around its main axis (in
%      degrees)
%
%   drawEllipseCylinder(CYL, N)
%   uses N points for discretisation of angle. Default value is 32.
%
%   drawEllipseCylinder(..., OPT)
%   with OPT = 'open' (default) or 'closed', specify if bases of the
%   cylinder should be drawn.
%
%   drawEllipseCylinder(..., 'FaceColor', COLOR)
%   Specifies the color of the cylinder. Any couple of parameters name and
%   value can be given as argument, and will be transfered to the 'surf'
%   matlab function
%
%   H = drawEllipseCylinder(...)
%   returns a handle to the patch representing the cylinder.
%
%
%   Example:
%   figure;drawEllipseCylinder([0 0 0 10 20 30 5]);
%
%   figure;drawEllipseCylinder([0 0 0 10 20 30 5], 'open');
%
%   figure;drawEllipseCylinder([0 0 0 10 20 30 5], 'FaceColor', 'r');
%
%   figure;
%   h = drawEllipseCylinder([0 0 0 10 20 30 5]);
%   set(h, 'facecolor', 'b');
%
%   % Draw three mutually intersecting elliptic cylinders
%     p1 = [30 0 0];
%     p2 = [0 30 0];
%     p3 = [0 0 30];
%     radii = [20 10];
%     figure;
%     drawEllipseCylinder([-p1 p1 radii 0], 'FaceColor', 'r');
%     hold on
%     drawEllipseCylinder([-p2 p2 radii 90], 'FaceColor', 'g');
%     drawEllipseCylinder([-p3 p3 radii 90], 'FaceColor', 'b');
%     axis equal
%     set(gcf, 'renderer', 'opengl')
%     view([60 30]); light;
%
%   See Also:
%   drawCylinder, drawSphere, cylinderMesh, drawLine3d, surf

%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 27/02/2014


%   HISTORY


%% Input argument processing

if iscell(cyl)
    res = zeros(length(cyl), 1);
    for i = 1:length(cyl)
        res(i) = drawEllipseCylinder(cyl{i}, varargin{:});
    end
    
    if nargout > 0
        varargout{1} = res;
    end    
    return;
end

% default values
N = 32;
closed = true;

% check number of discretization steps
if ~isempty(varargin)
    var = varargin{1};
    if isnumeric(var)
        N = var;
        varargin = varargin(2:end);
    end
end

% check if cylinder must be closed or open
if ~isempty(varargin)
    var = varargin{1};
    if ischar(var)
        if strncmpi(var, 'open', 4)
            closed = false;
            varargin = varargin(2:end);
        elseif strncmpi(var, 'closed', 5)
            closed = true;
            varargin = varargin(2:end);
        end
    end
end


%% Computation of mesh coordinates

% extreme points of cylinder
p1 = cyl(1:3);
p2 = cyl(4:6);

% radius of cylinder
r1 = cyl(7);
r2 = cyl(8);
roll = 0;
if size(cyl, 2) > 8
    roll = cyl(9);
end

% compute orientation angle of cylinder (in degrees)
[theta, phi, rho] = cart2sph2d(p2 - p1);
dphi = linspace(0, 2*pi, N+1);

% generate a cylinder oriented upwards
x = repmat(cos(dphi) * r1, [2 1]);
y = repmat(sin(dphi) * r2, [2 1]);
z = repmat([0 ; rho], [1 length(dphi)]);

% transform points 
trans   = localToGlobal3d(p1, theta, phi, roll);
pts     = transformPoint3d([x(:) y(:) z(:)], trans);

% reshape transformed points
x2 = reshape(pts(:,1), size(x));
y2 = reshape(pts(:,2), size(x));
z2 = reshape(pts(:,3), size(x));


%% Display cylinder mesh

% add default drawing options
varargin = [{'FaceColor', 'g', 'edgeColor', 'none'} varargin];

% plot the cylinder as a surface
hSurf = surf(x2, y2, z2, varargin{:});

% eventually plot the ends of the cylinder
if closed
    ind = find(strcmpi(varargin, 'facecolor'), 1, 'last');
    if isempty(ind)
        color = 'k';
    else
        color = varargin{ind+1};
    end

    patch(x2(1,:)', y2(1,:)', z2(1,:)', color, 'edgeColor', 'none');
    patch(x2(2,:)', y2(2,:)', z2(2,:)', color, 'edgeColor', 'none');
end

% format ouptut
if nargout == 1
    varargout{1} = hSurf;
end
