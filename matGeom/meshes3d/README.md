# matGeom/meshes3d

Creation, visualization, and manipulation of 3D surface meshes or
polyhedra.

Meshes and polyhedra are represented by the variables V, F:
* V: NV-by-3 array of vertices: [x<sub>1</sub> y<sub>1</sub> z<sub>1</sub>;
     ... ; x<sub>n</sub> y<sub>n</sub> z<sub>n</sub>].
* F: is either a NF-by-3 or NF-by-4 array containing reference for
    vertices of each face, or a NF-by-1 cell array, where each cell is an
    array containing a variable number of node indices.
* [E: NE-by-2 array of edges is needed only for some functions. It contains
    indices of source and target vertices of the edges. The function 
    [meshEdges](https://github.com/mattools/matGeom/blob/master/matGeom/meshes3d/meshEdges.m) can be used to create the edge array.]

Some functions are implemented only for triangular surface meshes (V: 
NV-by-3, F: NF-by-3). The function 
[triangulateFaces](https://github.com/mattools/matGeom/blob/master/matGeom/meshes3d/triangulateFaces.m) 
can be used to convert other representation into a triangular mesh.

Alternatively, the mesh can be passed to most of the functions as struct 
with the fields 'vertices' and 'faces' (and 'edges', if necessary) and 
the processed mesh is also returned as struct if only one output argument 
is called.

The library provides function to create basic polyhedric meshes (the
five platonic solids, plus few others), as well as functions to perform
basic computations (surface area, normal angles, face centroids, ...).
The [MengerSponge](https://github.com/mattools/matGeom/blob/master/matGeom/meshes3d/createMengerSponge.m) 
structure is an example of mesh that is not simply
connected (multiple tunnels in the structure).

The drawMesh function is mainly a wrapper to the Matlab 'patch'
function, allowing passing arguments more quickly.

Simple example:
```matlab:Code(Display)
% Create a soccer ball mesh and display it
mesh = createSoccerBall;
figure('color','w')
drawMesh(mesh, 'faceColor', 'g', 'linewidth', 2);
axis equal; view(3);
```
![grafik](https://github.com/mattools/matGeom/assets/15254908/79c759e2-ea85-435e-8a6c-9b6961329437)

Some functions require lines, planes, spheres or boxes from 
[geom3d](https://github.com/mattools/matGeom/tree/master/matGeom/geom3d)
as additional input in combination with the mesh.

```matlab:Code(Display)
nPoints = 200; % Number of vertices of trefoil curve
thickness = .5; % Thickness of the 3D mesh
nCorners = 16; % Number of corners around each curve vertex
t = linspace(0, 2*pi, nPoints + 1); % parameterization variable
t(end) = [];
% Trefoil curve coordinates
curve(:,1) = sin(t) + 2 * sin(2 * t);
curve(:,2) = cos(t) - 2 * cos(2 * t);
curve(:,3) = -sin(3 * t);
% Create surrounding mesh
[v2, f2] = curveToMesh(curve, thickness, nCorners);
f2 = triangulateFaces(f2);
% Clip the mesh by a plane
plane = createPlane([0 0 0], [0.5 0.5 1]);
[v2, f2, bE] = clipMeshByPlane(v2, f2, plane, 'part','above');
% Display results
figure('color','w'); 
drawPolygon3d(curve, 'LineWidth', 4, 'color', 'b');
axis equal; view(3);
drawMesh(v2, f2, 'FaceAlpha', 0.5);
drawPlane3d(plane)
drawEdge3d([v2(bE(:,1),:),v2(bE(:,2),:)],'Color','g','LineWidth',4)
```
![grafik](https://github.com/mattools/matGeom/assets/15254908/e4a11e3e-53c6-4080-b243-b15a55c4534d)