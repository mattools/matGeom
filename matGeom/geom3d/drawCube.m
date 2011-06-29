function varargout = drawCube(cube, varargin)
%DRAWCUBE Draw a 3D centered cube, eventually rotated
%
%   drawCube(CUBE)
%   Displays a 3D cube on current axis. CUBE is given by:
%   [XC YC ZC SIDE THETA PHI PSI]
%   where (XC, YC, ZC) is the CUBE center, SIDE is the length of the cube
%   main sides, and THETA PHI PSI are angles representing the cube
%   orientation, in degrees. THETA is the colatitude of the cube, between 0
%   and 90 degrees, PHI is the longitude, and PSI is the rotation angle
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
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-29,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


% default values
theta = 0;
phi   = 0;
psi   = 0;

%% Parses the input
if nargin == 0
    % no input: assumes cube with default shape
    xc = 0;	yc = 0; zc = 0;
    a = 1;

else
    % one argument: parses elements
    xc  = cube(:,1);
    yc  = cube(:,2);
    zc  = cube(:,3);
    a   = cube(:,4);

    % parses orientation if present
    k   = pi / 180;
    if size(cube, 2) >= 6
        theta = cube(:,5) * k;
        phi   = cube(:,6) * k;
    end
    if size(cube, 2) >= 7
        psi   = cube(:,7) * k;
    end
end


%% Compute cube coordinates

% create unit centered cube
[v f] = createCube;
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
[x y z] = transformPoint3d(v, trans);


%% Process output
if nargout == 0
    % no output: draw the cube
    drawMesh([x y z], f, varargin{:});
    
elseif nargout == 1
    % one output: draw the cube and return handle 
    varargout{1} = drawMesh([x y z], f, varargin{:});
    
elseif nargout == 3
    % 3 outputs: return computed coordinates
    varargout{1} = x; 
    varargout{2} = y; 
    varargout{3} = z; 
end

