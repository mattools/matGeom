Changelog for library MatGeom - Geometry Library for Matlab

Tries to follow semantic versioning.

Changes are organized by release number, then by change type (added/changed/fixed),
and finally by module.

## MatGeom 1.2.2 - 2020-06-08

Main changes are improvements in drawing functions, and in the management of Euler angles.

### Added

- (geom2d) added function principalAxesTransform
- (polygons2d) added polygnSkeleton function
- (polygons2d) added clipPolyline function
- (graphs2d) added adjacencyListToEdges function
- (geom3d) added function normalizeLine3d
- (geom3d) added function fitSphere
- (geom3d) added functions drawDome and drawCapsule
- (geom3d) added function drawAngleBetweenVectors3d
- (geom3d) added drawRay3d and clipRay3d
- (meshes3d) added averageMesh function, to compute an average mesh from several mesh instances
- (meshes3d) added meshComplement
- (meshes3d) added function fillMeshFaces

### Changed

- (geom2d) fitAffineTransform2d: changed convention for source and target point sets
- (polygons2d) polygonSubcurve and polylineSubcurve now also return indices of selected vertices
- (geom3d) improvements in management of Euler Angles in rotation3dToEulerAngles and eulerAnglesToRotation3d
- (geom3d) drawCylinder can now handle multiple cylinders as numeric arrays
- (geom3d) several updates to drawing functions
- (geom3d) make some vector operations more generic about dimension
- (geom3d) fitAffineTransform3d: changed convention for source and target point sets
- (meshes3d) reading of OFF files is now faster when faces have homogeneous number of vertices
- (meshes3d) readMesh_ply.m: replaces error by warning

### Regression

- (geom2d) removed functions rad2deg and deg2rad, as they can be replced by Matlab native functions


## MatGeom 1.2.1 - 2019-09-26

Main changes are new functions for processing 3D meshes (repairing, 
simplification), and renaming of inertia ellipse/ellipsoid into equivalent 
ellipse/ellipsoid.

### Added

- (meshes3d) added meshFaceAreas.m
- (meshes3d) added removeDuplicateFaces.m, removeMeshEars.m, ensureManifoldMesh.m
- (meshes3d) added meshVertexClustering.m
- (meshes3d) added functions for detection of boundary edges and vertices
- (meshes3d) added createStellatedMesh.m
- (geom3d) added fitAffineTransform3d and registerPoints3dAffine.m
- (geom3d/geom2d) added principalAxes function (working for both 2D/3D points)
- (geom3d) added function isTransform3d (thanks to oqilipo)
- (geom3d) added function drawPlatform (thanks to oqilipo)
- (geom3d) added function drawLabels3d
- (geom3d) added functions createEdge3d, edgeLength3d, linToEdge3d
- (polygons2d) added polygonVertices
- (geom2d) added function lineToEdge
- (geom2d) updated comments in polarPoint

### Changed
- (geom3d) updated return type of drawing functions
- (geom3d) renamed inertiaEllipsoid into equivalentEllipsoid
- (polygons2d) renamed polygonInertiaEllipse into polygonEquivalentEllipse
- (geom2d) nndist now uses delaunay instead of delaunayTriangulation
- (geom2d) renamed inertiaEllipse into equivalentEllipse
- (demos) reorganized the hierarchy of demo files
- (all) several updates in documentation

### Fixed
- (geom3d) bug in orientedBox3d
- (geom2d) fixed bug in polarPoint (thanks to Chris Gorman)

Other bug fixes and comments by JuanPi Carbajal, oqilipo, Tao Zhang, "the neuromechanist", 
Robin Georg, Chris Gorman.

 
## MatGeom 1.2.0 - 2018-06-07
 
### Added

