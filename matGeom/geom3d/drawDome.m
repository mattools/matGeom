function varargout = drawDome(varargin)
%DRAWDOME Draw a dome (half-sphere, semi-sphere) as a mesh.
%
%   drawDome(DOME)
%   Where DOME = [XC YC ZC R], draw the dome centered on the point with
%   coordinates [XC YC ZC] and with radius R, using a quad mesh.
% 
%   drawDome(Dome, V)
%   Where DOME = [XC YC ZC R] and V is a vector in the direction of the top
% 
%   drawDome(CENTER, R, V)
%   Where CENTER = [XC YC ZC], specifies the center and the radius with two
%   arguments and vector as third argument.
% 
%   drawdrawDome(XC, YC, ZC, R, V)
%   Specifiy dome center, radius and vector as five arguments.
%
%   drawDome(..., NAME, VALUE);
%   Specifies one or several options using parameter name-value pairs.
%   Available options are usual drawing options, as well as:
%   'nPhi'    the number of arcs used for drawing the meridians
%   'nTheta'  the number of circles used for drawing the parallels
%
%   H = drawDome(...)
%   Return a handle to the graphical object created by the function.
%
%   [X Y Z] = drawdrawDome(...)
%   Return the coordinates of the vertices used by the dome. In this
%   case, the dome is not drawn.
%
%   Example
%   % Draw four domes with different centers
%     figure(1); clf; hold on;
%     drawDome([0 0 1 1], 'FaceColor', 'b', 'EdgeColor', 'k', 'LineStyle', ':');
%     drawDome([0 1 0 1], [0 1 0]);
%     drawDome([0 -1 0 0.5], [1 0 0]);
%     drawDome([0 -5 4 10], 'FaceAlpha', 0.5, 'EdgeColor', 'r', 'LineStyle', '-');
%     view([-30 20]); axis equal; l = light;
%
%   % Draw dome with different settings
%     figure(1); clf;
%     drawDome([10 20 30 10], [0 0 1], 'linestyle', ':', 'facecolor', 'r');
%     axis([0 50 0 50 0 50]); axis equal;
%     l = light;
%
%   % The same, but changes style using graphic handle
%     figure(1); clf;
%     h = drawDome([10 20 30 10], [1 0 0]);
%     set(h, 'linestyle', ':');
%     set(h, 'facecolor', 'r');
%     axis([0 50 0 50 0 50]); axis equal;
%     l = light;
%   
%   % Draw a dome with high resolution
%     figure(1); clf;
%     h = drawDome([10 20 30 10], 'nPhi', 360, 'nTheta', 180);
%     l = light; view(3);
%
%
%   See also
%   drawSphere

%   ---------
%   author: Moritz Schappler
%   created the 27/07/2013
%

%   HISTORY
%   2013-07-27 initial version as copy of drawSphere with a few changes
%   2020-05-18 changes based on current version of geom3d

% Check if axes handle is specified
if isAxisHandle(varargin{1})
    hAx = varargin{1};
    varargin(1)=[];
elseif nargout ~= 3
    hAx = gca;
end

% process input options: when a string is found, assumes this is the
% beginning of options
options = {'FaceColor', 'g', 'LineStyle', 'none'};
for i = 1:length(varargin)
    if ischar(varargin{i})
        if length(varargin) == 1
            options = {'FaceColor', varargin{1}, 'LineStyle', 'none'};
        else
            options = [options(1:end) varargin(i:end)];
        end
        varargin = varargin(1:i-1);
        break;
    end
end

% Parse the input (try to extract center coordinates and radius)
if isempty(varargin)
    % no input: assumes unit dome
    xc = 0;	yc = 0; zc = 0;
    r = 1;
    v = [0;0;1]; 
elseif length(varargin) == 1
    % one argument: concatenates center and radius
    dome = varargin{1};
    xc = dome(:,1);
    yc = dome(:,2);
    zc = dome(:,3);
    r  = dome(:,4);
    v = [0;0;1]; 
elseif length(varargin) == 2
    % two arguments: concatenates center and radius with Rotation
    dome = varargin{1};
    xc = dome(:,1);
    yc = dome(:,2);
    zc = dome(:,3);
    r  = dome(:,4);
    v = varargin{2}; 
elseif length(varargin) == 3
    % three arguments, corresponding to center and radius and rotation
    center = varargin{1};
    xc = center(1);
    yc = center(2);
    zc = center(3);
    r  = varargin{2};
    v  = varargin{3};
elseif length(varargin) == 5
    % five arguments, corresponding to XC, YX, ZC, R and V
    xc = varargin{1};
    yc = varargin{2};
    zc = varargin{3};
    r  = varargin{4};
    v  = varargin{5};
else
    error('drawDome: please specify center and radius');
end

% Rotation given by z-Axis. Calculate rotation matrix
v = v(:) / norm(v(:));
if all(abs(v(:)-[0;0;1]) < 1e-10)
    RM = eye(3);
elseif all(abs(v(:) - [0;0;-1]) < 1e-10)
    RM = [[1;0;0], [0; -1; 0], [0; 0; -1]];
else
    % z-axis given by argument
    ez = v(:);
    % x-axis perpendicular
    ex = cross(ez, [0; 0; 1]); ex = ex/norm(ex);
    % y-axis to create right-handed coordinate system
    ey = cross(ez, ex);
    RM = [ex, ey, ez];
end

% number of meridians
nPhi = 32;
ind = find(strcmpi('nPhi', options(1:2:end)));
if ~isempty(ind)
    ind = ind(1);
    nPhi = options{2*ind};
    options(2*ind-1:2*ind) = [];
end
    
% number of parallels
nTheta  = 8;
ind = find(strcmpi('nTheta', options(1:2:end)));
if ~isempty(ind)
    ind = ind(1);
    nTheta = options{2*ind};
    options(2*ind-1:2*ind) = [];
end

% compute spherical coordinates
theta   = linspace(0, pi/2, nTheta+1);
phi     = linspace(0, 2*pi, nPhi+1);

% convert to Cartesian coordinates and rotate
% Rotate the Dome
x = zeros(nPhi+1, nTheta+1);
y = x;
z = x;

sintheta = sin(theta);
dx = cos(phi')*sintheta*r;
dy = sin(phi')*sintheta*r;
dz = ones(length(phi),1)*cos(theta)*r;

for i = 1:nPhi+1
    for j = 1:nTheta+1
        dxyz = RM*[dx(i, j);dy(i, j);dz(i, j)];
        x(i, j) = xc + dxyz(1);
        y(i, j) = yc + dxyz(2);    
        z(i, j) = zc + dxyz(3);   
    end
end

% Process output
if nargout == 0
    % no output: draw the dome
    surf(hAx, x, y, z, options{:});
    
elseif nargout == 1
    % one output: compute 
    varargout{1} = surf(hAx, x, y, z, options{:});
    
elseif nargout == 3
    varargout{1} = x; 
    varargout{2} = y; 
    varargout{3} = z; 
end
