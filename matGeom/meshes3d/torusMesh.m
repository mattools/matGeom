function varargout = torusMesh(torus, varargin)
%TORUSMESH  Create a 3D mesh representing a torus
%
%   [v f] = torusMesh(torus)
%   Converts the torus in TORUS into a face-vertex quadrangular mesh.
%   TORUS is given by [XC YC ZY R1 R2 THETA PHI]
%   where (XC YZ ZC) is the center of the torus, R1 is the main radius, R2
%   is the radius of the torus section, and (THETA PHI) is the angle of the
%   torus normal vector (both in degrees).
%
%   Example
%     [v f] = torusMesh([50 50 50 30 10 30 45]);
%     figure; drawMesh(v, f, 'linestyle', 'none');
%     view(3); axis equal; 
%     lighting gouraud; light;
%
%
%   See also
%     drawTorus, revolutionSurface, cylinderMesh, drawMesh
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-10-25,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

center = torus(1:3);
r1 = torus(4);
r2 = torus(5);

if size(torus, 2) >= 7
    normal = torus(6:7);
end

% create base torus
circle = circleToPolygon([r1 0 r2], 60);
[x y z] = revolutionSurface(circle, linspace(0, 2*pi, 60));

% transform torus
trans = localToGlobal3d([center normal]);
[x y z] = transformPoint3d(x, y, z, trans);

% convert to FV mesh
[vertices faces] = surfToMesh(x, y, z);

% format output
varargout = formatMeshOutput(nargout, vertices, faces);
