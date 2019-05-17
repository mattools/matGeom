function edgeFaces = trimeshEdgeFaces(faces, varargin)
%TRIMESHEDGEFACES Compute index of faces adjacent to each edge of a triangular mesh.
%
%   EF = trimeshEdgeFaces(FACES)
%   EF = trimeshEdgeFaces(VERTICES, FACES)
%   EF = trimeshEdgeFaces(VERTICES, EDGES, FACES)
%   Compute index array of faces adjacent to each edge of a mesh.
%   FACES is a NF-by-3 array containing vertex indices of each face. The
%   result EF is a NE-by-2 array containing the indices of the two faces
%   incident to each edge. If an edge belongs to only one face, the other
%   face index is ZERO.
%
%   The list of edges (as array of source and target vertex indices) can be
%   obtained from the function 'meshEdges'.
%
%   Note: faces are listed in increasing order for each edge, and no
%   information is kept about relative orientation of edge and face.
%
%   Example
%     % compute incidence list of each edge of an octahedron. For example,
%     % first edge is incident to faces 1 and 5. Second edge is incident to
%     % faces 4 and 8, and so on.
%     [v, f] = createOctahedron;
%     ef = trimeshEdgeFaces(v, f)
%     ef =
%          1     5
%          4     8
%          4     1
%          5     8
%          2     6
%          1     2
%          6     5
%          3     7
%          2     3
%          7     6
%          3     4
%          7     8
%
%   See also
%   meshes3d, meshEdgeFaces, trimeshMeanBreadth, meshEdges
 
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2015-08-19,    using Matlab 8.5.0.197613 (R2015a)
% Copyright 2015 INRA - Cepia Software Platform.

if nargin == 2
    faces = varargin{1};
elseif nargin == 3
    faces = varargin{2};
end

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

