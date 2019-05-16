function varargout = drawEllipsoid(elli, varargin)
%DRAWELLIPSOID Draw a 3D ellipsoid.
%
%   drawEllipsoid(ELLI)
%   Displays a 3D ellipsoid on current axis. ELLI is given by:
%   [XC YC ZC A B C PHI THETA PSI],
%   where (XC, YC, ZC) is the ellipsoid center, A, B and C are the half
%   lengths of the ellipsoid main axes, and PHI THETA PSI are Euler angles
%   representing ellipsoid orientation, in degrees.
%
%   drawEllipsoid(..., 'drawEllipses', true)
%   Also displays the main 3D ellipses corresponding to XY, XZ and YZ
%   planes.
%
%
%   Example
%     figure; hold on;
%     drawEllipsoid([10 20 30   50 30 10   5 10 0]);
%     axis equal;
%
%     figure; hold on;
%     elli = [[10 20 30   50 30 10   5 10 0];
%     drawEllipsoid(elli, 'FaceColor', 'r', ...
%         'drawEllipses', true, 'EllipseColor', 'b', 'EllipseWidth', 3);
%     axis equal;
%
%   See also
%   spheres, drawSphere, inertiaEllipsoid, ellipsoid, drawTorus, drawCuboid 
%

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-03-12,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


%% Default values

% number of meridians
nPhi    = 32;

% number of parallels
nTheta  = 16;

% settings for drawing ellipses
drawEllipses = false;
ellipseColor = 'k';
ellipseWidth = 1;

drawAxes = false;
axesColor = 'k';
axesWidth = 2;


%% Extract input arguments

% Parse the input (try to extract center coordinates and radius)
if nargin == 0
    % no input: assumes ellipsoid with default shape
    elli = [0 0 0 5 4 3 0 0 0];
end

% default set of options for drawing meshes
options = {'FaceColor', 'g', 'linestyle', 'none'};

while length(varargin) > 1
    switch lower(varargin{1})
        case 'nphi'
            nPhi = varargin{2};
            
        case 'ntheta'
            nTheta = varargin{2};

        case 'drawellipses'
            drawEllipses = varargin{2};
            
        case 'ellipsecolor'
            ellipseColor = varargin{2};
            
        case 'ellipsewidth'
            ellipseWidth = varargin{2};
            
        case 'drawaxes'
            drawAxes = varargin{2};
            
        case 'axescolor'
            axesColor = varargin{2};
            
        case 'axeswidth'
            axesWidth = varargin{2};
            
        otherwise
            % assumes this is drawing option
            options = [options varargin(1:2)]; %#ok<AGROW>
    end

    varargin(1:2) = [];
end


%% Parse numerical inputs

% Extract ellipsoid parameters
xc  = elli(:,1);
yc  = elli(:,2);
zc  = elli(:,3);
a   = elli(:,4);
b   = elli(:,5);
c   = elli(:,6);
k   = pi / 180;
ellPhi   = elli(:,7) * k;
ellTheta = elli(:,8) * k;
ellPsi   = elli(:,9) * k;


%% Coordinates computation

% convert unit basis to ellipsoid basis
sca     = createScaling3d(a, b, c);
rotZ    = createRotationOz(ellPhi);
rotY    = createRotationOy(ellTheta);
rotX    = createRotationOx(ellPsi);
tra     = createTranslation3d([xc yc zc]);

% concatenate transforms
trans   = tra * rotZ * rotY * rotX * sca;


%% parametrisation of ellipsoid

% spherical coordinates
theta   = linspace(0, pi, nTheta+1);
phi     = linspace(0, 2*pi, nPhi+1);

% convert to cartesian coordinates
sintheta = sin(theta);
x = cos(phi') * sintheta;
y = sin(phi') * sintheta;
z = ones(length(phi),1) * cos(theta);

% transform mesh vertices
[x, y, z] = transformPoint3d(x, y, z, trans);


%% parametrisation of ellipses

if drawEllipses
    % parametrisation for ellipses
    nVertices = 120;
    t = linspace(0, 2*pi, nVertices+1);

    % XY circle
    xc1 = cos(t');
    yc1 = sin(t');
    zc1 = zeros(size(t'));

    % XZ circle
    xc2 = cos(t');
    yc2 = zeros(size(t'));
    zc2 = sin(t');

    % YZ circle
    xc3 = zeros(size(t'));
    yc3 = cos(t');
    zc3 = sin(t');

    % compute transformed ellipses
    [xc1, yc1, zc1] = transformPoint3d(xc1, yc1, zc1, trans);
    [xc2, yc2, zc2] = transformPoint3d(xc2, yc2, zc2, trans);
    [xc3, yc3, zc3] = transformPoint3d(xc3, yc3, zc3, trans);
end

%% parametrisation of main axis edges

if drawAxes
    axesEndings = [-1 0 0; +1 0 0; 0 -1 0; 0 +1 0; 0 0 -1; 0 0 +1];
    axesEndings = transformPoint3d(axesEndings, trans);
end


%% Drawing 

ellipseOptions = {'color', ellipseColor, 'LineWidth', ellipseWidth};
axesOptions = {'color', axesColor, 'LineWidth', axesWidth};

% Process output
if nargout == 0
    % no output: draw the ellipsoid
    surf(x, y, z, options{:});

    if drawEllipses
        plot3(xc1, yc1, zc1, ellipseOptions{:});
        plot3(xc2, yc2, zc2, ellipseOptions{:});
        plot3(xc3, yc3, zc3, ellipseOptions{:});
    end
    
    if drawAxes
        drawEdge3d([axesEndings(1,:), axesEndings(2,:)], axesOptions{:});
        drawEdge3d([axesEndings(3,:), axesEndings(4,:)], axesOptions{:});
        drawEdge3d([axesEndings(5,:), axesEndings(6,:)], axesOptions{:});
    end
    
elseif nargout == 1
    % one output: draw the ellipsoid and return handle 
    varargout{1} = surf(x, y, z, options{:});
    if drawEllipses
        plot3(xc1, yc1, zc1, ellipseOptions{:});
        plot3(xc2, yc2, zc2, ellipseOptions{:});
        plot3(xc3, yc3, zc3, ellipseOptions{:});
    end
    
elseif nargout == 3
    % 3 outputs: return computed coordinates
    varargout{1} = x; 
    varargout{2} = y; 
    varargout{3} = z; 
    if drawEllipses
        plot3(xc1, yc1, zc1, ellipseOptions{:});
        plot3(xc2, yc2, zc2, ellipseOptions{:});
        plot3(xc3, yc3, zc3, ellipseOptions{:});
    end
    
elseif nargout == 4 && drawEllipses
    % Also returns handles to ellipses
    varargout{1} = surf(x, y, z, options{:});
    varargout{2} = plot3(xc1, yc1, zc1, ellipseOptions{:});
    varargout{3} = plot3(xc2, yc2, zc2, ellipseOptions{:});
    varargout{4} = plot3(xc3, yc3, zc3, ellipseOptions{:});
    
end

