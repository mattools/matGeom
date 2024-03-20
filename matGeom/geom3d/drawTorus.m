function varargout = drawTorus(varargin)
%DRAWTORUS Draw a torus (3D ring).
%
%   drawTorus(TORUS)
%   Draws the torus on the current axis. TORUS is given by:
%   [XC YC ZY  R1 R2  THETA PHI]
%   where (XC YZ ZC) is the center of the torus, R1 is the main radius, R2
%   is the radius of the torus section, and (THETA PHI) is the angle of the
%   torus normal vector (both in degrees).
%
%   drawTorus(..., PNAME, PVALUE)
%   Specifies a set of parameter name-value pairs. Parameter names include
%   plitting options ('facecolor', 'linestyle'...), or options specific to
%   torus:
%   'nPhi'      number of meridians used to draw the torus (default is 60).
%   'nTheta'    number of parallels used to draw the torus (default is 60).
%
%
%   Example
%     % draw sample torus
%     figure;
%     drawTorus([50 50 50 30 10 30 45]);
%     axis equal; view([95 10]); light;
%
%   See also 
%   drawEllipsoid, revolutionSurface, torusMesh
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2011-06-22, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2023 INRA - Cepia Software Platform

%% Default values

% number of meridians
nPhi    = 60;

% number of parallels
nTheta  = 60;


%% Extract input arguments

% extract handle of axis to draw on
[hAx, varargin] = parseAxisHandle(varargin{:});

torus = varargin{1};
varargin(1) = [];

center = torus(:, 1:3);
r1 = torus(:, 4);
r2 = torus(:, 5);
nTorus = size(center, 1);

normal = zeros(nTorus, 2);
if size(torus, 2) >= 7
    normal = torus(:, 6:7);
end

% default set of options for drawing meshes
options = {'FaceColor', 'g', 'linestyle', 'none'};

while length(varargin) > 1
    switch lower(varargin{1})
        case 'nphi'
            nPhi = varargin{2};
            
        case 'ntheta'
            nTheta = varargin{2};

        otherwise
            % assumes this is drawing option
            options = [options varargin(1:2)]; %#ok<AGROW>
    end

    varargin(1:2) = [];
end


%% Draw the torus

% allocate array of handles
hs = gobjects(1, nTorus);

% save hold state
holdState = ishold(hAx);
hold(hAx, 'on');

% iteate over torusses
for i = 1:nTorus
    % create base torus
    circle = circleToPolygon([r1(i) 0 r2(i)], nTheta);
    [x, y, z] = revolutionSurface(circle, linspace(0, 2*pi, nPhi));
    
    % transform torus
    trans = localToGlobal3d([center(i,:) normal(i,:)]);
    [x, y, z] = transformPoint3d(x, y, z, trans);
    
    % draw the surface
    hs(i) = surf(hAx, x, y, z, options{:});
end

% restore hold state
if ~holdState
    hold(hAx, 'off');
end


%% Process output arguments

if nargout > 0
    varargout = {hs};
end
