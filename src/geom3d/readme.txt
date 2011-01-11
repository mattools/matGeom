Description of the geom3d library.

The aim of geom3d library is to handle and visualize 3D geometric primitives
such as points, lines, planes, polyhedra... It provides low-level functions
for manipulating 3D geometric primitives, making easier the development of more
complex geometric algorithms.   
 
Some features of the library are:
 
- creation of various shapes (3D points, 3D lines, planes, polyhedra...)
    through an intuitive syntax. 
    Ex: createPlane(p1, p2, p3) to create a plane through 3 points.  
 
- derivation of new shapes: intersection between 2 planes, intersection between
    a plane and a line, between a sphere and a line...
 
- functions for 3D polygons and polyhedra. Polyhedra use classical vertex-faces
    arrays (face array contain indices of vertices), and support faces with any
    number of vertices. Some basic models are provided (createOctaedron,
    createCubeoctaedron...), as well as some computation (like faceNormal or
    centroid)
    
- manipulation of planar transformation. Ex.:
    ROT = createRotationOx(THETA);
    P2  = transformPoint3d(P1, ROT);  
 
- direct drawing of shapes with specialized functions. Clipping is performed 
    automatically for infinite shapes such as lines or rays. Ex:
    drawPoint3d([50 50 25; 20 70 10], 'ro');    % draw some points
    drawLine3d([X0 Y0 Z0 DX DY DZ]);            % clip and draw straight line

Some functions require the geom2d package.
     
Additional help is provided in geom3d/Contents.m file, as well as summary files
    like 'points3d.m' or 'lines3d.m'.
