function varargout = createCube()
%CREATECUBE Create a 3D mesh representing the unit cube
%
%   [V E F] = createCube 
%   Create a unit cube, as a polyhedra representation.
%   c has the form [V E F], where V is a 8-by-3 array with vertices
%   coordinates, E is a 12-by-2 array containing indices of neighbour
%   vertices, and F is a 6-by-4 array containing vertices array of each
%   face.
%
%   [V F] = createCube;
%   Returns only the vertices and the face vertex indices.
%
%   MESH = createCube;
%   Returns the data as a mesh structure, with fields 'vertices', 'edges'
%   and 'faces'.
%
%   Example
%   [n e f] = createCube;
%   drawMesh(n, f);
%   
%   See also
%   meshes3d, drawMesh
%   createOctahedron, createTetrahedron, createDodecahedron
%   createIcosahedron, createCubeOctahedron
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 10/02/2005.
%

%   HISTORY
%   04/01/2007: remove unused variables

x0 = 0; dx= 1;
y0 = 0; dy= 1;
z0 = 0; dz= 1;

nodes = [...
    x0 y0 z0; ...
    x0+dx y0 z0; ...
    x0 y0+dy z0; ...
    x0+dx y0+dy z0; ...
    x0 y0 z0+dz; ...
    x0+dx y0 z0+dz; ...
    x0 y0+dy z0+dz; ...
    x0+dx y0+dy z0+dz];

edges = [1 2;1 3;1 5;2 4;2 6;3 4;3 7;4 8;5 6;5 7;6 8;7 8];

% faces are oriented such that normals point outwards
faces = [1 3 4 2;5 6 8 7;2 4 8 6;1 5 7 3;1 2 6 5;3 7 8 4];

% format output
varargout = formatMeshOutput(nargout, nodes, edges, faces);
