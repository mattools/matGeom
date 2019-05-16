function adjList = meshFaceAdjacency(vertices, edges, faces)
%MESHFACEADJACENCY Compute adjacency list of face around each face.
%
%
%   Example
%     % Create a sample 3D mesh
%     [v, e, f] = createDodecahedron;
%     adjList = meshFaceAdjacency(v, e, f);
%     figure; hold on; axis equal; view([100 40]);
%     drawMesh(v, f);
%     % draw sample face in a different color
%     drawMesh(v, f(1, :), 'faceColor', 'b');
%     % draw the neighbors of a sample face
%     drawMesh(v, f(adjList{1}, :), 'faceColor', 'g')
%     
% 

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-10-04,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.


edgeFaceList = meshEdgeFaces(vertices, edges, faces);

% allocate memory for adjacency list
nFaces = max(edgeFaceList(:));
adjList = cell(1, nFaces);

% iterate over edges to populate adjacency list
for iEdge = 1:size(edgeFaceList)
    f1 = edgeFaceList(iEdge, 1);
    f2 = edgeFaceList(iEdge, 2);
    adjList{f1} = [adjList{f1} f2];
    adjList{f2} = [adjList{f2} f1];
end
