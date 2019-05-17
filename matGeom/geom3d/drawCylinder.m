function varargout = drawCylinder(cyl, varargin)
%DRAWCYLINDER Draw a cylinder.
%
%   drawCylinder(CYL)
%   where CYL is a cylinder defined by [x1 y1 z1 x2 y2 z2 r]:
%   [x1 y2 z1] are coordinates of starting point, [x2 y2 z2] are
%   coordinates of ending point, and R is the radius of the cylinder,
%   draws the corresponding cylinder on the current axis.
%
%   drawCylinder(CYL, N)
%   uses N points for discretisation of angle. Default value is 32.
%
%   drawCylinder(..., OPT)
%   with OPT = 'open' (default) or 'closed', specify if bases of the
%   cylinder should be drawn.
%
%   drawCylinder(..., 'FaceColor', COLOR)
%   Specifies the color of the cylinder. Any couple of parameters name and
%   value can be given as argument, and will be transfered to the 'surf'
%   matlab function
%
%   drawCylinder(..., 'FaceAlpha', ALPHA)
%   Specifies the transparency of the cylinder and of the optionnal caps.
%
%   H = drawCylinder(...)
%   returns a handle to the patch representing the cylinder.
%
%
%   Example:
%   figure;drawCylinder([0 0 0 10 20 30 5]);
%
%   figure;drawCylinder([0 0 0 10 20 30 5], 'open');
%
%   figure;drawCylinder([0 0 0 10 20 30 5], 'FaceColor', 'r');
%
%   figure;
%   h = drawCylinder([0 0 0 10 20 30 5]);
%   set(h, 'facecolor', 'b');
%
%   % Draw three mutually intersecting cylinders
%     p0 = [30 30 30];
%     p1 = [90 30 30];
%     p2 = [30 90 30];
%     p3 = [30 30 90];
%     figure;
%     drawCylinder([p0 p1 25], 'FaceColor', 'r');
%     hold on
%     drawCylinder([p0 p2 25], 'FaceColor', 'g');
%     drawCylinder([p0 p3 25], 'FaceColor', 'b');
%     axis equal
%     set(gcf, 'renderer', 'opengl')
%     view([60 30])
%
%   See Also:
%   cylinderMesh, drawEllipseCylinder, drawSphere, drawLine3d, surf
%   intersectLineCylinder, cylinderSurfaceArea
%

%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 17/09/2005
%

%   HISTORY
%   2006/12/14 bug for coordinate conversion, vectorize transforms
%   04/01/2007 better input processing, manage end caps of cylinder
%   19/06/2009 use function localToGlobal3d, add docs
%   2011-06-29 use sph2cart2d, code cleanup
%   2018-01-02 add transparency managements


%% Input argument processing

if iscell(cyl)
    res = zeros(length(cyl), 1);
    for i = 1:length(cyl)
        res(i) = drawCylinder(cyl{i}, varargin{:});
    end
    
    if nargout > 0
        varargout{1} = res;
    end    
    return;
end

% default values
N = 128;
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

faceColor = 'g';
ind = find(strcmpi(varargin, 'facecolor'), 1, 'last');
if ~isempty(ind)
    faceColor = varargin{ind+1};
    varargin(ind:ind+1) = [];
end

% extract transparency
alpha = 1;
ind = find(strcmpi(varargin, 'faceAlpha'), 1, 'last');
if ~isempty(ind)
    alpha = varargin{ind+1};
    varargin(ind:ind+1) = [];
end

% add default drawing options
varargin = [{'FaceColor', faceColor, 'edgeColor', 'none', 'FaceAlpha', alpha} varargin];


%% Computation of mesh coordinates

% extreme points of cylinder
p1 = cyl(1:3);
p2 = cyl(4:6);

% radius of cylinder
r = cyl(7);

% compute orientation angle of cylinder
[theta, phi, rho] = cart2sph2d(p2 - p1);
dphi = linspace(0, 2*pi, N+1);

% generate a cylinder oriented upwards
x = repmat(cos(dphi) * r, [2 1]);
y = repmat(sin(dphi) * r, [2 1]);
z = repmat([0 ; rho], [1 length(dphi)]);

% transform points 
trans   = localToGlobal3d(p1, theta, phi, 0);
pts     = transformPoint3d([x(:) y(:) z(:)], trans);

% reshape transformed points
x2 = reshape(pts(:,1), size(x));
y2 = reshape(pts(:,2), size(x));
z2 = reshape(pts(:,3), size(x));


%% Display cylinder mesh

% plot the cylinder as a surface
hSurf = surf(x2, y2, z2, varargin{:});

% eventually plot the ends of the cylinder
if closed
    patch(x2(1,:)', y2(1,:)', z2(1,:)', faceColor, 'edgeColor', 'none', 'FaceAlpha', alpha);
    patch(x2(2,:)', y2(2,:)', z2(2,:)', faceColor, 'edgeColor', 'none', 'FaceAlpha', alpha);
end

% format ouptut
if nargout == 1
    varargout{1} = hSurf;
end
