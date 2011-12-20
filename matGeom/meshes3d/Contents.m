% MESHES3D 3D Surface Meshes
% Version 1.0 21-Mar-2011 .
%
%   Creation, vizualization, and manipulation of 3D surface meshes or
%   polyhedra.
%
%   Meshes and Polyhedra are represented by a couple of variables {V, F}:
%   V: Nv-by-3 array of vertices: [x1 y1 z1; ... ; xn yn zn];
%   F: is either a NF-by-3 or NF-by-4 array containing reference for
%   vertices of each face, or a NF-by-1 cell array, where each cell is an
%   array containing a variable number of node indices.
%   For some functions, the array E of edges is needed. It consists in a
%   NE-by-2 array containing indices of source and target vertices. 
%
%   The library provides function to create basic polyhedric meshes (the 5
%   platonic solids, plus few others), as well as functions to perform
%   basic computations (surface area, normal angles, face centroids...).
%   The 'MengerSponge' structure is an example of mesh that is not simply
%   connected (multiple tunnels in the structure).
%
%   The drawMesh function is mainly a wrapper to the Matlab 'patch'
%   function, allowing passing arguments more quickly.
%
%   Example
%     % create a soccer ball mesh and display it
%     [n e f] = createSoccerBall;
%     drawMesh(n, f, 'faceColor', 'g', 'linewidth', 2);
%     axis equal;
%  
%
% General functions
%   meshFace                 - Return the vertex indices of a face in a mesh
%   computeMeshEdges         - Computes edges array from face array
%   meshEdgeFaces            - Compute index of faces adjacent to each edge of a mesh
%   faceCentroids            - Compute centroids of a mesh faces
%   faceNormal               - Compute normal vector of faces in a 3D mesh
%   vertexNormal             - Compute normals to a mesh vertices
%
% Measures on meshes
%   meshSurfaceArea          - Surface area of a polyhedral mesh
%   trimeshSurfaceArea       - Surface area of a triangular mesh
%   meshEdgeLength           - Lengths of edges of a polygonal or polyhedral mesh
%   meshDihedralAngles       - Dihedral at edges of a polyhedal mesh
%   polyhedronNormalAngle    - Compute normal angle at a vertex of a 3D polyhedron
%   polyhedronMeanBreadth    - Mean breadth of a convex polyhedron
%
% Basic processing
%   triangulateFaces         - Convert face array to an array of triangular faces 
%   gridmeshToQuadmesh       - Create a quad mesh from a grid mesh
%   checkMeshAdjacentFaces   - Check if adjacent faces of a mesh have similar orientation
%   meshReduce               - Merge coplanar faces of a polyhedral mesh
%   minConvexHull            - Return the unique minimal convex hull of a set of 3D points
%
% Intersections and clipping
%   intersectLineMesh3d      - Intersection points of a 3D line with a mesh
%   polyhedronSlice          - Intersect a convex polyhedron with a plane.
%   clipMeshVertices         - Clip vertices of a surfacic mesh and remove outer faces
%   clipConvexPolyhedronHP   - Clip a convex polyhedron by a plane
%
% Typical polyhedra
%   polyhedra                - Index of classical polyhedral meshes
%   createCube               - Create a 3D mesh representing the unit cube
%   createOctahedron         - Create a 3D mesh representing an octahedron
%   createCubeOctahedron     - Create a 3D mesh representing a cube-octahedron
%   createIcosahedron        - Create a 3D mesh representing an Icosahedron.
%   createDodecahedron       - Create a 3D mesh representing a dodecahedron
%   createTetrahedron        - Create a 3D mesh representing a tetrahedron
%   createRhombododecahedron - Create a 3D mesh representing a rhombododecahedron
%   createTetrakaidecahedron - Create a 3D mesh representing a tetrakaidecahedron
%
% Less typical polyhedra
%   createSoccerBall         - Create a 3D mesh representing a soccer ball
%   createMengerSponge       - Create a cube with an inside cross removed
%   steinerPolytope          - Create a steiner polytope from a set of vectors
%
% Drawing functions
%   drawFaceNormals          - Draw normal vector of each face in a mesh
%   drawMesh                 - Draw a 3D mesh defined by vertices and faces
%
% Reading from file
%   readMesh_off             - Read mesh data stord in OFF format
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2005-11-07
% Homepage: http://matgeom.sourceforge.net/
% http://www.pfl-cepia.inra.fr/index.php?page=geom3d
% Copyright 2005 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).


% Deprecated:
%   drawPolyhedra            - draw polyhedra defined by vertices and faces
%   drawPolyhedron           - draw polyhedron defined by vertices and faces

% Others
