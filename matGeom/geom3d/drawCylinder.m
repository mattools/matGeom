function varargout = drawCylinder(varargin)
% Draw a cylinder.
%
%   drawCylinder(CYL)
%   Draws the cylinder CYL on the current axis. 
%   CYL is a 1-by-7 row vector in the form [x1 y1 z1 x2 y2 z2 r] where:
%   * [x1 y1 z1] are the coordinates of starting point, 
%   * [x2 y2 z2] are the coordinates of ending point, 
%   * R is the radius of the cylinder
%
%   drawCylinder(CYL, N)
%   Uses N points for discretizating the circles of the cylinder. Default
%   value is 32. 
%
%   drawCylinder(..., OPT)
%   with OPT = 'open' (default) or 'closed', specify if the bases of the
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
%   drawCylinder(AX, ...)
%   Specifies the axis to draw on. AX should be a valid axis handle.
%
%   H = drawCylinder(...)
%   Returns a handle to the patch representing the cylinder.
%
%
%   Examples:
%   % basic example
%     figure; drawCylinder([0 0 0 10 20 30 5]);
%
%   % draw hollow cylinders
%     figure; drawCylinder([0 0 0 10 20 30 5], 'open');
%
%   % change cylinder color
%     figure; drawCylinder([0 0 0 10 20 30 5], 'FaceColor', 'r');
%
%   % change cylinder color using graphical handle
%     figure;
%     h = drawCylinder([0 0 0 10 20 30 5]);
%     set(h, 'facecolor', 'b');
%
%   % Draw three mutually intersecting cylinders
%     p0 = [10 10 10];
%     p1 = p0 + 80 * [1 0 0];
%     p2 = p0 + 80 * [0 1 0];
%     p3 = p0 + 80 * [0 0 1];
%     figure; axis equal; axis([0 100 0 100 0 100]); hold on
%     drawCylinder([p0 p1 10], 'FaceColor', 'r');
%     drawCylinder([p0 p2 10], 'FaceColor', 'g');
%     drawCylinder([p0 p3 10], 'FaceColor', 'b');
%     axis equal
%     set(gcf, 'renderer', 'opengl')
%     view([60 30]); light;
%
%   % draw cube skeleton
%     [v, e, f] = createCube;
%     figure; axis equal; axis([-0.2 1.2 -0.2 1.2 -0.2 1.2]); hold on; view(3);
%     cyls = [v(e(:,1), :) v(e(:,2),:) repmat(0.1, size(e, 1), 1)];
%     drawCylinder(cyls);
%     light
%
%   See Also:
%     cylinderMesh, drawEllipseCylinder, drawSphere, drawLine3d, surf
%     intersectLineCylinder, cylinderSurfaceArea
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

% parse axis handle
if numel(varargin{1}) == 1 && ishandle(varargin{1})
    hAx = varargin{1};
    varargin(1) = [];
else
    hAx = gca;
end

% input argument representing cylinders
cyl = varargin{1};
varargin(1) = [];

% process the case of multiple cylinders
if iscell(cyl)
    hCyls = gobjects(length(cyl), 1);
    for i = 1:length(cyl)
        hCyls(i) = drawCylinder(hAx, cyl{i}, varargin{:});
    end
    if nargout > 0
        varargout{1} = hCyls;
    end    
    return;
elseif size(cyl, 1) > 1
    hCyls = gobjects(size(cyl, 1), 1);
    for i = 1:size(cyl, 1)
        hCyls(i) = drawCylinder(hAx, cyl(i, :), varargin{:});
    end
    
    if nargout > 0
        varargout{1} = hCyls;
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

faceColor = 'g';
ind = find(strcmpi(varargin, 'FaceColor'), 1, 'last');
if ~isempty(ind)
    faceColor = varargin{ind+1};
    varargin(ind:ind+1) = [];
end

% extract transparency
alpha = 1;
ind = find(strcmpi(varargin, 'FaceAlpha'), 1, 'last');
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
hCyl(1) = surf(hAx, x2, y2, z2, varargin{:});

% eventually plot the ends of the cylinder
if closed
    hCyl(2)=patch(hAx, x2(1,:)', y2(1,:)', z2(1,:)', faceColor, 'edgeColor', 'none', 'FaceAlpha', alpha);
    hCyl(3)=patch(hAx, x2(2,:)', y2(2,:)', z2(2,:)', faceColor, 'edgeColor', 'none', 'FaceAlpha', alpha);
    gh = hggroup;
    set(hCyl,'Parent',gh)
    hCyl = gh;
end

% format ouptut
if nargout == 1
    varargout{1} = hCyl;
end
