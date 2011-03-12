% GEOM2D Geometry 2D Toolbox
% Version 0.5 11-Apr-2010 .
%
% 	Library to handle and visualize geometric primitives such as points,
% 	lines, circles and ellipses, polygons...
%
%   The goal is to provide a low-level library for manipulating geometrical
%   primitives, making easier the development of more complex geometric
%   algorithms. 
%
%   Most functions works for planar shapes, but some ones have been
%   extended to 3D or to any dimension.
%
% Points
%   points2d             - Description of functions operating on points
%   clipPoints           - Clip a set of points by a box
%   centroid             - Compute centroid (center of mass) of a set of points
%   midPoint             - Middle point of two points or of an edge
%   isCounterClockwise   - Compute relative orientation of 3 points
%   polarPoint           - Create a point from polar coordinates (rho + theta)
%   angle2Points         - Compute horizontal angle between 2 points
%   angle3Points         - Compute oriented angle made by 3 points
%   angleSort            - Sort points in the plane according to their angle to origin
%   distancePoints       - Compute distance between two points
%   minDistancePoints    - Minimal distance between several points
%
% Vectors
%   vectors2d            - Description of functions operating on plane vectors
%   createVector         - Create a vector from two points
%   vectorNorm           - compute norm of vector or of set of vectors
%   vectorAngle          - Compute angle of a vector with horizontal axis
%   normalizeVector      - normalize a vector
%   isPerpendicular      - check orthogonality of two vectors
%   isParallel           - check parallelism of two vectors
%
% Straight lines
%   lines2d              - Description of functions operating on planar lines
%   createLine           - create a line with various inputs.
%   medianLine           - Create a median line between two points
%   cartesianLine        - create a line with cartesian coefficients
%   orthogonalLine       - Create a line orthogonal to another one.
%   parallelLine         - create a line parallel to another one.
%   intersectLines       - Return all intersection points of N lines in 2D
%   lineAngle            - Computes angle between two straight lines
%   linePosition         - return position of a point on a line
%   lineFit              - least mean square line regression
%   clipLine             - clip a line with a box
%   reverseLine          - return same line but with opposite orientation
%
% Edges (line segments between 2 points)
%   edges2d              - Description of functions operating on planar edges
%   createEdge           - create an edge between two points, or from a line
%   edgeToLine           - convert an edge to a straight line
%   edgeAngle            - return angle of edge
%   edgeLength           - return length of an edge
%   midPoint             - Middle point of two points or of an edge
%   edgePosition         - return position of a point on an edge
%   clipEdge             - clip an edge with a rectangular box
%   reverseEdge          - Interverts source and target vertices of edge
%   intersectEdges       - return all intersections points of N edges in 2D
%   intersectLineEdge    - return intersection between a line and an edge
%
% Rays
%   rays2d               - Description of functions operating on planar rays
%   createRay            - create a ray (half-line)
%   bisector             - return the bisector of two lines, or 3 points
%   clipRay              - Clip a ray with a box
%
% Relations between points and lines
%   distancePointEdge    - compute distance between a point and an edge
%   distancePointLine    - compute distance between a point and a line
%   projPointOnLine      - return the projection of a point on a line
%   pointOnLine          - create a point on a line at a given distance from line origin
%   isPointOnLine        - Tests if a point belongs to a line
%   isPointOnEdge        - test if a point belongs to an edge
%   isPointOnRay         - test if a point belongs to a ray
%   isLeftOriented       - Tests if a point is on the left side of a line
%
% Circles and Ellipses
%   circles2d            - Description of functions operating on circles
%   createCircle         - Create a circle from 2 or 3 points
%   createDirectedCircle - Create a directed circle
%   intersectCircles     - Intersection points of two circles
%   intersectLineCircle  - Intersection point(s) of a line and a circle
%   circleAsPolygon      - convert a circle into a series of points
%   circleArcAsCurve     - convert a circle arc into a series of points
%   isPointInCircle      - Check if a point is located inside a given circle
%   isPointOnCircle      - test if a point is located on a given circle.
%   inertiaEllipse       - Inertia ellipse of a set of points
%   isPointInEllipse     - Check if a point is located inside a given ellipse
%   ellipseAsPolygon     - convert an ellipse into a series of points
%   enclosingCircle      - find the minimum circle enclosing a set of points.
%   radicalAxis          - compute the radical axis (or radical line) of 2 circles
%
% Other shapes
%   squareGrid           - generate equally spaces points in plane.
%   hexagonalGrid        - generate hexagonal grid of points in the plane.
%   triangleGrid         - generate triangular grid of points in the plane.
%   crackPattern         - create a (bounded) crack pattern tessellation
%   crackPattern2        - create a (bounded) crack pattern tessellation
%
% Geometric transforms
%   transforms2d         - Description of functions operating on transforms
%   createTranslation    - return 3*3 matrix of a translation
%   createRotation       - return 3*3 matrix of a rotation
%   createScaling        - return 3*3 matrix of a scaling in 2 dimensions
%   createHomothecy      - create a homothecy as an affine transform
%   createBasisTransform - Compute matrix for transforming a basis into another basis
%   createLineReflection - create line reflection as 2D affine transform
%   fitAffineTransform2d - fit an affine transform using two point sets
%   transformPoint       - transform a point with an affine transform
%   transformVector      - transform a vector with an affine transform
%   transformEdge        - transform an edge with an affine transform
%   transformLine        - transform a line with an affine transform
%
% Angles
%   angles2d             - Description of functions for manipulating angles
%   normalizeAngle       - Normalize an angle value within a 2*PI interval
%   deg2rad              - Convert angle from degrees to radians
%   rad2deg              - Convert angle from radians to degrees
%
% Boxes
%   boxes2d              - Conventions for using bounding boxes
%   intersectBoxes       - Intersection of two bounding boxes
%   mergeBoxes           - Merge two boxes, by computing their greatest extent
%
% Drawing functions
%   drawPoint            - draw the point on the axis.
%   drawLine             - draw the line on the current axis
%   drawRay              - draw a ray on the current axis
%   drawEdge             - draw the edge given by 2 points
%   drawCenteredEdge     - draw an edge centered on a point
%   drawBox              - Draw a box defined by coordinate extents
%   drawCircle           - draw a circle on the current axis
%   drawCircleArc        - draw a circle arc on the current axis
%   drawEllipse          - draw an ellipse on the current axis
%   drawEllipseArc       - Draw an ellipse arc on the current axis
%   drawParabola         - Draw a parabola on the current axis
%   drawArrow            - draw an arrow on the current axis
%   drawLabels           - draw labels at specified positions
%   drawShape            - draw various types of shapes (circles, polygons ...)
%
%
%   Credits:
%   * function 'enclosingCircle' rewritten from a file from Yazan Ahed
%       (yash78@gmail.com), available on Matlab File Exchange
%
% -----
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% created the  07/11/2005.
% Copyright INRA - Cepia Software Platform.
% http://www.pfl-cepia.inra.fr/index.php?page=geom2d

help('Contents');


%%   Deprecated functions

%   createMedian         - create a median line
%   minDistance          - compute minimum distance between a point and a set of points
%   homothecy            - create a homothecy as an affine transform
%   rotation             - return 3*3 matrix of a rotation
%   translation          - return 3*3 matrix of a translation
%   scaling              - return 3*3 matrix of a scaling in 2 dimensions
%   lineSymmetry         - create line symmetry as 2D affine transform
%   vecnorm              - compute norm of vector or of set of vectors
%   normalize            - normalize a vector
%   onCircle             - test if a point is located on a given circle.
%   inCircle             - test if a point is located inside a given circle.
%   onEdge               - test if a point belongs to an edge
%   onLine               - test if a point belongs to a line
%   onRay                - test if a point belongs to a ray
%   invertLine           - return same line but with opposite orientation
%   clipLineRect         - clip a line with a polygon
%   formatAngle          - Ensure an angle value is comprised between 0 and 2*PI


%% Others...

