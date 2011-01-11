function varargout = createOctahedron()
%CREATEOCTAHEDRON Create a 3D mesh representing an octahedron
%
%   [V E F] = createOctahedron;
%   Create a 3D mesh representing an octahedron
%   V is a 6*3 array with vertices coordinate, E is a 12*2 array containing
%   indices of neighbour vertices, and F is a 8*3 array containing array of
%   vertex index for each face.
%
%   [V F] = createOctahedron;
%   Returns only the vertices and the face vertex indices.
%
%   MESH = createOctahedron;
%   Returns the data as a mesh structure, with fields 'vertices', 'edges'
%   and 'faces'.
%
%   Example
%   [v e f] = createOctahedron;
%   drawMesh(v, f);
%
%
%   See also
%   meshes3d, drawMesh
%   createCube, createIcosahedron, createDodecahedron, createTetrahedron
%   createCubeOctahedron
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 10/02/2005.
%

%   HISTORY
%   04/01/2007: remove unused variables

nodes = [1 0 0;0 1 0;-1 0 0;0 -1 0;0 0 1;0 0 -1];

edges = [1 2;1 4;1 5; 1 6;2 3;2 5;2 6;3 4;3 5;3 6;4 5;4 6];

faces = [1 2 5;2 3 5;3 4 5;4 1 5;1 6 2;2 6 3;3 6 4;1 4 6];

% format output
varargout = formatMeshOutput(nargout, nodes, edges, faces);
