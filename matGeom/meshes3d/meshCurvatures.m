function [C1, C2, U1, U2, H, K, N] = meshCurvatures(vertices, faces, varargin)
% Compute principal curvatures on mesh vertices.
%
%   [C1, C2] = meshCurvatures(VERTICES, FACES)
%   Computes the principal curvatures C1 and C2 for each vertex of the mesh
%   defined by VERTICES and FACES.
%
%   [C1, C2] = meshCurvatures(..., PNAME, PVALUE)
%   Provides additional input arguments based on a list of name-value pairs
%   of arguments. Parameter names can be:
%   * 'SmoothingSteps'      (integer, default: 3) 
%       Specifies the number of steps for smoothing vertex curvature
%       tensors.  
%   * 'Verbose'             (boolean, default: true) 
%       Displays details about algorithm processing. 
%   * 'ShowProgress'        (boolean, default: true) 
%       Displays a text-based progress bar.
%
%   Algorithm
%   The function is adapted from the "compute_curvature" function, in the
%   "toolbox_graph" fro Gabriel Peyre.
%   The basic idea is to define a curvature tensor for each edge, by
%   assigning a minimum curvature equal to zero along the edge, and a
%   maximum curvature equal to the dihedral angle across the edge.
%   Averaging around the neighbors of a vertex v yields a summation formula
%   over the neighbor edges to compute the curvature tensor of a vertex:
%           1
%   C(v) = ----     Sum       \beta(e) || e \cap A(v) || ebar ebar^t
%          A(v)  {e \in A(v)}
%   where:
%   * A(v) is the neighborhood region, usually defined as a 'ring' around
%       the vertex v
%   * beta(e) is the dihedral angle between the normals of the two faces
%       incident to edge e
%   * || e \cap A(v) || is the length of e (more exactly, the length of the
%       part of e contained within the neighborhood region
%   * ebar is the normalized edge
%
%   The curvature tensor is then decomposed into C = P D P^-1, with P
%   containing main direction vectors and normal, and D being a diagonal
%   matrix with the two main curvatures and zero along the diagonal.
%   
%   References
%   * David Cohen-Steiner and Jean-Marie Morvan (2003). 
%       "Restricted Delaunay triangulations and normal cycle". 
%       In Proc. 19th Annual ACM Symposium on Computational Geometry, 
%       pages 237-246. 
%   * Pierre Alliez, David Cohen-Steiner, Olivier Devillers, Bruno Levy,
%       and Mathieu Desbrun (2003). "Anisotropic Polygonal Remeshing". 
%       ACM Transactions on Graphics. 
%       (SIGGRAPH '2003 Conference Proceedings)
%   * Mario Botsch, Leif Kobbelt, M. Pauly, P. Alliez, B. Levy (2010).
%       "Polygon Mesh Processing", Taylor and Francis Group, New York.
%   
%   Example
%     [v, f] = torusMesh;
%     f2 = triangulateFaces(f);
%     [c1, c2] = meshCurvatures(v, f2);
%     figure; hold on; axis equal; view(3);
%     drawMesh(v, f2, 'VertexColor', c1 .* c2);
%
%   See also
%     meshes3d, drawMesh, triangulateFaces
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2021-09-21,    using Matlab 9.10.0.1684407 (R2021a) Update 3
% Copyright 2021 INRAE.


%% Process input arguments

% default values for options
nIters = 3;
verbose = true;
showProgress = true;

while length(varargin) > 1
    name = varargin{1};
    if strcmpi(name, 'SmoothingSteps')
        nIters = varargin{2};
    elseif strcmpi(name, 'Verbose')
        verbose = varargin{2};
    elseif strcmpi(name, 'ShowProgress')
        showProgress = varargin{2};
    else
        error('Unknown option: %s', name);
    end
    varargin(1:2) = [];
end

% validate vertices
if ~isnumeric(vertices) || size(vertices, 2) ~= 3
    error('Requires vertices to be a N-by-3 numeric array');
end

% ensure faces are triangular
if ~isnumeric(faces) || size(faces, 2) > 3
    warning('requires triangle mesh, forces triangulation');
    faces = triangulateFaces(faces);
end


%% Retrieve adjacency relationships

if verbose
    disp('compute adjacencies');
end

% number of elements of each type
nv = size(vertices, 1);
nf = size(faces, 1);

% ev1 and ev2 are indices of source and target vertex of each edge
% (recomputed later)
ev1 = [faces(:,1); faces(:,2); faces(:,3)];
ev2 = [faces(:,2); faces(:,3); faces(:,1)];

% Compute sparse matrix representing edge-to-face adjacency
s = [1:nf 1:nf 1:nf]';
A = sparse(ev1, ev2, s, nv, nv); 

% converts sparse matrix to indices of adjacent vertices and faces
[~, ~, ef1] = find(A);         % index of 'right' face
[ev1, ev2, ef2] = find(A');    % index of 'left' face, and of vertices

% edges are consdered twice (one for each vertex)
% keep only the edge with lower source index
inds = find(ev1 < ev2);
ef1 = ef1(inds);
ef2 = ef2(inds);
ev1 = ev1(inds); 
ev2 = ev2(inds);

% number of edges
ne = length(ev1);


%% Compute geometry features

% compute edge direction vectors
edgeVectors = vertices(ev2,:) - vertices(ev1,:);

% normalize edge direction vecotrs
d = sqrt(sum(edgeVectors.^2, 2));
edgeVectors = bsxfun(@rdivide, edgeVectors, d);

% avoid too large numerics
d = d ./ mean(d);

% normals to faces
normals = meshFaceNormals(vertices, faces);

% ensure normals point outward the mesh
if meshVolume(vertices, faces) < 0
    normals = -normals;
end

% inner product of normals
dp = sum(normals(ef1, :) .* normals(ef2, :), 2);

% compute the (unsigned) dihedral angle between the normals of the two
% faces incident to each edge
beta = acos(min(max(dp, -1), 1));

% relatice orientation of face normals cross product and edge orientation
cp = crossProduct3d(normals(ef1, :), normals(ef2, :));
si = sign(sum(cp .* edgeVectors, 2));

% compute signed dihedral angle
beta = beta .* si;


%% Compute tensors

if verbose
    disp('compute edge tensors');
end

% curvature tensor of each edge
T = zeros(3, 3, ne);
for i = 1:3
    for j = 1:i
        T(i, j, :) = reshape(edgeVectors(:,i) .* edgeVectors(:,j), 1, 1, ne);
        T(j, i, :) = T(i, j, :);
    end
end
T = bsxfun(@times, T, reshape(d .* beta, [1 1 ne]));

% curvature tensor of each vertex by pooling edge tensors
Tv = zeros(3, 3, nv);
w = zeros(1, 1, nv);
for k = 1:ne
    if showProgress
        displayProgress(k, ne);
    end
    Tv(:,:,ev1(k)) = Tv(:,:,ev1(k)) + T(:,:,k);
    Tv(:,:,ev2(k)) = Tv(:,:,ev2(k)) + T(:,:,k);
    w(:,:,ev1(k)) = w(:,:,ev1(k)) + 1;
    w(:,:,ev2(k)) = w(:,:,ev2(k)) + 1;
end
w(w < eps) = 1;
Tv = Tv ./ repmat(w, [3 3 1]);

if verbose
    disp('average vertex tensors');
end

% apply smoothing on the tensor field
for i = 1:3
    for j = 1:3
        a = Tv(i, j, :);
        a = smoothMeshFunction(vertices, faces, a(:), nIters);
        Tv(i, j, :) = reshape(a, [1 1 nv]);
    end
end


%% Retrieve curvatures and eigen vectors from tensors

if verbose
    disp('retrieve curvatures');
end

% allocate memory
U = zeros(3, 3, nv);
D = zeros(3, nv);

% iterate over vertices
for k = 1:nv
    % display progress
    if showProgress
        displayProgress(k,nv);
    end
    
    % extract eigenvectors and eigenvalues for current vertex
    [u, d] = eig(Tv(:,:,k));
    d = real(diag(d));
    
    % sort acording to [normal, min curv, max curv]
    [~, I] = sort(abs(d));    
    D(:, k) = d(I);
    U(:, :, k) = real(u(:,I));
end

% retrieve main curvatures and associated directions
C1 = D(2,:)';
C2 = D(3,:)';
U1 = squeeze(U(:,3,:))';
U2 = squeeze(U(:,2,:))';

% enforce C1 < C2
inds = find(C1 > C2);
C1tmp = C1; 
U1tmp = U1;
C1(inds) = C2(inds); 
C2(inds) = C1tmp(inds);
U1(inds,:) = U2(inds,:); 
U2(inds,:) = U1tmp(inds,:);

% compute optional output arguments
if nargout > 4
    % average and gaussian curvatures
    H = (C1 + C2) / 2;
    K = C1 .* C2;
    
    if nargout > 6
        % normal vector for each vertex
        N = squeeze(U(:,1,:))';
    end
end


function displayProgress(n, N)
% Display the progress of current step using a text-based progress bar.
%
% based on the 'progressbar' function in G. Peyre's Graph Toolbox.

% width of the progress bar
w = 20;

% compute progress ratio as an integer betsween 0 and w
p = min( floor(n/N*(w+1)), w);

global pprev;
if isempty(pprev)
    pprev = -1;
end

if p ~= pprev
    str1 = repmat('*', 1, p);
    str2 = repmat('.', 1, w-p);
    str = sprintf('[%s%s]', str1, str2);
    if n > 1
        % clear previous string
        fprintf(repmat('\b', [1 length(str)]));
    end
    fprintf(str);
end

pprev = p;
if n == N
    fprintf('\n');
end
