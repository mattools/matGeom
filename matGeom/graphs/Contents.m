% GRAPHS Simple Toolbox for manipulating Geometric Graphs
% Version 0.5 11-Apr-2010 .
%
%   The aim of this package is to provides functions to easily create,  
%   modify and display geometric graphs (geometric in a sense position
%   of vertices is kept in memory).
%
%   Graph structure is represented by at least two arrays:
%   * NODES, which contains coordinates of each vertex
%   * EDGES, which contains indices of start and end vertex.
%
%   Others arrays may sometimes be used:
%   * FACES, which contains indices of vertices of each face (either a
%       double array, or a cell array)
%   * CELLS, which contains indices of faces of each cell.
%
%   An alternative representation is to use a structure, with fields:
%   * edges
%   * faces
%   * cells
%   corresponding to the data described above.
%
%   Note that topological description of 2D graph is entirely contained in
%   EDGES array, and that NODES array is used only to display graph
%   
%   Caution: this type of data structure is easy to create and to manage,
%   but may be very inefficient for some algorithms. 
%
%   Graphs are usually considered as non-oriented in this package.
%
%
% Graph creation
%   knnGraph                - Create the k-nearest neighbors graph of a set of points
%   delaunayGraph           - Graph associated to Delaunay triangulation of input points
%   gabrielGraph            - Gabriel Graph of a set of points
%   euclideanMST            - Build euclidean minimal spanning tree of a set of points
%   prim_mst                - Minimal spanning tree by Prim's algorithm
%
% Create graph from images
%   imageGraph              - Create equivalent graph of a binary image
%   boundaryGraph           - Get boundary of image as a graph
%   gcontour2d              - Creates contour graph of a 2D binary image.
%   gcontour3d              - Create contour graph of a 3D binary image.
%   vectorize               - Transform a binary skeleton into a graph (nodes and edges)
%
% Graph information
%   grNodeDegree            - Degree of a node in a (undirected) graph
%   grNodeInnerDegree       - Inner degree of a node in a graph
%   grNodeOuterDegree       - Outer degree of a node in a graph
%   grNeighborNodes         - Find adjacent nodes of a given node
%   grNeighborEdges         - Find adjacent edges of a given node
%   grOppositeNode          - Return opposite node in an edge
%   grLabel                 - Associate a label to each connected component of the graph
%
% Graph management (low level operations)
%   grRemoveNode            - Remove a node in a graph
%   grRemoveNodes           - Remove several nodes in a graph
%   grRemoveEdge            - Remove an edge in a graph.
%   grRemoveEdges           - Remove several edges from a graph
%
% Graph processing (general applications)
%   mergeGraphs             - Merge two graphs, by adding nodes, edges and faces lists. 
%   grMergeNodes            - Merge two (or more) nodes in a graph.
%   grMergeMultipleNodes    - Simplify a graph by merging multiple nodes
%   grMergeMultipleEdges    - Remove all edges sharing the same extremities
%   grSimplifyBranches      - Replace branches of a graph by single edges
%
% Filtering operations on Graph
%   grMean                  - Compute mean from neihgbours
%   grMedian                - Compute median from neihgbours
%   grDilate                - Morphological dilation on graph
%   grErode                 - Morphological erosion on graph
%   grClose                 - Morphological closing on graph
%   grOpen                  - Morphological opening on graph
%
% Geodesic operations
%   grPropagateDistance     - Propagates distances from a vertex to other vertices
%   grVertexEccentricity    - Eccentricity of vertices in the graph
%   graphDiameter           - Diameter of a graph
%   graphPeripheralVertices - Peripheral vertices of a graph
%   graphCenter             - Center of a graph
%   graphRadius             - Radius of a graph
%   grFindGeodesicPath      - Find a geodesic path between two nodes in the graph
%   grFindMaximalLengthPath - Find a path that maximizes sum of edge weights
%
% Operations for geometric graphs
%   grMergeNodeClusters     - Merge cluster of connected nodes in a graph
%   grMergeNodesMedian      - Replace several nodes by their median coordinate
%   clipGraph               - Clip a graph with a rectangular area
%   addSquareFace           - Add a (square) face defined from its vertices to a graph
%   grFaceToPolygon         - Compute the polygon corresponding to a graph face
%   graph2Contours          - Convert a graph to a set of contour curves
%
% Voronoi Graphs
%   voronoi2d               - Compute a voronoi diagram as a graph structure
%   boundedVoronoi2d        - Return a bounded voronoi diagram as a graph structure
%   centroidalVoronoi2d     - Create a 2D Centroidal Voronoi Tesselation
%   cvtUpdate               - Update germs of a CVT with given points
%   cvtIterate              - Update germs of a CVT using random points with given density
%
% Graph display
%   drawGraph               - Draw a graph, given as a set of vertices and edges
%   drawGraphEdges          - Draw edges of a graph
%   drawGraphFaces          - Draw faces of a graph
%   drawDigraph             - Draw a directed graph, given as a set of vertices and edges
%   drawDirectedEdges       - Draw edges with arrow indicating direction
%   drawEdgeLabels          - Draw values associated to graph edges
%   drawNodeLabels          - Draw values associated to graph nodes
%   drawSquareMesh          - Draw a 3D square mesh given as a graph
%   patchGraph              - Transform 3D graph (mesh) into a patch handle
%
%
% -----
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% created the  07/11/2005.
% Copyright INRA - Cepia Software Platform.

  
% HISTORY
% 25/07/2007 remove old functions
% 27/07/2007 integrate headers of other functions
% 27/07/2007 add MST by prim algo, and EuclideanMST
% 24/08/2010 code cleanup
% 07/09/2010 add functions for computing geodesic distances 
% 18/05/2011 code re-organisation, add to MatGeom library

% Deprecated functions
%   grSimplifyBranches_old  - Replace branches of a graph by single edges
%   grRemoveMultiplePoints  - Remove groups of close nodes in a graph
%
% Functions that requires further development
%   quiverToGraph           - Converts quiver data to quad mesh

% Other functions
