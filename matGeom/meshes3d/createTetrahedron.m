function varargout = createTetrahedron()
%CREATETETRAHEDRON Create a 3D mesh representing a tetrahedron.
%
%   [V, E, F] = createTetrahedron
%   create a simple tetrahedron, using mesh representation. The tetrahedron
%   is inscribed in the unit cube.
%   V is a 4-by-3 array with vertex coordinates, 
%   E is a 6-by-2 array containing indices of neighbour vertices,
%   F is a 4-by-3 array containing vertices array of each (triangular) face.
%
%   [V, F] = createTetrahedron;
%   Returns only the vertices and the faces.
%
%   MESH = createTetrahedron;
%   Returns the data as a mesh structure, with fields 'vertices', 'edges'
%   and 'faces'.
%
%
%   Example
%   % Create and display a tetrahedron
%   [V, E, F] = createTetrahedron;
%   drawMesh(V, F);
%
%   See also 
%   meshes3d, drawMesh
%   createCube, createOctahedron, createDodecahedron, createIcosahedron

%   ---------
%   author : David Legland 
%   e-mail: david.legland@inra.fr
%   INRA - TPV URPOI - BIA IMASTE
%   created the 21/03/2005.
%

%   HISTORY
%   04/01/2007: remove unused variables

x0 = 0; dx= 1;
y0 = 0; dy= 1;
z0 = 0; dz= 1;

nodes = [...
    x0 y0 z0; ...
    x0+dx y0+dy z0; ...
    x0+dx y0 z0+dz; ...
    x0 y0+dy z0+dz];

edges = [1 2;1 3;1 4;2 3;3 4;4 2];

faces = [1 2 3;1 3 4;1 4 2;4 3 2];


% format output
varargout = formatMeshOutput(nargout, nodes, edges, faces);
