function varargout = createCubeOctahedron()
%CREATECUBEOCTAHEDRON Create a 3D mesh representing a cube-octahedron.
%
%   [V, E, F] = createCubeOctahedron;
%   Cubeoctahedron can be seen either as a truncated cube, or as a
%   truncated octahedron.
%   V is the 12-by-3 array of vertex coordinates
%   E is the 27-by-2 array of edge vertex indices
%   F is the 1-by-14 cell array of face vertex indices
%
%   [V, F] = createCubeOctahedron;
%   Returns only the vertices and the face vertex indices.
%
%   MESH = createCubeOctahedron;
%   Returns the data as a mesh structure, with fields 'vertices', 'edges'
%   and 'faces'.
%
%   Example
%   [n, e, f] = createCubeOctahedron;
%   drawMesh(n, f);
%   
%   See also
%   meshes3d, drawMesh, createCube, createOctahedron
%

%   ---------
%   author : David Legland 
%   e-mail: david.legland@inra.fr
%   INRA - TPV URPOI - BIA IMASTE
%   created the 10/02/2005.
%

%   HISTORY
%   04/01/2007: remove unused variables

nodes = [...
    0 -1 1;1 0 1;0 1 1;-1 0 1; ...
    1 -1 0;1 1 0;-1 1 0;-1 -1 0;...
    0 -1 -1;1 0 -1;0 1 -1;-1 0 -1];

edges = [...
     1  2;  1  4; 1 5; 1 8; ...
     2  3;  2  5; 2 6; ...
     3  4;  3  6; 3 7; ...
     4  7;  4  8; ...
     5  9;  5 10; ...
     6 10;  6 11; ...
     7 11;  7 12; ...
     8  9;  8 12; ...
     9 10;  9 12; ...
    10 11; 11 12];

faces = {...
    [1 2 3 4], [1 5 2], [2 6 3], [3 7 4], [4 8 1], ...
    [5 10 6 2], [3 6 11 7], [4 7 12 8], [1 8 9 5], ...
    [5 9 10], [6 10 11], [7 11 12], [8 12 9], [9 12 11 10]};

% format output
varargout = formatMeshOutput(nargout, nodes, edges, faces);

