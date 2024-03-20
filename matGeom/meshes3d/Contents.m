%CONTENTS MESHES3D 3D Surface Meshes.
% Version 1.22 06-Jun-2018.
%
%   Creation, visualization, and manipulation of 3D surface meshes or
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
%   The library provides function to create basic polyhedric meshes (the
%   five platonic solids, plus few others), as well as functions to perform
%   basic computations (surface area, normal angles, face centroids...).
%   The 'MengerSponge' structure is an example of mesh that is not simply
%   connected (multiple tunnels in the structure).
%
%   The drawMesh function is mainly a wrapper to the Matlab 'patch'
%   function, allowing passing arguments more quickly.
%
%   Example
%     % create a soccer ball mesh and display it
%     [v, e, f] = createSoccerBall;
%     drawMesh(v, f, 'faceColor', 'g', 'linewidth', 2);
%     axis equal; view(3);
%  
%
% General processing on meshes
%   smoothMesh                  - Smooth mesh by replacing each vertex by the average of its neighbors.
%   subdivideMesh               - Subdivides each face of the mesh.
%   meshVertexClustering        - Simplifies a mesh using vertex clustering.
%   triangulateFaces            - Convert face array to an array of triangular faces.
%   transformMesh               - Applies a 3D affine transform to a mesh.
%   mergeCoplanarFaces          - Merge coplanar faces of a polyhedral mesh.
%   meshFacePolygons            - Returns the set of polygons that constitutes a mesh.
%   meshFaceCentroids           - Compute centroids of faces in a mesh.
%   meshFaceNormals             - Compute normal vector of faces in a 3D mesh.
%   meshVertexNormals           - Compute normals to a mesh vertices.
%   meshComplement              - Reverse the normal of each face in the mesh.
%   averageMesh                 - Compute average mesh from a list of meshes.
%   meshSilhouette              - Compute the 2D outline of a 3D mesh on an arbitrary plane.
%   meshVoronoiDiagram          - Voronoi Diagram on the surface of a polygonal mesh.
%
% Intersections and clipping
%   intersectLineMesh3d         - Intersection points of a 3D line with a mesh.
%   intersectEdgeMesh3d         - Intersection points of a 3D edge with a mesh.
%   intersectPlaneMesh          - Compute the polygons resulting from plane-mesh intersection.
%   polyhedronSlice             - Intersect a convex polyhedron with a plane.
%   clipMeshByPlane             - Clip a mesh by a plane.
%   clipMeshVertices            - Clip vertices of a surfacic mesh and remove outer faces.
%   clipConvexPolyhedronByPlane - Clip a convex polyhedron by a plane.
%   cutMeshByPlane              - Cut a mesh by a plane.
%   concatenateMeshes           - Concatenate multiple meshes.
%   splitMesh                   - Return the connected components of a mesh.
%
% Geometric measures on meshes
%   meshSurfaceArea             - Surface area of a polyhedral mesh.
%   trimeshSurfaceArea          - Surface area of a triangular mesh.
%   meshFaceAreas               - Surface area of each face of a mesh.
%   meshVolume                  - (Signed) volume of the space enclosed by a polygonal mesh.
%   meshCurvatures              - Compute principal curvatures on mesh vertices.
%   meshEdgeLength              - Lengths of edges of a polygonal or polyhedral mesh.
%   meshDihedralAngles          - Dihedral at edges of a polyhedal mesh.
%   polyhedronCentroid          - Compute the centroid of a 3D convex polyhedron.
%   tetrahedronVolume           - Signed volume of a tetrahedron.
%   polyhedronNormalAngle       - Compute normal angle at a vertex of a 3D polyhedron.
%   polyhedronMeanBreadth       - Mean breadth of a convex polyhedron.
%   trimeshMeanBreadth          - Mean breadth of a triangular mesh.
%   isPointInMesh               - Check if a point is inside a 3D mesh.
%   distancePointMesh           - Shortest distance between a (3D) point and a triangle mesh.
%
% Utility functions
%   meshFace                    - Return the vertex indices of a face in a mesh.
%   meshFaceEdges               - Computes edge indices of each face.
%   meshFaceNumber              - Returns the number of faces in this mesh.
%   meshEdges                   - Computes array of edge vertex indices from face array.
%   meshEdgeFaces               - Compute index of faces adjacent to each edge of a mesh.
%   trimeshEdgeFaces            - Compute index of faces adjacent to each edge of a triangular mesh.
%   meshFaceAdjacency           - Compute adjacency list of face around each face.
%   meshAdjacencyMatrix         - Compute adjacency matrix of a mesh from set of faces.
%   checkMeshAdjacentFaces      - Check if adjacent faces of a mesh have similar orientation.
%   meshBoundary                - Boundary of a mesh as a collection of 3D line strings.
%   meshBoundaryEdges           - Determine the boundary edges of a mesh.
%   meshBoundaryEdgeIndices     - Indices of boundary edges of a mesh.
%   meshBoundaryVertexIndices   - Indices of boundary vertices of a mesh.
%   smoothMeshFunction          - Apply smoothing on a functions defines on mesh vertices.
%
% Basic edition on meshes
%   removeMeshVertices          - Remove vertices and associated faces from a mesh.
%   mergeMeshVertices           - Merge two vertices and removes eventual degenerated faces.
%   removeMeshFaces             - Remove faces from a mesh by face indices.
%
% Mesh cleanup
%   trimMesh                    - Reduce memory footprint of a polygonal mesh.
%   isManifoldMesh              - Check whether the input mesh may be considered as manifold.
%   ensureManifoldMesh          - Apply several simplification to obtain a manifold mesh.
%   removeDuplicateFaces        - Remove duplicate faces in a face array.
%   removeDuplicateVertices     - Remove duplicate vertices of a mesh.
%   removeUnreferencedVertices  - Remove unreferenced vertices of a mesh.
%   removeMeshEars              - Remove vertices that are connected to only one face.
%   removeInvalidBorderFaces    - Remove faces whose edges are connected to 3, 3, and 1 faces.
%   collapseEdgesWithManyFaces  - Remove mesh edges adjacent to more than two faces.
%
% Creation and conversion
%   surfToMesh                  - Convert surface grids into face-vertex mesh.
%   triangulateCurvePair        - Compute triangulation between a pair of 3D open curves.
%   triangulatePolygonPair3d    - Compute a triangulation between a pair of 3D polygons.
%   triangulatePolygonPair      - Compute triangulation between a pair of 3D closed curves.
%   circleMesh                  - Create a mesh defined by a 3D circle.
%   cylinderMesh                - Create a 3D mesh representing a cylinder.
%   sphereMesh                  - Create a 3D mesh representing a sphere.
%   ellipsoidMesh               - Convert a 3D ellipsoid to face-vertex mesh representation.
%   torusMesh                   - Create a 3D mesh representing a torus.
%   curveToMesh                 - Create a mesh surrounding a 3D curve.
%   boxToMesh                   - Convert a box into a quad mesh with the same size.
%   minConvexHull               - Return the unique minimal convex hull of a set of 3D points.
%
% Create meshes representing polyhedra
%   polyhedra                   - Index of classical polyhedral meshes.
%   createCube                  - Create a 3D mesh representing the unit cube.
%   createOctahedron            - Create a 3D mesh representing an octahedron.
%   createCubeOctahedron        - Create a 3D mesh representing a cube-octahedron.
%   createIcosahedron           - Create a 3D mesh representing an Icosahedron.
%   createDodecahedron          - Create a 3D mesh representing a dodecahedron.
%   createTetrahedron           - Create a 3D mesh representing a tetrahedron.
%   createRhombododecahedron    - Create a 3D mesh representing a rhombododecahedron.
%   createTetrakaidecahedron    - Create a 3D mesh representing a tetrakaidecahedron.
%   createSoccerBall            - Create a 3D mesh representing a soccer ball.
%   createStellatedMesh         - Replaces each face of a mesh by a pyramid.
%   createDurerPolyhedron       - Create a mesh representing Durer's polyhedron .
%   createMengerSponge          - Create a cube with an inside cross removed.
%   steinerPolytope             - Create a steiner polytope from a set of vectors.
%
% Drawing functions
%   drawMesh                    - Draw a 3D mesh defined by vertex and face arrays.
%   drawPolyhedron              - Draw polyhedron defined by vertices and faces.
%   fillMeshFaces               - Fill the faces of a mesh with the specified colors.
%   drawFaceNormals             - Draw normal vector of each face in a mesh.
%
% I/O functions
%   readMesh                    - Read a 3D mesh by inferring format from file name.
%   writeMesh                   - Write 3D mesh data by inferring format from file name.
%   readMesh_off                - Read mesh data stored in OFF format.
%   readMesh_obj                - Read mesh data stored in OBJ format.
%   readMesh_ply                - Read mesh data stored in PLY (Stanford triangle) format.
%   readMesh_stl                - Read mesh data stored in STL format.
%   writeMesh_off               - Write a mesh into a text file in OFF format.
%   writeMesh_ply               - Write a mesh into a file in PLY format.
%   writeMesh_stl               - Write mesh data in the STL format.
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2005-11-07
% Copyright 2005-2023 INRAE

help(mfilename);
