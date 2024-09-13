function varargout = mergeCoplanarFaces(nodes, varargin)
%MERGECOPLANARFACES Merge coplanar faces of a polyhedral mesh.
%
%   [NODES, FACES] = mergeCoplanarFaces(NODES, FACES)
%   [NODES, EDGES, FACES] = mergeCoplanarFaces(NODES, EDGES, FACES)
%   NODES is a set of 3D points (as a nNodes-by-3 array), 
%   and FACES is one of:
%   - a nFaces-by-X array containing vertex indices of each face, with each
%   face having the same number of vertices,
%   - a nFaces-by-1 cell array, each cell containing indices of a face.
%   The function groups faces which are coplanar and contiguous, resulting
%   in a "lighter" mesh. This can be useful for visualizing binary 3D
%   images for example.
%
%   FACES = mergeCoplanarFaces(..., PRECISION)
%   Adjust the threshold for deciding if two faces are coplanar or
%   parallel. Default value is 1e-5.
%
%   Example
%       [v, e, f] = createCube;
%       f = triangulateFaces(f);
%       figure; drawMesh(v, f); 
%       view(3); axis equal tight;
%       [v2, f2] = mergeCoplanarFaces(v, f);
%       figure; drawMesh(v2, f2); 
%       view(3); axis equal tight;
%
%   See also 
%       meshes3d, drawMesh, minConvexHull, triangulateFaces
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2006-07-05
% Copyright 2006-2024 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas)

%% Process input arguments

% set up precision
acc = 1e-5;
if ~isempty(varargin)
    var = varargin{end};
    if isscalar(var)
        acc = var;
        varargin(end) = [];
    end
end

% extract faces and edges
if isscalar(varargin)
    faces = varargin{1};
else
    faces = varargin{2};
end


%% Initialisations

% number of faces
nNodes = size(nodes, 1);
nFaces = size(faces, 1);

% compute number of vertices of each face
Fn = ones(nFaces, 1) * size(faces, 2);

% compute normal of each faces
normals = meshFaceNormals(nodes, faces);

% initialize empty faces and edges
faces2  = cell(0, 1);
edges2  = zeros(0, 2);

% Processing flag for each face
% 1: face to process, 0: already processed
% in the beginning, every triangle face need to be processed
flag = ones(nFaces, 1);


%% Main iteration

% iterate on each  face
for iFace = 1:nFaces
    
    % check if face was already performed
    if ~flag(iFace)
        continue;
    end

    % indices of faces with same normal
    ind = find(vectorNorm3d(crossProduct3d(normals(iFace, :), normals)) < acc);
    
    % keep only coplanar faces (test coplanarity of points in both face)
    ind2 = false(size(ind));
    for j = 1:length(ind)
        ind2(j) = isCoplanar(nodes([faces(iFace,:) faces(ind(j),:)], :), acc);
    end
    ind2 = ind(ind2);
    
    % compute edges of all faces in the plane
    planeEdges  = zeros(sum(Fn(ind2)), 2);
    pos = 1;
    for i = 1:length(ind2)
        face = faces(ind2(i), :);
        faceEdges = sort([face' face([2:end 1])'], 2);
        planeEdges(pos:sum(Fn(ind2(1:i))), :) = faceEdges;
        pos = sum(Fn(ind2(1:i)))+1;
    end
    planeEdges = unique(planeEdges, 'rows');
    
    % relabel plane edges
    [planeNodes, I, J] = unique(planeEdges(:)); %#ok<ASGLU>
    planeEdges2 = reshape(J, size(planeEdges));
    
    % The set of coplanar faces may not necessarily form a single connected
    % component. The following computes label of each connected component.
    component = grLabel(nodes(planeNodes, :), planeEdges2);
    
    % compute degree (number of adjacent faces) of each edge.
    Npe = size(planeEdges, 1);
    edgeDegrees = zeros(Npe, 1);
    for i = 1:length(ind2)
        face = faces(ind2(i), :);
        faceEdges = sort([face' face([2:end 1])'], 2);
        for j = 1:size(faceEdges, 1)
            indEdge = find(sum(ismember(planeEdges, faceEdges(j,:)),2)==2);
            edgeDegrees(indEdge) = edgeDegrees(indEdge)+1;
        end
    end
    
    % extract unique edges and nodes of the plane
    planeEdges  = planeEdges(edgeDegrees==1, :);
    planeEdges2 = planeEdges2(edgeDegrees==1, :);
    
    % find connected component of each edge
    planeEdgesComp = zeros(size(planeEdges, 1), 1);
    for iEdge = 1:size(planeEdges, 1)
        planeEdgesComp(iEdge) = component(planeEdges2(iEdge, 1));
    end
    
    % iterate on connected faces
    for c = 1:max(component)
        
        % convert to chains of nodes
        loops = graph2Contours(nodes, planeEdges(planeEdgesComp==c, :));
    
        % add a simple Polygon for each loop
        facePolygon = loops{1};
        for l = 2:length(loops)
            facePolygon = [facePolygon, NaN, loops{l}]; %#ok<AGROW>
        end
        faces2{length(faces2)+1, 1}  = facePolygon;
    
        % also add news edges
        edges2 = unique([edges2; planeEdges], 'rows');
    end
    
    % mark processed faces
    flag(ind2) = 0;
end


%% Additional processing on nodes

% select only nodes which appear in at least one edge
indNodes = unique(edges2(:));

% for each node, compute index of corresponding new node (or 0 if dropped)
refNodes = zeros(nNodes, 1);
for i = 1:length(indNodes)
    refNodes(indNodes(i)) = i;
end

% changes indices of nodes in edges2 array
for i = 1:length(edges2(:))
    edges2(i) = refNodes(edges2(i));
end

% changes indices of nodes in faces2 array
for iFace = 1:length(faces2)
    face = faces2{iFace};
    for i = 1:length(face)
        if ~isnan(face(i))
            face(i) = refNodes(face(i));
        end
    end
    faces2{iFace} = face;
end

% keep only boundary nodes
nodes2 = nodes(indNodes, :);


%% Process output arguments

if nargout == 1
    varargout{1} = faces2;
elseif nargout == 2
    varargout{1} = nodes2;
    varargout{2} = faces2;
elseif nargout == 3
    varargout{1} = nodes2;
    varargout{2} = edges2;
    varargout{3} = faces2;
end