- (meshes3d) added several functions fore reading/writing 3D meshes in PLY and OFF formats
- (meshes3d) added splitMesh function to split a mesh into its connected components (thanks to oqilipo)
- (meshes3d) added concatenateMesh function (thanks to oqilipo)
- (meshes3d) added triangulatePolygonPair.m and update triangulateCurvePair.m
- (meshes3d) added distancePointMesh function
- (meshes3d) added curveToMesh
- (meshes3d) added boxToMesh (thanks to oqilipo)
- (meshes3d) added isPointInMesh
- (geom3d) added fitCircle3d and fitEllipse3d (thanks to oqilipo)
- (geom3d) added intersectThreePlanes (thanks to Roozbeh)
- (geom3d) added distPointTriangle3d
- (geom3d) added clipEdge3d
- (geom3d) added createRotationVector3d and createRotationVectorPoint3d (thanks to oqilipo)
- (geom3d) added projLineOnPlane function (thanks to oqilipo)
- (geom3d) added crossProduct3d
- (geom3d) added cylinderSurfaceArea
- (geom3d) added edgeToLine3d conversion function
- (polygons2d) add polygonInertiaEllipse.m and polygonSecondAreaMoments.m
- (polygons2d) added polygonOuterNormal and polygonCurvature functions
- (polygons2d) added resamplePolygonByLength.m and resamplePolylineByLength.m
- (polygons2d) added function boxToPolygon
- (geom3d) added some files from geom2d in private directories to prevent missing file errors
- (graphs) added clipMesh2dPolygon.m

### Changed

- (meshes3d) much faster centroid calculation for the 3D triangle mesh case
- (meshes3d) added a 'trimMesh' option to clipMeshVertices
- (meshes3d) unification of the parsing of some mesh functions
- (meshes3d) checkMeshAdjacentFaces.m: compute edge array if it is not specified
- (meshes3d) rename several functions: meshNormal -> meshVertexNormals, faceNormal -> meshFaceNormals...
- (geom3d) createScaling3d can now specifiy center of scaling
- (geom3d) added axes handle input for drawPoint3d.m
- (geom3d) distanceLines3d.m: added psb to compute coordinates of closest points on lines
- (geom2d) rewrite createBasisTransform3d.m
- (geom2d) improved accuracy of isParallel and isPerpendicular
- (geom2d) createLine can now create a line based on angle and distance to origin (thanks to Roozbeh)
- (geom2d) circleToPolygon.m and ellipseToPolygon.m now returns polygons with distinct end vertices
- (geom2d) updates in drawPoints (thanks to JuanPi)
- (geom2d) circumCenter now supports multiple points as input
- (geom2d) rewrite createBasisTransform.m
- (polygons2d) improved precision in intersectEdgePolygon
- (polygons2d) the intersectPolylines.m function does not use the private function "interX" anymore
- (graphs) replaced drawGraphFaces.m by fillGraphFaces.m and update it
- (graphs) updates centroidalVoronoi2d
- several updates in function headers
- removed some deprecated files

### Fixed

- (geom2d) fixed dependency to deprecated functions in drawShape 
- many small bugs fixed...



## Older releases

MatGeom 1.1.10 (released 2014.09.17, rev. 652)

New features:
- (geom3d) added drawEllipseCylinder
- (meshes3d) added trimMesh function, to remove unused vertices in mesh
- several bug fixes (drawArrow, removeMultipleVertices, intersectLineTriangle3d, grShortestPath...)
- general code cleanup using MLint for version 2014a


MatGeom 1.1.9 (released 2014.02.26, rev. 641)

New features:
- (geom2d) added polynomialTransform2d and fitPolynomialTransform2d
- (geom2d) added function intersectLinePolyline
- (geom3d) added isPointOnLine3d
- (graphs) added function grShortestPath, that implements the Dijkstra algorithm
- (graphs) added several utility functions: grAdjacentNodes, grEdgeLengths...
- (graphs) added functions to read and write graphs from/to text files
- (polynomialCurves2d) update function polynomialCurveSetFit, and add some demos
- various code and doc cleanup


MatGeom 1.1.8 (released 2013.10.04, rev. 627)

New features:
- geom2d: added functions drawVector and mergeClosePoints
- polygons2d: added function removeMultipleVertices, to cleanup the results
    that can be obtained from other algorithms
- polygons2d: added function contourMatrixToPolylines, to easily convert
    results from the 'contourc' function
- meshes3d: added the subdivideMesh function, that divides each triangular
    face into several smaller triangles
- meshes3d: added functions meshFacePolygons, meshFaceEdges, meshFaceNumber

