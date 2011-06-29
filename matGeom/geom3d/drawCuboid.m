function varargout = drawCuboid(cuboid, varargin)
%DRAWCUBOID Draw a 3D cuboid, eventually rotated
%
%   drawCuboid(CUBOID)
%   Displays a 3D cuboid on current axis. CUBOID is given by:
%   [XC YC ZC L W D YAW PITCH ROLL],
%   where (XC, YC, ZC) is the cuboid center, L, W and H are the lengths of
%   the cuboid main axes, and YAW PITCH ROLL are Euler angles representing
%   the cuboid orientation, in degrees. 
%
%   If cuboid is axis-aligned, it can be specified using only center and
%   side lengths:
%   CUBOID = [XC YC ZC L W H]
%
%   Example
%   % Draw a basic rotated cuboid
%     figure; hold on;
%     drawCuboid([10 20 30   90 40 10   10 20 30], 'FaceColor', 'g');
%     axis equal;
%     view(3);
%
%     % Draw three "borromean" cuboids
%     figure; hold on;
%     drawCuboid([10 20 30 90 50 10], 'FaceColor', 'r');
%     drawCuboid([10 20 30 50 10 90], 'FaceColor', 'g');
%     drawCuboid([10 20 30 10 90 50], 'FaceColor', 'b');
%     view(3); axis equal;
%     set(gcf, 'renderer', 'opengl')
%
%   See also
%   meshes3d, polyhedra, createCube, drawEllipsoid, drawCube
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-29,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

phi   = 0;
theta = 0;
psi   = 0;

%% Parses the input 
if nargin == 0
    % no input: assumes cuboid with default shape
    xc = 0;	yc = 0; zc = 0;
    a = 5; b = 4; c = 3;

else
    % one argument: parses elements
    xc  = cuboid(:,1);
    yc  = cuboid(:,2);
    zc  = cuboid(:,3);
    a   = cuboid(:,4);
    b   = cuboid(:,5);
    c   = cuboid(:,6);
    if size(cuboid, 2) >= 9
        k   = pi / 180;
        phi   = cuboid(:,7) * k;
        theta = cuboid(:,8) * k;
        psi   = cuboid(:,9) * k;
    end
end


%% Compute cuboid coordinates

% create unit centered cube
[v f] = createCube;
v = bsxfun(@minus, v, mean(v, 1));

% convert unit basis to ellipsoid basis
sca     = createScaling3d(a, b, c);
rotZ    = createRotationOz(phi);
rotY    = createRotationOy(theta);
rotX    = createRotationOx(psi);
tra     = createTranslation3d([xc yc zc]);

% concatenate transforms
trans   = tra * rotZ * rotY * rotX * sca;

% transform mesh vertices
[x y z] = transformPoint3d(v, trans);


%% Process output
if nargout == 0
    % no output: draw the cuboid
    drawMesh([x y z], f, varargin{:});
    
elseif nargout == 1
    % one output: draw the cuboid and return handle 
    varargout{1} = drawMesh([x y z], f, varargin{:});
    
elseif nargout == 3
    % 3 outputs: return computed coordinates
    varargout{1} = x; 
    varargout{2} = y; 
    varargout{3} = z; 
end

