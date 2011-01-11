Description of the geom2d library.

The aim of geom2d library is to handle and visualize geometric primitives such
as points, lines, circles and ellipses, polylines and polygons...  It provides
low-level functions for manipulating geometrical primitives, making easier the
development of more complex geometric algorithms.   
 
Some features of the library are:
 
- creation of various shapes (points, circles, lines, ellipses, polylines,
    polygons...) through an intuitive syntax. 
    Ex: createCircle(p1, p2, p3) to create a circle through 3 points.  
 
- derivation of new shapes: intersection between 2 lines, between line and
    circle, between polylines... or point on a curve from its parametrisation
 
- functions for polylines and polygons: compute centroid and area, expand, 
    self-intersections, clipping with half-plane...  
 
- manipulation of planar transformation. Ex.:
    ROT = createRotation(CENTER, THETA);
    P2 = transformPoint(P1, ROT);  
 
- direct drawing of shapes with specialized functions. Clipping is performed 
    automatically for infinite shapes such as lines or rays. Ex:
    drawCircle([50 50 25]);     % draw circle with radius 25 and center [50 50]
    drawLine([X0 Y0 DX DY]);    % clip and draw straight line
 
- measure distances (between points, a point and a line, a point and a group
    of points), angle (of a line, between 3 points), or test geometry (point
    on a line, on a circle).  
 
Additional help is provided in geom/Contents.m file, as well as summary files
    like 'points2d.m' or 'lines2d.m'.
