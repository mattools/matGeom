% GEOM2D Geometry 2D Toolbox
% Version 1.0 21-Mar-2011 .
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
%   points2d              - Description of functions operating on points
%   clipPoints            - Clip a set of points by a box
%   centroid              - Compute centroid (center of mass) of a set of points
%   boundingBox           - Bounding box of a set of points
%   midPoint              - Middle point of two points or of an edge
%   circumCenter          - Circumcenter of three points
%   isCounterClockwise    - Compute relative orientation of 3 points
%   polarPoint            - Create a point from polar coordinates (rho + theta)
%   angle2Points          - Compute horizontal angle between 2 points
%   angle3Points          - Compute oriented angle made by 3 points
%   angleSort             - Sort points in the plane according to their angle to origin
%   distancePoints        - Compute distance between two points
%   minDistancePoints     - Minimal distance between several points
%   nndist                - Nearest-neighbor distances of each point in a set
%   transformPoint        - Transform a point with an affine transform
%   drawPoint             - Draw the point on the axis.
%
% Vectors
%   vectors2d             - Description of functions operating on plane vectors
%   createVector          - Create a vector from two points
%   vectorNorm            - Compute norm of a vector, or of a set of vectors
%   vectorAngle           - Angle of a vector, or between 2 vectors
%   normalizeVector       - Normalize a vector to have norm equal to 1
%   isPerpendicular       - Check orthogonality of two vectors
%   isParallel            - Check parallelism of two vectors
%   transformVector       - Transform a vector with an affine transform
%   rotateVector          - Rotate a vector by a given angle
%
% Straight lines
%   lines2d               - Description of functions operating on planar lines
%   createLine            - Create a straight line from 2 points, or from other inputs
%   medianLine            - Create a median line between two points
%   cartesianLine         - Create a straight line from cartesian equation coefficients
%   orthogonalLine        - Create a line orthogonal to another one.
%   parallelLine          - Create a line parallel to another one.
%   intersectLines        - Return all intersection points of N lines in 2D
%   lineAngle             - Computes angle between two straight lines
%   linePosition          - Position of a point on a line
%   lineFit               - Fit a straight line to a set of points
%   clipLine              - Clip a line with a box
%   reverseLine           - Return same line but with opposite orientation
%   transformLine         - Transform a line with an affine transform
%   drawLine              - Draw the line on the current axis
%
% Edges (line segments between 2 points)
%   edges2d               - Description of functions operating on planar edges
%   createEdge            - Create an edge between two points, or from a line
%   edgeToLine            - Convert an edge to a straight line
%   edgeAngle             - Return angle of edge
%   edgeLength            - Return length of an edge
%   midPoint              - Middle point of two points or of an edge
%   edgePosition          - Return position of a point on an edge
%   clipEdge              - Clip an edge with a rectangular box
%   reverseEdge           - Intervert the source and target vertices of edge
%   intersectEdges        - Return all intersections between two set of edges
%   intersectLineEdge     - Return intersection between a line and an edge
%   transformEdge         - Transform an edge with an affine transform
%   edgeToPolyline        - Convert an edge to a polyline with a given number of segments
%   drawEdge              - Draw an edge given by 2 points
%   drawCenteredEdge      - Draw an edge centered on a point
%
% Rays
%   rays2d                - Description of functions operating on planar rays
%   createRay             - Create a ray (half-line), from various inputs
%   bisector              - Return the bisector of two lines, or 3 points
%   clipRay               - Clip a ray with a box
%   drawRay               - Draw a ray on the current axis
%
% Relations between points and lines
%   distancePointEdge     - Minimum distance between a point and an edge
%   distancePointLine     - Minimum distance between a point and a line
%   projPointOnLine       - Project of a point orthogonally onto a line
%   pointOnLine           - Create a point on a line at a given position on the line
%   isPointOnLine         - Test if a point belongs to a line
%   isPointOnEdge         - Test if a point belongs to an edge
%   isPointOnRay          - Test if a point belongs to a ray
%   isLeftOriented        - Test if a point is on the left side of a line
%
% Circles
%   circles2d             - Description of functions operating on circles
%   createCircle          - Create a circle from 2 or 3 points
%   createDirectedCircle  - Create a directed circle
%   intersectCircles      - Intersection points of two circles
%   intersectLineCircle   - Intersection point(s) of a line and a circle
%   circleToPolygon       - Convert a circle into a series of points
%   circleArcToPolyline   - Convert a circle arc into a series of points
%   isPointInCircle       - Test if a point is located inside a given circle
%   isPointOnCircle       - Test if a point is located on a given circle.
%   enclosingCircle       - Find the minimum circle enclosing a set of points.
%   radicalAxis           - Compute the radical axis (or radical line) of 2 circles
%   drawCircle            - Draw a circle on the current axis
%   drawCircleArc         - Draw a circle arc on the current axis
%   circumCircle          - Circumscribed circle of a triangle
%
% Ellipses and Parabola
%   ellipses2d            - Description of functions operating on ellipses
%   inertiaEllipse        - Inertia ellipse of a set of points
%   isPointInEllipse      - Check if a point is located inside a given ellipse
%   ellipsePerimeter      - Perimeter of an ellipse
%   ellipseToPolygon      - Convert an ellipse into a series of points
%   drawEllipse           - Draw an ellipse on the current axis
%   drawEllipseArc        - Draw an ellipse arc on the current axis
%   drawParabola          - Draw a parabola on the current axis
%
% Geometric transforms
%   transforms2d          - Description of functions operating on transforms
%   createTranslation     - Create the 3*3 matrix of a translation
%   createRotation        - Create the 3*3 matrix of a rotation
%   createScaling         - Create the 3*3 matrix of a scaling in 2 dimensions
%   createHomothecy       - Create the the 3x3 matrix of an homothetic transform
%   createBasisTransform  - Compute matrix for transforming a basis into another basis
%   createLineReflection  - Create the the 3x3 matrix of a line reflection
%   fitAffineTransform2d  - Fit an affine transform using two point sets
%
% Angles
%   angles2d              - Description of functions for manipulating angles
%   normalizeAngle        - Normalize an angle value within a 2*PI interval
%   angleAbsDiff          - Absolute difference between two angles
%   angleDiff             - Difference between two angles
%   deg2rad               - Convert angle from degrees to radians
%   rad2deg               - Convert angle from radians to degrees
%
% Boxes
%   boxes2d               - Description of functions operating on bounding boxes
%   intersectBoxes        - Intersection of two bounding boxes
%   mergeBoxes            - Merge two boxes, by computing their greatest extent
%   randomPointInBox      - Generate random point within a box
%   drawBox               - Draw a box defined by coordinate extents
%
% Triangles
%   isPointInTriangle     - Test if a point is located inside a triangle
%   triangleArea          - Signed area of a triangle
%
% Rectangles
%   rectToPolygon         - Convert a rectangle into a polygon (set of vertices)
%   drawRect              - Draw rectangle on the current axis
%   orientedBoxToPolygon  - Convert an oriented box to a polygon (set of vertices)
%   drawOrientedBox       - Draw centered oriented rectangle
%
% Splines
%   cubicBezierToPolyline - Compute equivalent polyline from bezier curve control
%   drawBezierCurve       - Draw a cubic bezier curve defined by 4 control points
%
% Various drawing functions
%   drawArrow             - Draw an arrow on the current axis
%   drawLabels            - Draw labels at specified positions
%   drawShape             - Draw various types of shapes (circles, polygons...)
%
% Other shapes
%   squareGrid            - Generate equally spaces points in plane.
%   hexagonalGrid         - Generate hexagonal grid of points in the plane.
%   triangleGrid          - Generate triangular grid of points in the plane.
%   crackPattern          - Create a (bounded) crack pattern tessellation
%   crackPattern2         - Create a (bounded) crack pattern tessellation
%
%
%   Credits:
%   * function 'enclosingCircle' rewritten from a file from Yazan Ahed
%       (yash78@gmail.com), available on Matlab File Exchange
%
% -----
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2005-11-07
% Copyright INRA - Cepia Software Platform.
% Project homepage: http://matgeom.sourceforge.net/
% http://www.pfl-cepia.inra.fr/index.php?page=geom2d

help('Contents');


%%   Deprecated functions

%   createMedian          - create a median line
%   minDistance           - compute minimum distance between a point and a set of points
%   homothecy             - create a homothecy as an affine transform
%   rotation              - return 3*3 matrix of a rotation
%   translation           - return 3*3 matrix of a translation
%   scaling               - return 3*3 matrix of a scaling in 2 dimensions
%   lineSymmetry          - create line symmetry as 2D affine transform
%   vecnorm               - compute norm of vector or of set of vectors
%   normalize             - normalize a vector
%   onCircle              - test if a point is located on a given circle.
%   inCircle              - test if a point is located inside a given circle.
%   onEdge                - test if a point belongs to an edge
%   onLine                - test if a point belongs to a line
%   onRay                 - test if a point belongs to a ray
%   invertLine            - return same line but with opposite orientation
%   clipLineRect          - clip a line with a polygon
%   formatAngle           - Ensure an angle value is comprised between 0 and 2*PI
%   drawRect2             - Draw centered rectangle on the current axis
%   circleAsPolygon       - Convert a circle into a series of points
%   circleArcAsCurve      - Convert a circle arc into a series of points
%   ellipseAsPolygon      - Convert an ellipse into a series of points


%% Others...
