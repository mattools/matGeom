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
%   points2d                  - Description of functions operating on points
%   clipPoints                - Clip a set of points by a box
%   centroid                  - Compute centroid (center of mass) of a set of points
%   midPoint                  - Middle point of two points or of an edge
%   isCounterClockwise        - Compute relative orientation of 3 points
%   polarPoint                - Create a point from polar coordinates (rho + theta)
%   angle2Points              - Compute horizontal angle between 2 points
%   angle3Points              - Compute oriented angle made by 3 points
%   angleSort                 - Sort points in the plane according to their angle to origin
%   distancePoints            - Compute distance between two points
%   minDistancePoints         - Minimal distance between several points
%
% Vectors
%   vectors2d                 - Description of functions operating on plane vectors
%   vectorNorm                - compute norm of vector or of set of vectors
%   vectorAngle               - Compute angle of a vector with horizontal axis
%   normalizeVector           - normalize a vector
%   isPerpendicular           - check orthogonality of two vectors
%   isParallel                - check parallelism of two vectors
%
% Straight lines
%   lines2d                   - Description of functions operating on planar lines
%   createLine                - create a line with various inputs.
%   medianLine                - Create a median line between two points
%   cartesianLine             - create a line with cartesian coefficients
%   orthogonalLine            - Create a line orthogonal to another one.
%   parallelLine              - create a line parallel to another one.
%   intersectLines            - return all intersection points of N lines in 2D
%   intersectLinePolygon      - get intersection points between a line and a polygon
%   lineAngle                 - Computes angle between two straight lines
%   linePosition              - return position of a point on a line
%   lineFit                   - least mean square line regression
%   clipLine                  - clip a line with a box
%   reverseLine               - return same line but with opposite orientation
%
% Edges (line segments between 2 points)
%   edges2d                   - Description of functions operating on planar edges
%   createEdge                - create an edge between two points, or from a line
%   edgeToLine                - convert an edge to a straight line
%   edgeAngle                 - return angle of edge
%   edgeLength                - return length of an edge
%   midPoint                  - Middle point of two points or of an edge
%   edgePosition              - return position of a point on an edge
%   clipEdge                  - clip an edge with a rectangular box
%   reverseEdge               - Interverts source and target vertices of edge
%   intersectEdges            - return all intersections points of N edges in 2D
%   intersectLineEdge         - return intersection between a line and an edge
%
% Rays
%   rays2d                    - Description of functions operating on planar rays
%   createRay                 - create a ray (half-line)
%   bisector                  - return the bisector of two lines, or 3 points
%   clipRay                   - Clip a ray with a box
%   intersectRayPolygon       - get intersection points between a ray and a polygon
%
% Relations between points and lines
%   distancePointEdge         - compute distance between a point and an edge
%   distancePointLine         - compute distance between a point and a line
%   projPointOnLine           - return the projection of a point on a line
%   pointOnLine               - create a point on a line at a given distance from line origin
%   isPointOnLine             - Tests if a point belongs to a line
%   isPointOnEdge             - test if a point belongs to an edge
%   isPointOnRay              - test if a point belongs to a ray
%   isLeftOriented            - Tests if a point is on the left side of a line
%
% Polygons
%   polygons2d                - Description of functions operating on polygons
%   distancePointPolygon      - Compute shortest distance between a point and a polygon
%   distancePolygons          - compute the shortest distance between 2 polygons
%   polygonPoint              - extract a point from a polygon
%   polygonSelfIntersections  - find common points between 2 polygons
%   polygonSubcurve           - extract a portion of a polygon
%   reversePolygon            - reverse a polygon, by iterating vertices from the end
%   projPointOnPolygon        - Compute position of a point projected on a polygon
%   clipPolygon               - clip a polygon with a rectangular box
%   clipPolygonHP             - clip a polygon with a Half-plane defined by a directed line
%   expandPolygon             - expand a polygon by a given (signed) distance
%   polygonLoops              - divide a possibly self-intersecting polygon into a set of simple loops
%   splitPolygons             - convert a NaN separated polygon list to a cell array of polygons
%   readPolygon               - read a polygon stored in a file
%   polygonToRow              - Convert polygon coordinates to a row vector
%   rowToPolygon              - Create a polygon from a row vector
%   rectAsPolygon             - convert a (centered) rectangle into a series of points
%   steinerPoint              - compute steiner point (weighted centroid) of a polygon
%   steinerPolygon            - create a Steiner polygon from a set of vectors
%   supportFunction           - compute support function of a polygon
%   convexification           - compute convexification of a polygon
%   medialAxisConvex          - compute medial axis of a convex polygon
%
% Measures on Polygons
%   isPointInPolygon          - Check if a point is located inside a polygon
%   polygonContains           - test if a point is contained in a multiply connected polygon
%   polygonCentroid           - compute centroid (center of mass) of a polygon
%   polygonArea               - compute the signed area of a polygon
%   polygonLength             - compute perimeter of a polygon
%   polygonNormalAngle        - compute normal angle at a vertex of the polygon
%   polygonBounds             - compute bounding box of a polygon
%
% Polylines
%   polylines2d               - Description of functions operating on polylines
%   polylinePoint             - extract a point from a polyline
%   polylineLength            - return length of a polyline given as a list of points
%   polylineCentroid          - Compute centroid of a curve defined by a series of points
%   polylineSubcurve          - extract a portion of a polyline
%   reversePolyline           - reverse a polyline, by iterating vertices from the end
%   isPointOnPolyline         - check if a point belongs to a polyline
%   projPointOnPolyline       - compute position of a point projected on a polyline
%   distancePointPolyline     - Compute shortest distance between a point and a polyline
%   distancePolylines         - compute the shortest distance between 2 polylines
%   intersectPolylines        - find common points between 2 polylines
%   polylineSelfIntersections - find self-intersections points of a polyline
%   parametrize               - return a parametrization of a curve
%   curvature                 - estimate curvature of a curve defined by points
%   cart2geod                 - convert cartesian coordinates to geodesic coord.
%   geod2cart                 - convert geodesic coordinates to cartesian coord.
%   curveMoment               - Compute inertia moment of a 2D curve
%   curveCMoment              - Compute centered inertia moment of a 2D curve
%   curveCSMoment             - Compute centered scaled moment of a 2D curve
%
% Circles and Ellipses
%   circles2d                 - Description of functions operating on circles
%   createCircle              - Create a circle from 2 or 3 points
%   createDirectedCircle      - Create a directed circle
%   circleAsPolygon           - convert a circle into a series of points
%   ellipseAsPolygon          - convert an ellipse into a series of points
%   circleArcAsCurve          - convert a circle arc into a series of points
%   enclosingCircle           - find the minimum circle enclosing a set of points.
%   isPointInCircle           - test if a point is located inside a given circle.
%   isPointOnCircle           - test if a point is located on a given circle.
%   radicalAxis               - compute the radical axis (or radical line) of 2 circles
%
% Polynomial curves
%   polynomialCurves2d        - Description of functions operating on polynomial curves
%   polynomialCurveCentroid   - compute the centroid of a polynomial curve
%   polynomialCurveCurvature  - compute the local curvature of a polynomial curve
%   polynomialCurveCurvatures - compute curvatures of a polynomial revolution surface
%   polynomialCurveDerivative - compute derivative vector of a polynomial curve
%   polynomialCurveProjection - projection of a point on a polynomial curve
%   polynomialCurveFit        - fit a polynomial curve to a series of points
%   polynomialCurveSetFit     - fit a set of polynomial curves to a segmented image
%   polyfit2                  - polynomial approximation of a curve
%   polynomialCurveLength     - compute the length of a polynomial curve
%   polynomialCurveNormal     - compute the normal of a polynomial curve
%   polynomialCurvePoint      - compute point corresponding to a position
%   polynomialCurvePosition   - compute position on a curve for a given length
%   polynomialDerivate        - derivate a polynomial
%
% Other shapes
%   squareGrid                - generate equally spaces points in plane.
%   hexagonalGrid             - generate hexagonal grid of points in the plane.
%   triangleGrid              - generate triangular grid of points in the plane.
%   crackPattern              - create a (bounded) crack pattern tessellation
%   crackPattern2             - create a (bounded) crack pattern tessellation
%
% Geometric transforms
%   transforms2d              - Description of functions operating on transforms
%   createTranslation         - return 3*3 matrix of a translation
%   createRotation            - return 3*3 matrix of a rotation
%   createScaling             - return 3*3 matrix of a scaling in 2 dimensions
%   createHomothecy           - create a homothecy as an affine transform
%   createLineReflection      - create line reflection as 2D affine transform
%   fitAffineTransform2d      - fit an affine transform using two point sets
%   transformPoint            - transform a point with an affine transform
%   transformVector           - transform a vector with an affine transform
%   transformEdge             - transform an edge with an affine transform
%   transformLine             - transform a line with an affine transform
%
% Angles
%   angles2d                  - Description of functions for manipulating angles
%   normalizeAngle            - Normalizes an angle value in a 2*PI interval
%   deg2rad                   - Convert angle from degrees to radians
%   rad2deg                   - Convert angle from radians to degrees
%
% Boxes
%   boxes2d                   - Conventions for using bounding boxes
%   intersectBoxes            - Intersection of two bounding boxes
%   mergeBoxes                - Merge two boxes, by computing their greatest extent
%
% Drawing functions
%   drawPoint                 - draw the point on the axis.
%   drawLine                  - draw the line on the current axis
%   drawRay                   - draw a ray on the current axis
%   drawEdge                  - draw the edge given by 2 points
%   drawCenteredEdge          - draw an edge centered on a point
%   drawPolygon               - draw a polygon specified by a list of points
%   drawPolyline              - draw a polyline specified by a list of points
%   drawRect                  - draw rectangle on the current axis
%   drawRect2                 - draw centered rectangle on the current axis
%   drawBox                   - Draw a box defined by coordinate extents
%   drawCircle                - draw a circle on the current axis
%   drawCircleArc             - draw a circle arc on the current axis
%   drawEllipse               - draw an ellipse on the current axis
%   drawEllipseArc            - Draw an ellipse arc on the current axis
%   drawParabola              - Draw a parabola on the current axis
%   drawArrow                 - draw an arrow on the current axis
%   drawLabels                - draw labels at specified positions
%   drawShape                 - draw various types of shapes (circles, polygons ...)
%   fillPolygon               - fill a polygon specified by a list of points
%
%
%   Credits:
%   * function 'enclosingCircle' rewritten from a file from Yazan Ahed
%       (yash78@gmail.com), available on Matlab File Exchange
%   * function intersectPolylines uses the 'interX' cotnribution from "NS"
%       (file exchange 22441, called 'curve-intersections')
%
% -----
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% created the  07/11/2005.
% Copyright INRA - Cepia Software Platform.
% http://www.pfl-cepia.inra.fr/index.php?page=geom2d