Bug fixes:
- polygons2d/polygonLoops: fixed bugs related to numerical accuracy
- meshes3d/surfToMesh: fixed periodicity bug
- meshes3d/meshSurfaceArea: fixed bug for faces given as cell array

General:
- geom3d/drawSphere: improved management of input options
- meshes3d: renamed computeMeshEdges as meshEdges
- meshes3d/meshVolume: enhanced speed


MatGeom 1.1.7 (released 2013.07.03, rev. 613)

New features:
- (polygons2d) added functions for reading multiple polygons
- (polygons2d) added polygonSignature and simplifyPolygon functions
- (meshes3d) added meshAdjacencyMatrix and smoothMesh functions

Bug fixes:
- (geom2d) fixed bug in intersectEdges
- (geom3d) fixed bug in intersectRayPolygon3d
- (geom3d) renamed meshReduce to mergeCoplanarFaces
- (geom3d) fixed bug for multiple inputs in sphericalAngle
- (geom3d) fixed display bugs in drawEllipsoid
 
General:
- (geom3d) several functions now use bsxfun (thanks to Sven Holcombe)
- (geom3d) removed some dependencies to geom2d and to deprecated functions
- updates in documentation



MatGeom 1.1.6 (released 2012.11.22, rev. 596)

geom2d: 
- fixed display on specific axes
- added support for multiple inputs in parallelLine
- uses bsxfun for several functions, increasing speed

polygons2d:
- fixed self intersection of polygons
- fixed display of multiple polygons

geom3d:
- added surfToMesh, spherMesh , torusMesh and cylinderMesh functions
- added fitting of 3D line and 3D plane
- updated drawSphericalTriangle

meshes3d:
- added meshVolume function
- added intersectPlaneMesh function


MatGeom 1.1.5 (released 2012.09.04, rev. 580)

geom2d:
- added hausdorffDistance for two sets of points
- added centeredEdgeToEdge, parallelEdge
- added orientedBox of a set of points
- added conversion functions between rectangles and boxes
- added createRotation90, for more precise matrices

polygons2d:
- added simplification of polygons by Douglas-Peucker algorithm
- updated polygonArea to handle multiple polygons, update tests
- enhanced polygonContains for multiply connected polygons

geom3d:
- added new functions: parallelLine3d, parallelPlane, reverseLine3d, 
    reversePlane, and functions for projecting point on 3d line
- added planesBisector (contributed by Ben Kang)
- added boundingBox3d

meshes3d:
- added polyhedronCentroid, tetrahedronVolume
- updated triangulateFaces, intersectLineMesh3d, distancePointEdge3d
- added DurerPolyhedron



MatGeom 1.1.4 (released 2012.02.29, rev. 556)

geom2d:
- added ellipsePerimeter
- updated intersectLinePlane

polygons2d:
- added intersectEdgePolygon

graphs:
- added clipGraphPolygon
- added boundedCentroidalVoronoi2d

geom3d:
- added polygonArea3d. clean up polygonCentroid
- added distancePointEdge3d, hypot3
- added ellipsoidSurfaceArea
- added several functions for drawing spherical polygons, and computing 
    spherical voronoi domain given the set of neighbors
- fixed compatibility bug in drawCircle3d


MatGeom 1.1.3 (released 2012.01.29, rev. 541)

geom2d:
- added circumCircle and circumCenter    
- added function nndist (find nearest neighbors of points)
- added function boundingBox
- updated drawing shapes fucntions
- renames 

polygons2d:
- added functions densifyPolygon, resamplePolygon, resamplePolyline
- added triangulatePolygon (based on constrained delaunay)
- added function polygonVertices (draw polygon vertices with a different
    mark for the first one)
    
graphs:
- added gabrielGraph (keep edges of Delaunay triangulation whose circumcircle
    does not contains any other point that edge vertices)

geom3d:
- added drawVector3d
- added partial support of meshes in OFF format (readMesh_off)
- fixed bug in intersectLinePolygon3d
- fixed bug in drawing 3D edges

meshes3d:
- added function intersectLineMesh3d
- added gridmeshToQuadmesh, to convert between mesh representations
- added function vertexNormal

