function varargout = createDodecahedron()
%CREATEDODECAHEDRON Create a 3D mesh representing a dodecahedron.
%
%   [V, E, F] = createDodecahedron;
%   Create a 3D mesh representing a dodecahedron
%   V is the 20-by-3 array of vertex coordinates
%   E is the 30-by-2 array of edge vertex indices
%   F is the 12-by-5 array of face vertex indices
%
%   [V, F] = createDodecahedron;
%   Returns only the vertices and the face vertex indices.
%
%   MESH = createDodecahedron;
%   Returns the data as a mesh structure, with fields 'vertices', 'edges'
%   and 'faces'.
%
%   Example
%   [v, e, f] = createDodecahedron;
%   drawMesh(v, f);
%
%   Use values given by P. Bourke, see:
%   http://local.wasp.uwa.edu.au/~pbourke/geometry/platonic/
%   faces are re-oriented to have normals pointing outwards.
%
%   See also
%   meshes3d, drawMesh
%   createCube, createOctahedron, createIcosahedron, createTetrahedron
%

%   ---------
%   author : David Legland 
%   e-mail: david.legland@inra.fr
%   INRA - TPV URPOI - BIA IMASTE
%   created the 29/07/2010.
%

%   HISTORY

% golden ratio
phi = (1+sqrt(5))/2;

% coordinates pre-computations
b = 1 / phi ; 
c = 2 - phi ;

% use values given by P. Bourke, see:
% http://local.wasp.uwa.edu.au/~pbourke/geometry/platonic/
tmp = [ ...
 c  0  1 ;   b  b  b ;   0  1  c  ; -b  b  b  ; -c  0  1 ;  ...
-c  0  1 ;  -b -b  b ;   0 -1  c  ;  b -b  b  ;  c  0  1 ;   ...
 c  0 -1 ;   b -b -b ;   0 -1 -c  ; -b -b -b  ; -c  0 -1 ;  ...
-c  0 -1 ;  -b  b -b ;   0  1 -c  ;  b  b -b  ;  c  0 -1 ; ...
 0  1 -c ;   0  1  c ;   b  b  b  ;  1  c  0  ;  b  b -b ; ...
 0  1  c ;   0  1 -c ;  -b  b -b  ; -1  c  0  ; -b  b  b ; ...
 0 -1 -c ;   0 -1  c ;  -b -b  b  ; -1 -c  0  ; -b -b -b ; ...
 0 -1  c ;   0 -1 -c ;   b -b -b  ;  1 -c  0  ;  b -b  b ; ...
 1  c  0 ;   b  b  b ;   c  0  1  ;  b -b  b  ;  1 -c  0 ;  ...
 1 -c  0 ;   b -b -b ;   c  0 -1  ;  b  b -b  ;  1  c  0 ; ...
-1  c  0 ;  -b  b -b ;  -c  0 -1  ; -b -b -b  ; -1 -c  0 ; ...
-1 -c  0 ;  -b -b  b ;  -c  0  1  ; -b  b  b  ; -1  c  0 ;  ...
];

% extract coordinates of unique vertices
[verts, M, N] = unique(tmp, 'rows', 'first'); %#ok<ASGLU>

% compute indices of face vertices, put result in a 12-by-5 index array
ind0 = reshape((1:60), [5 12])';
faces = N(ind0);

% extract edges from faces
edges = [reshape(faces(:, 1:5), [60 1]) reshape(faces(:, [2:5 1]), [60 1])];
edges = unique(sort(edges, 2), 'rows');


% format output
varargout = formatMeshOutput(nargout, verts, edges, faces);
