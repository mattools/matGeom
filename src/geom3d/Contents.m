% GEOM3D Geometry 3D Toolbox
% Version 0.5 11-Apr-2010 .
%
%   Creation, transformations, algorithms and visualization of geometrical
%   3D primitives, such as points, lines, planes, polyhedra, circles and
%   spheres.
%   
%   Angles are defined as follow:
%   THETA is the colatitude, i.e. the angle with the Oz axis, with value
%   between 0 and PI radians.
%   PHI is the azimut, i.e. the angle of the projection on horizontal plane
%   with the Ox axis, with value beween 0 and 2*PI radians.
%   PSI is the 'roll', i.e. the rotation around the (THETA, PHI) direction,
%   with value in radians
%   See also the 'angles3d' page.
%
%   Base format for primitives:
%   Point:      [x0 y0 z0]
%   Vector:     [dx dy dz]
%   Line:       [x0 y0 z0 dx dy dz]
%   Edge:       [x1 y1 z1 x2 y2 z2]
%   Plane:      [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2]
%   Sphere:     [x0 y0 z0 R]
%   Circle:     [x0 y0 z0 R THETA PHI PSI] (origin+center+normal+'roll').
%   Cylinder:   [X1 Y1 Z1 X2 Y2 Z2 R]
%   Box:        [xmin xmax ymin ymax zmin zmax]. Used for clipping shapes.
%   
%   Polygons are represented by N-by-3 array of points, the last point is
%   not necessarily the same as the first one. Points must be coplanar.
%
%   Meshes and Polyhedra are represented by a couple of variables {V, F}:
%   V: N-by-3 array of vetrtices: [x1 y1 z1; ... ;xn yn zn];
%   F: is either a [Nf*3] or [Nf*4] array containing reference for vertices
%       of each face, or a [Nf*1] cell array, where each cell is an array
%       containing a variable number of node indices.
%   For some functions, the array E of edges is needed. It consists in a
%   Ne-by-2 array containing indices of source and target vertices. 
%
%
% 3D Points
%   points3d                  - Description of functions operating on 3D points
%   midPoint3d                - Middle point of two 3D points or of a 3D edge
%   isCoplanar                - Tests input points for coplanarity in 3-space.
%   transformPoint3d          - transform a point with a 3D affine transform
%   distancePoints3d          - compute euclidean distance between 3D Points
%   clipPoints3d              - clip a set of points by a box
%
% 3D Vectors
%   vectors3d                 - Description of functions operating on 3D vectors
%   transformVector3d         - transform a vector with a 3D affine transform
%   normalizeVector3d         - normalize a 3D vector
%   vectorNorm3d              - Norm of a 3D vector or of set of 3D vectors
%   vectorAngle3d             - Angle between two 3D vectors
%   isParallel3d              - check parallelism of two vectors
%   isPerpendicular3d         - check orthogonality of two vectors
%
% Angles
%   angles3d                  - Conventions for manipulating angles in 3D
%   anglePoints3d             - Compute angle between three 3D points
%   sphericalAngle            - compute angle on the sphere
%   angleSort3d               - sort 3D coplanar points according to their angles in plane
%   randomAngle3d             - return a 3D angle uniformly distributed on unit sphere
%
% Coordinate transforms
%   sph2cart2                 - Convert spherical coordinates to cartesian coordinates
%   cart2sph2                 - Convert cartesian coordinates to spherical coordinates
%   cart2cyl                  - Convert cartesian to cylindrical coordinates
%   cyl2cart                  - Convert cylindrical to cartesian coordinates
%
% 3D Lines and Edges
%   lines3d                   - Description of functions operating on 3D lines
%   createLine3d              - create a line with various inputs.
%   transformLine3d           - transform a 3D line with a 3D affine transform
%   clipLine3d                - clip a line with a box and return an edge
%   midPoint3d                - Middle point of two 3D points or of a 3D edge
%   distancePointLine3d       - Euclidean distance between 3D point and line
%   distanceLines3d           - Minimal distance between two 3D lines
%   linePosition3d            - return position of a 3D point on a 3D line
%
% Planes
%   planes3d                  - Description of functions operating on 3D planes
%   medianPlane               - create a plane in the middle of 2 points
%   createPlane               - Create a plane in parametrized form
%   normalizePlane            - normalize parametric form of a plane
%   intersectPlanes           - return intersection between 2 planes in space
%   projPointOnPlane          - return the projection of a point on a plane
%   isBelowPlane              - test whether a point is below or above a plane
%   intersectLinePlane        - return intersection between a plane and a line
%   intersectEdgePlane        - return intersection between a plane and a edge
%   distancePointPlane        - Signed distance betwen 3D point and plane
%   planeNormal               - compute the normal to a plane
%   planePosition             - compute position of a point on a plane
%   planePoint                - compute 3D position of a point in a plane
%   dihedralAngle             - compute dihedral angle between 2 planes
%
% 3D Polygons
%   polygons3d                - Description of functions operating on 3D polygons
%   polygonCentroid3d         - Centroid (or center of mass) of a polygon
%   polygon3dNormalAngle      - compute normal angle at a vertex of the 3D polygon
%
% Other shapes
%   circles3d                 - description of functions operating on 3D lines
%   circle3dPosition          - return the angular position of a point on a 3D circle
%   circle3dOrigin            - return the first point of a 3D circle
%   spheres                   - description of functions operating on 3D spheres
%   createSphere              - create a sphere containing 4 points
%   intersectLineSphere       - return intersection between a line and a sphere
%   intersectLineCylinder     - Compute intersections between a line and a cylinder
%   intersectPlaneSphere      - return intersection between a plane and a sphere
%   revolutionSurface         - Create a surface of revolution from a planar curve
%   surfaceCurvature          - compute curvature on a surface in a given direction 
%
% Geometric transforms
%   transforms3d              - Conventions for manipulating 3D affine transforms
%   createTranslation3d       - return 4x4 matrix of a 3D translation
%   createScaling3d           - return 4x4 matrix of a 3D scaling
%   createRotationOx          - return 4x4 matrix of a rotation around x-axis
%   createRotationOy          - return 4x4 matrix of a rotation around y-axis
%   createRotationOz          - return 4x4 matrix of a rotation around z-axis
%   createEulerAnglesRotation - Create a rotation matrix from 3 euler angles
%   createRotation3dLineAngle - Create rotation around a line by an angle theta
%   rotation3dAxisAndAngle    - Determine axis and angle of a 3D rotation matrix
%   rotation3dToEulerAngles   - Extract Euler angles from a rotation matrix
%   recenterTransform3d       - Change the fixed point of an affine 3D transform
%   createBasisTransform3d    - Compute matrix for transforming a basis into another basis
%   composeTransforms3d       - concatenate several space transformations
%
% Bounding boxes management
%   boxes3d                   - Description of functions operating on 3D boxes
%   point3dBounds             - Bounding box of a set of 3D points
%   intersectBoxes3d          - Intersection of two 3D bounding boxes
%   mergeBoxes3d              - Merge 3D boxes, by computing their greatest extent
%   box3dVolume               - Volume of a 3-dimensional box
%
% Drawing Functions
%   drawPoint3d               - Draw 3D point on the current axis.
%   drawEdge3d                - Draw 3D edge in the current Window
%   drawBox3d                 - Draw a 3D box defined by coordinate extents
%   drawPolyline3d            - Draw a 3D polyline specified by a list of points
%   drawLine3d                - draw the line in the current Window
%   drawPlane3d               - draw a plane clipped in the current window
%   drawCircle3d              - draw a 3D circle
%   drawCircleArc3d           - draw a 3D circle arc
%   drawCylinder              - Draw a cylinder
%   drawSphere                - Draw a sphere as a mesh
%   drawSphericalTriangle     - draw a triangle on a sphere
%   drawSurfPatch             - draw surface patch, with 2 parametrized surfaces
%   drawGrid3d                - draw a grid in 3 dimensions
%   fillPolygon3d             - Fill a 3D polygon specified by a list of points
%   drawAxis3d                - Draw a coordinate system and an origin
%   drawAxisCube              - Draw a colored cube representing axis orientation
%
%
%   Credits:
%   * function isCoplanar was originally written by Brett Shoelson.
%   * Songbai Ji enhanced file intersectPlaneLine (6/23/2006).
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% http://www.pfl-cepia.inra.fr/index.php?page=geom3d
% Created: 2005-11-07
% Copyright 2005 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

% In development:
%   clipPolygon3dHP           - clip a 3D polygon with Half-space
%   drawEllipse3d             - draw a 3D ellipse
%   drawPartialPatch          - draw surface patch, with 2 parametrized surfaces
%   createOblicProjectionXZ   - Create oblic projection for perspective display

% Deprecated:
%   intersectPlaneLine        - return intersection between a plane and a line
%   translation3d             - return 4x4 matrix of a 3D translation
%   scale3d                   - return 4x4 matrix of a 3D scaling
%   rotationOx                - return 4x4 matrix of a rotation around x-axis
%   rotationOy                - return 4x4 matrix of a rotation around y-axis
%   rotationOz                - return 4x4 matrix of a rotation around z-axis
%   scaling3d                 - return 4x4 matrix of a 3D scaling
%   vecnorm3d                 - compute norm of vector or of set of 3D vectors
%   normalize3d               - normalize a 3D vector
%   drawCurve3d               - draw a 3D curve specified by a list of points

% Others
