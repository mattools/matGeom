function varargout = createDurerPolyhedron(varargin)
%CREATEDURERPOLYHEDRON  Create a mesh representing Durer's polyhedron .
%
%   [V, F] = createDurerPolyhedron
%   [V, E, F] = createDurerPolyhedron
%   Returns a mesh data structure that represents Durer's polyhedron shown
%   in "Melancholia". Vertices are stored in V as Nv-by-3 array of 3D
%   coordinates, faces are stored in Nf-by-1 cell array containing the
%   vertex indices of each face.
%   Several hypotheses exist on the exact geometry of the solid. The one
%   described in Mathworld (see references) is used here.
%
%   Durer's polyhedron is generated from a centered unit cube. Several
%   transforms are applied succesively:
%   * Rotation around Oz by PI / 4
%   * Rotation around Oy by asec(sqrt(3))
%   * z-scaling by sqrt(1 + 3 / sqrt(5) )
%   * truncation by two horizontal planes located at a distance of 
%       (3 - sqrt(5)) / 2 from each azimutal vertex.
%
%   Durer's polyhedron is composed of six pentagonal faces and 2 triangular
%   faces. Pentagonal faces have angles 126, 108, 72, 108, and 126 degrees.
%   triangular faces are equilateral.
%
%   Example
%     % Display Durer's polyhedron 
%     [v f] = createDurerPolyhedron;
%     figure; hold on; set(gcf, 'renderer', 'opengl');
%     drawMesh(v, f, 'FaceColor', [.7 .7 .7]);
%     axis equal; axis([-1 1 -1 1 -1 1]);
%     view(3)
%
%   See also
%     meshes3d, createCube, createOctahedron
%
%   References
%   http://mathworld.wolfram.com/DuerersSolid.html
%   http://en.wikipedia.org/wiki/Dürer_graph

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2012-07-31,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% start from a cube basis
[v, f] = createCube;

% recenter, rotate, and rescale
v    = v -.5;
rot1 = createRotationOz(pi/4);
rot2 = createRotationOy(asec(sqrt(3)));
sca  = createScaling3d([1 1 sqrt(1+3/sqrt(5))]);
v = transformPoint3d(v, sca * rot2 * rot1);

% compute the height of the two clipping planes
d = (3 - sqrt(5)) / 2;
zmax = max(v(:,3));
z1 = zmax - d;

% clip by two horizontal planes
plane1  = createPlane([0 0 z1], [0 0 1]);
[v, f]   = clipConvexPolyhedronHP(v, f, plane1);
plane2  = createPlane([0 0 -z1], [0 0 -1]);
[v, f]   = clipConvexPolyhedronHP(v, f, plane2);

% complete with edge information
e = meshEdges(f);

% format output
varargout = formatMeshOutput(nargout, v, e, f);
