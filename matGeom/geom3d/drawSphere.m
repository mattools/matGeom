function varargout = drawSphere(varargin)
%DRAWSPHERE Draw a sphere as a mesh.
%
%   drawSphere(SPHERE)
%   Where SPHERE = [XC YC ZC R], draw the sphere centered on the point with
%   coordinates [XC YC ZC] and with radius R, using a quad mesh.
%
%   drawSphere(CENTER, R)
%   Where CENTER = [XC YC ZC], specifies the center and the radius with two
%   arguments.
%
%   drawSphere(XC, YC, ZC, R)
%   Specifiy sphere center and radius as four arguments.
%
%   drawSphere(..., NAME, VALUE);
%   Specifies one or several options using parameter name-value pairs.
%   Available options are usual drawing options, as well as:
%   'nPhi'    the number of arcs used for drawing the meridians
%   'nTheta'  the number of circles used for drawing the parallels
%
%   H = drawSphere(...)
%   Return a handle to the graphical object created by the function.
%
%   [X Y Z] = drawSphere(...)
%   Return the coordinates of the vertices used by the sphere. In this
%   case, the sphere is not drawn.
%
%   Example
%   % Draw four spheres with different centers
%     figure(1); clf; hold on;
%     drawSphere([10 10 30 5]);
%     drawSphere([20 30 10 5]);
%     drawSphere([30 30 30 5]);
%     drawSphere([30 20 10 5]);
%     view([-30 20]); axis equal; l = light;
%
%   % Draw sphere with different settings
%     figure(1); clf;
%     drawSphere([10 20 30 10], 'linestyle', ':', 'facecolor', 'r');
%     axis([0 50 0 50 0 50]); axis equal;
%     l = light;
%
%   % The same, but changes style using graphic handle
%     figure(1); clf;
%     h = drawSphere([10 20 30 10]);
%     set(h, 'linestyle', ':');
%     set(h, 'facecolor', 'r');
%     axis([0 50 0 50 0 50]); axis equal;
%     l = light;
%   
%   % Draw a sphere with high resolution
%     figure(1); clf;
%     h = drawSphere([10 20 30 10], 'nPhi', 360, 'nTheta', 180);
%     l = light; view(3);
%
%
%   See also
%   spheres, circles3d, sphere, drawEllipsoid

%   ---------
%   author: David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 17/02/2005
%

%   HISTORY
%   2006-05-19 use centered sphere with radius 1 when no input specified
%   2007-01-04 typo
%   2010-11-08 code cleanup, add doc

% Check if axes handle is specified
if numel(varargin{1}) == 1 && ishghandle(varargin{1}, 'axes')
    hAx = varargin{1};
    varargin(1)=[];
else
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
    % no input: assumes unit sphere
    xc = 0;	yc = 0; zc = 0;
    r = 1;
    
elseif length(varargin) == 1
    % one argument: concatenates center and radius
    sphere = varargin{1};
    xc = sphere(:,1);
    yc = sphere(:,2);
    zc = sphere(:,3);
    r  = sphere(:,4);
    
elseif length(varargin) == 2
    % two arguments, corresponding to center and radius
    center = varargin{1};
    xc = center(1);
    yc = center(2);
    zc = center(3);
    r  = varargin{2};
    
elseif length(varargin) == 4
    % four arguments, corresponding to XC, YX, ZC and R
    xc = varargin{1};
    yc = varargin{2};
    zc = varargin{3};
    r  = varargin{4};
else
    error('drawSphere: please specify center and radius');
end

% number of meridians
nPhi    = 32;
ind = find(strcmpi('nPhi', options(1:2:end)));
if ~isempty(ind)
    ind = ind(1);
    nPhi = options{2*ind};
    options(2*ind-1:2*ind) = [];
end
    
% number of parallels
nTheta  = 16;
ind = find(strcmpi('nTheta', options(1:2:end)));
if ~isempty(ind)
    ind = ind(1);
    nTheta = options{2*ind};
    options(2*ind-1:2*ind) = [];
end

% compute spherical coordinates
theta   = linspace(0, pi, nTheta+1);
phi     = linspace(0, 2*pi, nPhi+1);

% convert to cartesian coordinates
sintheta = sin(theta);
x = xc + cos(phi')*sintheta*r;
y = yc + sin(phi')*sintheta*r;
z = zc + ones(length(phi),1)*cos(theta)*r;

% Process output
if nargout == 0
    % no output: draw the sphere
    surf(hAx, x, y, z, options{:});
    
elseif nargout == 1
    % one output: compute 
    varargout{1} = surf(hAx, x, y, z, options{:});
    
elseif nargout == 3
    varargout{1} = x; 
    varargout{2} = y; 
    varargout{3} = z; 
end

