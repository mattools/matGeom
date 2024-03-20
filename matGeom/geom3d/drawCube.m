function varargout = drawCube(varargin)
%DRAWCUBE Draw a 3D centered cube, eventually rotated.
%
%   drawCube(CUBE)
%   Displays a 3D cube on current axis. CUBE is given by:
%   [XC YC ZC SIDE THETA PHI PSI]
%   where (XC, YC, ZC) is the CUBE center, SIDE is the length of the cube
%   main sides, and THETA PHI PSI are angles representing the cube
%   orientation, in degrees. THETA is the colatitude of the cube, between 0
%   and 90 degrees, PHI is the azimut, and PSI is the rotation angle
%   around the axis of the normal.
%
%   CUBE can be axis aligned, in this case it should only contain center
%   and side information:
%   CUBE = [XC YC ZC SIDE]
%
%   The function drawCuboid is closely related, but uses a different angle
%   convention, and allows for different sizes along directions.
%
%   Example
%   % Draw a cube with small rotations
%     figure; hold on;
%     drawCube([10 20 30  50  10 20 30], 'FaceColor', 'g');
%     axis equal;
%     view(3);
%
%   See also 
%   meshes3d, polyhedra, createCube, drawCuboid
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2011-06-29, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2023 INRA - Cepia Software Platform

% extract handle of axis to draw on
[hAx, varargin] = parseAxisHandle(varargin{:});

cube = varargin{1};
varargin(1) = [];

% default values
xc    = 0;
yc    = 0;
zc    = 0;
a     = 1;
theta = 0;
phi   = 0;
psi   = 0;

%% Parses the input
if nargin > 0
    % one argument: parses elements
    xc  = cube(:,1);
    yc  = cube(:,2);
    zc  = cube(:,3);
    % parses side length if present
    if size(cube, 2) >= 4
        a   = cube(:,4);
    end
    % parses orientation if present
    if size(cube, 2) >= 6
        theta = deg2rad(cube(:,5));
        phi   = deg2rad(cube(:,6));
    end
    if size(cube, 2) >= 7
        psi   = deg2rad(cube(:,7));
    end
end


%% Compute cube coordinates

% create unit centered cube
[v, f] = createCube;
v = bsxfun(@minus, v, mean(v, 1));

% convert unit basis to cube basis
sca     = createScaling3d(a);
rot1    = createRotationOz(psi);
rot2    = createRotationOy(theta);
rot3    = createRotationOz(phi);
tra     = createTranslation3d([xc yc zc]);

% concatenate transforms
trans   = tra * rot3 * rot2 * rot1 * sca;

% transform mesh vertices
v = transformPoint3d(v, trans);


%% Process output
if nargout == 0
    % no output: draw the cube
    drawMesh(hAx, v, f, varargin{:});
    
elseif nargout == 1
    % one output: draw the cube and return handle 
    varargout{1} = drawMesh(hAx, v, f, varargin{:});
    
elseif nargout == 3
    % 3 outputs: return computed coordinates
    varargout{1} = v(:,1); 
    varargout{2} = v(:,2); 
    varargout{3} = v(:,3); 
end

