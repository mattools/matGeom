function varargout = createIcosahedron()
%CREATEICOSAHEDRON Create a 3D mesh representing an Icosahedron.
%
%   MESH = createIcosahedron;
%   [V E F] = createIcosahedron;
%   Create a solid with 12 vertices, and 20 triangular faces. Faces are
%   oriented outwards of the mesh.
%
%   [V F] = createIcosahedron;
%   Returns only the vertices and the face vertex indices.
%
%   MESH = createIcosahedron;
%   Returns the data as a mesh structure, with fields 'vertices', 'edges'
%   and 'faces'.
%
%   Example
%     [n e f] = createIcosahedron;
%     drawMesh(n, f);
%   
%   See also
%   meshes3d, drawMesh
%   createCube, createOctahedron, createDodecahedron, createTetrahedron
%
%
%   ---------
%   author: David Legland 
%   mail: david.legland@grignon.inra.fr
%   INRA - TPV URPOI - BIA IMASTE
%   created the 21/03/2005.
%

%   HISTORY
%   2007-01-04 remove unused variables
%   2010-12-06 format output, orient normals outwards


%% Initialisations

theta = 2*pi/5;
l = 1/sin(theta/2)/2;
z1 = sqrt(1-l*l);

t1 = (0:2*pi/5:2*pi*(1-1/5))';
x1 = l*cos(t1);
y1 = l*sin(t1);

t2 = t1 + 2*pi/10;
x2 = l*cos(t2);
y2 = l*sin(t2);

h = sqrt(l*l-.5*.5);
z2 = sqrt(3/4 - (l-h)*(l-h));


%% Create mesh data

nodes = [0 0 0;...
    [x1 y1 repmat(z1, [5 1])]; ...
    [x2 y2 repmat(z1+z2, [5 1])]; ...
    0 0 2*z1+z2];

edges = [...
    1 2;1 3;1 4;1 5;1 6; ...
    2 3;3 4;4 5;5 6;6 2; ...
    2 7;7 3;3 8;8 4;4 9;9 5;5 10;10 6;6 11;11 2; ...
    7 8;8 9;9 10;10 11;11 7; ...
    7 12;8 12;9 12;10 12;11 12];
    
% faces are ordered to have normals pointing outside of the mesh
faces = [...
    1 3  2 ; 1 4  3 ; 1  5  4 ;  1  6  5 ;  1 2  6;...
    2 3  7 ; 3 4  8 ; 4  5  9 ;  5  6 10 ;  6 2 11;...
    7 3  8 ; 8 4  9 ; 9  5 10 ; 10  6 11 ; 11 2  7;...
    7 8 12 ; 8 9 12 ; 9 10 12 ; 10 11 12 ; 11 7 12];

% format output
varargout = formatMeshOutput(nargout, nodes, edges, faces);
