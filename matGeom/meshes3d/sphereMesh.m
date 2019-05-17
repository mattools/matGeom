function varargout = sphereMesh(sphere, varargin)
%SPHEREMESH  Create a 3D mesh representing a sphere.
%
%   [V, F] = sphereMesh(S)
%   Creates a 3D mesh representing the sphere S given by [xc yc zy r].
%
%   [V, F] = sphereMesh();
%   Assumes sphere is the unit sphere centered at the origin.
%
%   [V, F] = sphereMesh(S, 'nTheta', NT, 'nPhi', NP);
%   Specifies the number of discretisation steps for the meridians and the
%   parallels. Default values are nTheta = 16 and nPhi = 32.
%
%
%   Example
%     s = [10 20 30 40];
%     [v, f] = sphereMesh(s);
%     drawMesh(v, f);
%     view(3); axis equal; light; lighting gouraud;
%
%   See also
%     meshes3d, drawSphere, ellipsoidMesh, cylinderMesh, surfToMesh
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2012-10-25,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

if nargin == 0
    sphere = [0 0 0 1];
end

% number of meridians
nPhi    = 32;
    
% number of parallels
nTheta  = 16;

% process input arguments
while length(varargin) > 1
    paramName = varargin{1};
    switch lower(paramName)
        case 'ntheta', nTheta = varargin{2};
        case 'nphi', nPhi = varargin{2};
        otherwise
            error(['Could not recognise parameter: ' paramName]);
    end
    varargin(1:2) = [];
end

% extract sphere data
xc = sphere(:,1);
yc = sphere(:,2);
zc = sphere(:,3);
r  = sphere(:,4);


% compute spherical coordinates
theta   = linspace(0, pi, nTheta+1);
phi     = linspace(0, 2*pi, nPhi+1);

% convert to cartesian coordinates
sintheta = sin(theta);
x = xc + cos(phi') * sintheta * r;
y = yc + sin(phi') * sintheta * r;
z = zc + ones(length(phi),1) * cos(theta) * r;

% convert to FV mesh
[vertices, faces] = surfToMesh(x, y, z, 'yperiodic', true);

% format output
varargout = formatMeshOutput(nargout, vertices, faces);
