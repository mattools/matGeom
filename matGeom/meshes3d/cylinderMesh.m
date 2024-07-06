function varargout = cylinderMesh(cyl, varargin)
%CYLINDERMESH Create a 3D mesh representing a cylinder.
%
%   [V, F] = cylinderMesh(CYL)
%   Computes vertex coordinates and face vertex indices of a mesh
%   representing a 3D cylinder given as [X1 Y1 Z1 X2 Y2 Z2 R].
%   
%   [V, F] = cylinderMesh(..., OPT)
%   with OPT = 'open' (0) (default) or 'closed' (1), specify if the bases 
%   of the cylinder should be included.
%   
%   [V, F] = cylinderMesh(..., NAME, VALUE);
%   Specifies one or several options using parameter name-value pairs.
%   Available options are:
%   'nPerimeter' the number of points represeting the perimeter
%   'nRho' the number of circles along the hight
%
%   Example
%     % Draw a rotated cylinder
%     cyl = [0 0 0 10 20 30 5];
%     [v, f] = cylinderMesh(cyl);
%     figure;drawMesh(v, f, 'FaceColor', 'r');
%     view(3); axis equal;
%
%     % Draw three mutually intersecting cylinders
%     p0 = [30 30 30];
%     p1 = [90 30 30];
%     p2 = [30 90 30];
%     p3 = [30 30 90];
%     [v1, f1] = cylinderMesh([p0 p1 25]);
%     [v2, f2] = cylinderMesh([p0 p2 25]);
%     [v3, f3] = cylinderMesh([p0 p3 25],'closed','nPeri',40,'nRho',20);
%     figure; hold on;
%     drawMesh(v1, f1, 'FaceColor', 'r');
%     drawMesh(v2, f2, 'FaceColor', 'g');
%     drawMesh(v3, f3, 'FaceColor', 'b');
%     view(3); axis equal
%     set(gcf, 'renderer', 'opengl')
%  
%   See also 
%     drawCylinder, torusMesh, sphereMesh

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2012-10-25, using Matlab 7.9.0.529 (R2009b)
% Copyright 2012-2024 INRA - Cepia Software Platform

parser = inputParser;
addRequired(parser, 'cyl', @(x) validateattributes(x, {'numeric'},...
    {'size',[1 7],'real','finite','nonnan'}));
capParValidFunc = @(x) (islogical(x) ...
    || isequal(x,1) || isequal(x,0) || any(validatestring(x, {'open','closed'})));
addOptional(parser,'cap','open', capParValidFunc);
addParameter(parser, 'nPerimeter', 20, @(x) validateattributes(x,{'numeric'},...
    {'integer','scalar','>=',4}));
addParameter(parser, 'nRho', 10, @(x) validateattributes(x,{'numeric'},...
    {'integer','scalar','>=',2}));
parse(parser,cyl,varargin{:});
cyl=parser.Results.cyl;
cap=lower(parser.Results.cap(1));
NoPP=parser.Results.nPerimeter;
nRho=parser.Results.nRho;

% extract cylinder data
p1 = cyl(:, 1:3);
p2 = cyl(:, 4:6);
r  = cyl(:, 7);

% compute length and orientation
[theta, phi, rho] = cart2sph2d(p2 - p1);

% parametrisation on x
t = linspace(0, 2*pi, NoPP+1);
lx = r * cos(t);
ly = r * sin(t);

% parametrisation on z
lz = linspace(0, rho, nRho);

% generate surface grids
x = repmat(lx, [length(lz) 1]);
y = repmat(ly, [length(lz) 1]);
z = repmat(lz', [1 length(t)]);

% transform points 
trans = localToGlobal3d(p1, theta, phi, 0);
[x, y, z] = transformPoint3d(x, y, z, trans);

% convert to FV mesh
[vertices, faces] = surfToMesh(x, y, z, 'xPeriodic', true);

% Close cylinder
if cap == 'c' || cap == 1
    nR = round(r/(rho/(nRho-1)));
    % Base at p1
    P1 = circleMesh([0 0 0 r 0 0 0], 'nP',NoPP, 'nR',nR);
    P1 = transformMesh(P1, trans);
    P1.faces = fliplr(P1.faces);
    % Base at p2
    P2 = circleMesh([transformPoint3d(p2, inv(trans)) r 0 0 0], 'nP',NoPP, 'nR',nR);
    P2 = transformMesh(P2, trans);
    % Triangulate the lateral surface of the mesh
    latSurf.vertices = vertices;
    latSurf.faces = triangulateFaces(faces);
    mesh = concatenateMeshes(latSurf, P1, P2);
    [vertices, faces] = removeDuplicateVertices(mesh, 1e-8);
end

% format output
varargout = formatMeshOutput(nargout, vertices, faces);
