% GEOM3D Geometry 3D Toolbox
% Version 1.22 06-Jun-2018 .
%
%   Creation, transformations, algorithms and visualization of geometrical
%   3D primitives, such as points, lines, planes, polyhedra, circles and
%   spheres.
%   
%   Euler Angles are defined as follow:
%   PHI is the azimut, i.e. the angle of the projection on horizontal plane
%   with the Ox axis, with value beween 0 and 180 degrees.
%   THETA is the latitude, i.e. the angle with the Oz axis, with value
%   between -90 and +90 degrees.
%   PSI is the 'roll', i.e. the rotation around the (PHI, THETA) direction,
%   with value in degrees
%   See also the 'angles3d' page.
%
%   Base format for primitives:
%   Point:      [x0 y0 z0]
%   Vector:     [dx dy dz]
%   Line:       [x0 y0 z0 dx dy dz]
%   Edge:       [x1 y1 z1 x2 y2 z2]
%   Plane:      [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2]
%   Sphere:     [x0 y0 z0 R]
%   Circle:     [x0 y0 z0 R PHI THETA PSI] (origin+center+normal+'roll').
%   Ellipsoid:  [x0 y0 z0 A B C PHI THETA PSI]
%   Cylinder:   [X1 Y1 Z1 X2 Y2 Z2 R]
%   Box:        [xmin xmax ymin ymax zmin zmax]. Used for clipping shapes.
%   
%   Polygons are represented by N-by-3 array of points, the last point is
%   not necessarily the same as the first one. Points must be coplanar.
%
%
% 3D Points
%   points3d                    - Description of functions operating on 3D points.
%   midPoint3d                  - Middle point of two 3D points or of a 3D edge.
%   isCoplanar                  - Tests input points for coplanarity in 3-space.
%   transformPoint3d            - Transform a point with a 3D affine transform.
%   distancePoints3d            - Compute euclidean distance between pairs of 3D Points.
%   clipPoints3d                - Clip a set of points by a box or other 3d shapes.
%   drawPoint3d                 - Draw 3D point on the current axis.
%
% 3D Vectors
%   vectors3d                   - Description of functions operating on 3D vectors.
%   transformVector3d           - Transform a vector with a 3D affine transform.
%   normalizeVector3d           - Normalize a 3D vector to have norm equal to 1.
%   vectorNorm3d                - Norm of a 3D vector or of set of 3D vectors.
%   hypot3                      - Diagonal length of a cuboidal 3D box .
%   crossProduct3d              - Vector cross product faster than inbuilt MATLAB cross.
%   vectorAngle3d               - Angle between two 3D vectors.
%   isParallel3d                - Check parallelism of two 3D vectors.
%   isPerpendicular3d           - Check orthogonality of two 3D vectors.
%   drawVector3d                - Draw vector at a given position.
%
% Angles
%   angles3d                    - Conventions for manipulating angles in 3D.
%   anglePoints3d               - Compute angle between three 3D points.
%   sphericalAngle              - Compute angle between points on the sphere.
%   angleSort3d                 - Sort 3D coplanar points according to their angles in plane.
%   randomAngle3d               - Return a 3D angle uniformly distributed on unit sphere.
%
% Coordinate transforms
%   sph2cart2                   - Convert spherical coordinates to cartesian coordinates.
%   cart2sph2                   - Convert cartesian coordinates to spherical coordinates.
%   cart2sph2d                  - Convert cartesian coordinates to spherical coordinates in degrees.
%   sph2cart2d                  - Convert spherical coordinates to cartesian coordinates in degrees.
%   cart2cyl                    - Convert cartesian to cylindrical coordinates.
%   cyl2cart                    - Convert cylindrical to cartesian coordinates.
%
% 3D Lines and Edges
%   lines3d                     - Description of functions operating on 3D lines.
%   edges3d                     - Description of functions operating on 3D edges.
%   createLine3d                - Create a line with various inputs.
%   createEdge3d                - Create an edge between two 3D points, or from a 3D line.
%   fitLine3d                   - Fit a 3D line to a set of points.
%   parallelLine3d              - Create 3D line parallel to another one.
%   projPointOnLine3d           - Project a 3D point orthogonally onto a 3D line.
%   distancePointLine3d         - Euclidean distance between 3D point and line.
%   isPointOnLine3d             - Test if a 3D point belongs to a 3D line.
%   distancePointEdge3d         - Minimum distance between a 3D point and a 3D edge.
%   linePosition3d              - Return the position of a 3D point projected on a 3D line.
%   distanceLines3d             - Minimal distance between two 3D lines.
%   transformLine3d             - Transform a 3D line with a 3D affine transform.
%   reverseLine3d               - Return same 3D line but with opposite orientation.
%   midPoint3d                  - Middle point of two 3D points or of a 3D edge.
%   edgeLength3d                - Return the length of a 3D edge.
%   clipEdge3d                  - Clip a 3D edge with a cuboid box.
%   lineToEdge3d                - Convert a 3D straight line to a 3D finite edge.
%   edgeToLine3d                - Convert a 3D edge to a 3D straight line.
%   clipLine3d                  - Clip a line with a box and return an edge.
%   drawEdge3d                  - Draw 3D edge in the current axes.
%   drawLine3d                  - Draw a 3D line clipped by the current axes.
%
% Planes
%   planes3d                    - Description of functions operating on 3D planes.
%   createPlane                 - Create a plane in parametrized form.
%   fitPlane                    - Fit a 3D plane to a set of points.
%   normalizePlane              - Normalize parametric representation of a plane.
%   parallelPlane               - Parallel to a plane through a point or at a given distance.
%   reversePlane                - Return same 3D plane but with opposite orientation.
%   isPlane                     - Check if input is a plane.
%   transformPlane3d            - Transform a 3D plane with a 3D affine transform.
%   planesBisector              - Bisector plane between two other planes.
%   projPointOnPlane            - Return the orthogonal projection of a point on a plane.
%   intersectPlanes             - Return intersection line between 2 planes in space.
%   intersectThreePlanes        - Return intersection point between 3 planes in space.
%   intersectLinePlane          - Intersection point between a 3D line and a plane.
%   intersectEdgePlane          - Return intersection point between a plane and a edge.
%   distancePointPlane          - Signed distance betwen 3D point and plane.
%   projLineOnPlane             - Return the orthogonal projection of a line on a plane.
%   isBelowPlane                - Test whether a point is below or above a plane.
%   medianPlane                 - Create a plane in the middle of 2 points.
%   planeNormal                 - Compute the normal to a plane.
%   planePosition               - Compute position of a point on a plane.
%   planePoint                  - Compute 3D position of a point in a plane.
%   dihedralAngle               - Compute dihedral angle between 2 planes.
%   drawPlane3d                 - Draw a plane clipped by the current axes.
%
% 3D Polygons and curves
%   polygons3d                  - Description of functions operating on 3D polygons.
%   polygonCentroid3d           - Centroid (or center of mass) of a polygon.
%   polygonArea3d               - Area of a 3D polygon.
%   polygon3dNormalAngle        - Normal angle at a vertex of the 3D polygon.
%   intersectLinePolygon3d      - Intersection point of a 3D line and a 3D polygon.
%   intersectRayPolygon3d       - Intersection point of a 3D ray and a 3D polygon.
%   clipConvexPolygon3dHP       - Clip a convex 3D polygon with Half-space.
%   drawPolygon3d               - Draw a 3D polygon specified by a list of vertex coords.
%   drawPolyline3d              - Draw a 3D polyline specified by a list of vertex coords.
%   fillPolygon3d               - Fill a 3D polygon specified by a list of vertex coords.
%
% 3D Triangles
%   triangleArea3d              - Area of a 3D triangle.
%   distancePointTriangle3d     - Minimum distance between a 3D point and a 3D triangle.
%   intersectLineTriangle3d     - Intersection point of a 3D line and a 3D triangle.
%
% 3D circles and ellipses
%   circles3d                   - Description of functions operating on 3D circles.
%   fitCircle3d                 - Fit a 3D circle to a set of points.
%   circle3dPosition            - Return the angular position of a point on a 3D circle.
%   circle3dPoint               - Coordinates of a point on a 3D circle from its position.
%   circle3dOrigin              - Return the first point of a 3D circle.
%   drawCircle3d                - Draw a 3D circle.
%   drawCircleArc3d             - Draw a 3D circle arc.
%   drawEllipse3d               - Draw a 3D ellipse.
%
% Spheres
%   spheres                     - Description of functions operating on 3D spheres.
%   createSphere                - Create a sphere containing 4 points.
%   intersectLineSphere         - Return intersection points between a line and a sphere.
%   intersectPlaneSphere        - Return intersection circle between a plane and a sphere.
%   drawSphere                  - Draw a sphere as a mesh.
%   drawSphericalEdge           - Draw an edge on the surface of a sphere.
%   drawSphericalTriangle       - Draw a triangle on a sphere.
%   fillSphericalTriangle       - Fill a triangle on a sphere.
%   drawSphericalPolygon        - Draw a spherical polygon.
%   fillSphericalPolygon        - Fill a spherical polygon.
%   sphericalVoronoiDomain      - Compute a spherical voronoi domain.
%
% Smooth surfaces
%   equivalentEllipsoid         - Equivalent ellipsoid of a set of 3D points.
%   fitEllipse3d                - Fit an ellipse to a set of points.
%   ellipsoidSurfaceArea        - Approximated surface area of an ellipsoid.
%   oblateSurfaceArea           - Approximated surface area of an oblate ellipsoid.
%   prolateSurfaceArea          - Approximated surface area of a prolate ellipsoid.
%   cylinderSurfaceArea         - Surface area of a cylinder.
%   intersectLineCylinder       - Compute intersection points between a line and a cylinder.
%   revolutionSurface           - Create a surface of revolution from a planar curve.
%   surfaceCurvature            - Curvature on a surface from angle and principal curvatures.
%   drawEllipsoid               - Draw a 3D ellipsoid.
%   drawTorus                   - Draw a torus (3D ring).
%   drawCylinder                - Draw a cylinder.
%   drawEllipseCylinder         - Draw a cylinder with ellipse cross-section.
%   drawSurfPatch               - Draw a 3D surface patch, with 2 parametrized surfaces.
%
% Bounding boxes management
%   boxes3d                     - Description of functions operating on 3D boxes.
%   boundingBox3d               - Bounding box of a set of 3D points.
%   orientedBox3d               - Object-oriented bounding box of a set of 3D points.
%   intersectBoxes3d            - Intersection of two 3D bounding boxes.
%   mergeBoxes3d                - Merge 3D boxes, by computing their greatest extent.
%   box3dVolume                 - Volume of a 3-dimensional box.
%   randomPointInBox3d          - Generate random point(s) within a 3D box.
%   drawBox3d                   - Draw a 3D box defined by coordinate extents.
%
% Geometric transforms
%   transforms3d                - Conventions for manipulating 3D affine transforms.
%   fitAffineTransform3d        - Fit an affine transform using two point sets.
%   registerPoints3dAffine      - Fit 3D affine transform using iterative algorithm.
%   createTranslation3d         - Create the 4x4 matrix of a 3D translation.
%   createScaling3d             - Create the 4x4 matrix of a 3D scaling.
%   createRotationOx            - Create the 4x4 matrix of a 3D rotation around x-axis.
%   createRotationOy            - Create the 4x4 matrix of a 3D rotation around y-axis.
%   createRotationOz            - Create the 4x4 matrix of a 3D rotation around z-axis.
%   createBasisTransform3d      - Compute matrix for transforming a basis into another basis.
%   eulerAnglesToRotation3d     - Convert 3D Euler angles to 3D rotation matrix.
%   isTransform3d               - Check if input is a affine transformation matrix.
%   rotation3dToEulerAngles     - Extract Euler angles from a rotation matrix.
%   createRotation3dLineAngle   - Create rotation around a line by an angle theta.
%   rotation3dAxisAndAngle      - Determine axis and angle of a 3D rotation matrix.
%   createRotationVector3d      - Calculates the rotation between two vectors.
%   createRotationVectorPoint3d - Calculates the rotation between two vectors.
%   recenterTransform3d         - Change the fixed point of an affine 3D transform.
%   composeTransforms3d         - Concatenate several space transformations.
%
% Various drawing Functions
%   drawGrid3d                  - Draw a 3D grid on the current axis.
%   drawAxis3d                  - Draw a coordinate system and an origin.
%   drawAxisCube                - Draw a colored cube representing axis orientation.
%   drawCube                    - Draw a 3D centered cube, eventually rotated.
%   drawCuboid                  - Draw a 3D cuboid, eventually rotated.
%   drawPlatform                - Draw a rectangular platform with a given size.
%   drawLabels3d                - Draw text labels at specified 3D positions.
%
%
%   Credits:
%   * Several functions contributed by Sven Holcombe
%   * function isCoplanar was originally written by Brett Shoelson.
%   * Songbai Ji enhanced file intersectPlaneLine (6/23/2006).
%   * several functions contributed by oqilipo
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2005-11-07
% Homepage: http://github.com/mattools/matGeom
% http://www.pfl-cepia.inra.fr/index.php?page=geom3d
% Copyright 2005 INRA

% In development:
%   clipPolygon3dHP             - clip a 3D polygon with Half-space.
%   drawPartialPatch            - draw surface patch, with 2 parametrized surfaces.

% Deprecated:
%   vectorCross3d               - Vector cross product faster than inbuilt MATLAB cross.
%   inertiaEllipsoid            - Inertia ellipsoid of a set of 3D points.

% Others


