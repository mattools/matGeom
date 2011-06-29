function varargout = drawEllipsoid(varargin)
%DRAWELLIPSOID Draw a 3D ellipsoid
%
%   drawEllipsoid(ELLI)
%   Displays a 3D ellipsoid on current axis. ELLI is given by:
%   [XC YC ZC A B C PHI THETA PSI],
%   where (XC, YC, ZC) is the ellipsoid center, A, B and C are the half
%   lengths of the ellipsoid main axes, and PHI THETA PSI are Euler angles
%   representing ellipsoid orientation, in degrees.
%
%   Example
%   figure; hold on;
%   drawEllipsoid([10 20 30   50 30 10   5 10 0], 'FaceColor', 'g');
%   axis equal;
%
%   See also
%   spheres, drawSphere, inertiaEllipsoid, ellipsoid
%   drawTorus, drawCuboid 
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-03-12,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


% process input options: when a string is found, assumes this is the
% beginning of options
options = {'FaceColor', 'g', 'linestyle', 'none'};
for i = 1:length(varargin)
    if ischar(varargin{i})
        options = [options(1:end) varargin(i:end)];
        varargin = varargin(1:i-1);
        break;
    end
end

% default ellipsoid orientation
ellPhi   = 0;
ellTheta = 0;
ellPsi   = 0;

% Parse the input (try to extract center coordinates and radius)
if isempty(varargin)
    % no input: assumes ellipsoid with defualt shape
    xc = 0;	yc = 0; zc = 0;
    a = 5; b = 4; c = 3;
    
elseif length(varargin) == 1
    % one argument: concatenates center and radius
    elli = varargin{1};
    xc = elli(:,1);
    yc = elli(:,2);
    zc = elli(:,3);
    a  = elli(:,4);
    b  = elli(:,5);
    c  = elli(:,6);
    k = pi / 180;
    ellPhi   = elli(:,7) * k;
    ellTheta = elli(:,8) * k;
    ellPsi   = elli(:,9) * k;
    
elseif length(varargin) == 2
    % two arguments, corresponding to center and radius vector
    center = varargin{1};
    xc = center(:,1);
    yc = center(:,2);
    zc = center(:,3);
    r  = varargin{2};
    a  = r(:,1);
    b  = r(:,2);
    c  = r(:,3);
   
else
    error('drawEllipsoid: incorrect input arguments');
end

% number of meridians
nPhi    = 32;
ind = strmatch('nphi', lower(options(1:2:end)));
if ~isempty(ind)
    ind = ind(1);
    nPhi = options{2*ind};
    options(2*ind-1:2*ind) = [];
end
    
% number of parallels
nTheta  = 16;
ind = strmatch('ntheta', lower(options(1:2:end)));
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
x = cos(phi') * sintheta;
y = sin(phi') * sintheta;
z = ones(length(phi),1) * cos(theta);

% convert unit basis to ellipsoid basis
sca     = createScaling3d(a, b, c);
rotZ    = createRotationOz(ellPhi);
rotY    = createRotationOy(ellTheta);
rotX    = createRotationOx(ellPsi);
tra     = createTranslation3d([xc yc zc]);

% concatenate transforms
trans   = tra * rotZ * rotY * rotX * sca;

% transform mesh vertices
[x y z] = transformPoint3d(x, y, z, trans);

% Process output
if nargout == 0
    % no output: draw the ellipsoid
    surf(x, y, z, options{:});
    
elseif nargout == 1
    % one output: draw the ellipsoid and return handle 
    varargout{1} = surf(x, y, z, options{:});
    
elseif nargout == 3
    % 3 outputs: return computed coordinates
    varargout{1} = x; 
    varargout{2} = y; 
    varargout{3} = z; 
end

