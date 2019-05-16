function varargout = torusMesh(torus, varargin)
%TORUSMESH  Create a 3D mesh representing a torus.
%
%   [V, F] = torusMesh(TORUS)
%   Converts the torus in TORUS into a face-vertex quadrangular mesh.
%   TORUS is given by [XC YC ZY R1 R2 THETA PHI]
%   where (XC YZ ZC) is the center of the torus, R1 is the main radius, R2
%   is the radius of the torus section, and (THETA PHI) is the angle of the
%   torus normal vector (both in degrees).
%
%   [V, F] = torusMesh(TORUS, 'nTheta', NT, 'nPhi', NP)
%   Creates a mesh using NP circles, each circle being discretized with NT
%   vertices. Default are 60 for both parameters.
%
%   [V, F] = torusMesh()
%   Creates a mesh representing a default torus.
%
%   Example
%     [v, f] = torusMesh([50 50 50 30 10 30 45]);
%     figure; drawMesh(v, f, 'linestyle', 'none');
%     view(3); axis equal; 
%     lighting gouraud; light;
%
%
%   See also
%     meshes3d, drawTorus, revolutionSurface, cylinderMesh, sphereMesh
%     drawMesh

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-10-25,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

%   HISTORY
%   2013-04-30 add support for empty argument


%% Extract data for torus

if nargin == 0
    torus = [0 0 0 30 10 0 0 0];
end

center = torus(1:3);
r1 = torus(4);
r2 = torus(5);

if size(torus, 2) >= 7
    normal = torus(6:7);
end


%% Extract data for discretisation

% number 
nTheta = 60;
nPhi = 60;
while length(varargin) > 1
    argName = varargin{1};
    switch lower(argName)
        case 'ntheta'
            nTheta = varargin{2};
        case 'nphi'
            nPhi = varargin{2};
        otherwise
            error('Unknown optional argument: %s', argName);
    end
    
    varargin(1:2) = [];
end


%% Discretize torus

% create base torus
circle = circleToPolygon([r1 0 r2], nTheta);
[x, y, z] = revolutionSurface(circle, linspace(0, 2*pi, nPhi));

% transform torus
trans = localToGlobal3d([center normal]);
[x, y, z] = transformPoint3d(x, y, z, trans);

% convert to FV mesh
[vertices, faces] = surfToMesh(x, y, z, 'xPeriodic', true, 'yPeriodic', true);

% format output
varargout = formatMeshOutput(nargout, vertices, faces);
