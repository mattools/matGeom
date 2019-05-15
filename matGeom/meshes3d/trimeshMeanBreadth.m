function mb = trimeshMeanBreadth(vertices, faces)
%TRIMESHMEANBREADTH Mean breadth of a triangular mesh.
%
%   MB = trimeshMeanBreadth(VERTICES, FACES)
%   Computes the mean breadth (proporitonal to the integral of mean
%   curvature) of a triangular mesh.
%
%   Example
%     [V, F] = createCube;
%     F2 = triangulateFaces(F);
%     MB = trimeshMeanBreadth(V, F2)
%     MB = 
%         1.5000
%
%   See also
%   meshes3d, trimeshSurfaceArea, trimeshEdgeFaces, polyhedronMeanBreadth
%
%   References
%   Stoyan D., Kendall W.S., Mecke J. (1995) "Stochastic Geometry and its
%       Applications", John Wiley and Sons, p. 26
%   Ohser, J., Muescklich, F. (2000) "Statistical Analysis of
%       Microstructures in Materials Sciences", John Wiley and Sons, p.352
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2015-08-19,    using Matlab 8.5.0.197613 (R2015a)
% Copyright 2015 INRA - Cepia Software Platform.


%% Check input validity

if size(faces, 2) ~= 3
    error('meshes3d:trimeshMeanBreadth:NonTriangularMesh', ...
        'Requires a triangular mesh as input');
end
    
%% Compute edge and edgeFaces arrays
% Uses the same code as in trimeshEdgeFaces

% compute vertex indices of each edge (in increasing index order)
edges = sort([faces(:,[1 2]) ; faces(:,[2 3]) ; faces(:,[3 1])], 2);

% create an array to keep indices of faces "creating" each edge
nFaces = size(faces, 1);
edgeFaceInds = repmat( (1:nFaces)', 3, 1);

% sort edges, keeping indices
[edges, ia, ib] = unique(edges, 'rows'); %#ok<ASGLU>
nEdges = size(edges, 1);

% allocate memory for result
edgeFaces = zeros(nEdges, 2);

% iterate over edges, to identify incident faces
for iEdge = 1:nEdges
    inds = find(ib == iEdge);
    edgeFaces(iEdge, 1:length(inds)) = edgeFaceInds(inds);
end


%% Compute dihedral angle for each edge

% compute normal of each face
normals = meshFaceNormals(vertices, faces);

% allocate memory for resulting angles
alpha = zeros(nEdges, 1);

% iterate over edges
for iEdge = 1:nEdges
    % indices of adjacent faces
    indFace1 = edgeFaces(iEdge, 1);
    indFace2 = edgeFaces(iEdge, 2);
    
    % normal vector of adjacent faces
    normal1 = normals(indFace1, :);
    normal2 = normals(indFace2, :);
    
    % compute dihedral angle of two vectors
    alpha(iEdge) = vectorAngle3d(normal1, normal2);
end


%% Compute mean breadth
% integrate the dihedral angles weighted by the length of each edge

% compute length of each edge
lengths = meshEdgeLength(vertices, edges);

% compute product of length by angles 
mb = sum(alpha .* lengths) / (4*pi);