help('Contents');

%% Requires further development:
%   inertiaEllipse            - inertia ellipse of a set of points


%%   Deprecated functions:
%   createMedian              - create a median line
%   minDistance               - compute minimum distance between a point and a set of points
%   clipLineRect              - clip a line with a polygon
%   homothecy                 - create a homothecy as an affine transform
%   rotation                  - return 3*3 matrix of a rotation
%   translation               - return 3*3 matrix of a translation
%   scaling                   - return 3*3 matrix of a scaling in 2 dimensions
%   lineSymmetry              - create line symmetry as 2D affine transform
%   vecnorm                   - compute norm of vector or of set of vectors
%   normalize                 - normalize a vector
%   onCircle                  - test if a point is located on a given circle.
%   inCircle                  - test if a point is located inside a given circle.
%   onEdge                    - test if a point belongs to an edge
%   onLine                    - test if a point belongs to a line
%   onRay                     - test if a point belongs to a ray
%   polygonExpand             - 'expand' a polygon with a given distance
%   invertLine                - return same line but with opposite orientation
%   subCurve                  - extract a portion of a curve
%   curveLength               - return length of a curve (a list of points)
%   curveCentroid             - compute centroid of a curve defined by a series of points
%   drawCurve                 - draw a curve specified by a list of points
%   formatAngle               - Ensure an angle value is comprised between 0 and 2*PI


%% Others...
