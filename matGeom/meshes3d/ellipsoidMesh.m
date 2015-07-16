function varargout = ellipsoidMesh(elli, varargin)
%ELLIPSOIDMESH Convert a 3D ellipsoid to face-vertex mesh representation
%
%   [V, F] = ellipsoidMesh(ELLI)
%   ELLI is given by:
%   [XC YC ZC  A B C  PHI THETA PSI],
%   where (XC, YC, ZC) is the ellipsoid center, A, B and C are the half
%   lengths of the ellipsoid main axes, and PHI THETA PSI are Euler angles
%   representing ellipsoid orientation, in degrees.
%
%
%   See also
%   meshes3d, drawEllipsoid, sphereMesh, inertiaEllipsoid
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

% convert to FV mesh
[vertices, faces] = surfToMesh(x, y, z, 'xPeriodic', false, 'yPeriodic', true);

% format output
varargout = formatMeshOutput(nargout, vertices, faces);