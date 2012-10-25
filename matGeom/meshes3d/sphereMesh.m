function varargout = sphereMesh(sphere, varargin)
%SPHEREMESH  Create a 3D mesh representing a sphere
%
%   [V F] = sphereMesh(S)
%   Creates a 3D mesh representing the sphere S given by [xc yc zy r].
%
%   Example
%     s = [10 20 30 40];
%     [v f] = sphereMesh(s);
%     drawMesh(v, f);
%     view(3);axis equal; light; lighting gouraud;
%
%   See also
%     cylinder, surfToMesh, drawSphere
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-10-25,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% extract sphere data
xc = sphere(:,1);
yc = sphere(:,2);
zc = sphere(:,3);
r  = sphere(:,4);

% number of meridians
nPhi    = 32;
    
% number of parallels
nTheta  = 16;

% compute spherical coordinates
theta   = linspace(0, pi, nTheta+1);
phi     = linspace(0, 2*pi, nPhi+1);

% convert to cartesian coordinates
sintheta = sin(theta);
x = xc + cos(phi') * sintheta * r;
y = yc + sin(phi') * sintheta * r;
z = zc + ones(length(phi),1) * cos(theta) * r;

% convert to FV mesh
[vertices faces] = surfToMesh(x, y, z);

% format output
varargout = formatMeshOutput(nargout, vertices, faces);
