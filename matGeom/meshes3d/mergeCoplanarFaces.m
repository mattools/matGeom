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
%   [v, e, f] = createCube;
%   figure; drawMesh(v, f); view(3); axis equal;
%   [v2, f2] = mergeCoplanarFaces(v, f);
%   figure; drawMesh(v2, f2); 
%   view(3); axis equal; view(3);
%
%   See also
%     meshes3d, drawMesh, minConvexHull, triangulateFaces
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2006-07-05
% Copyright 2006 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

% 20/07/2006 add tolerance for coplanarity test
% 21/08/2006 fix small bug due to difference of methods to test
%   coplanaritity, sometimes resulting in 3 points of a face not coplanar !
%   Also add control on precision
% 14/08/2007 rename minConvexHull->meshReduce, and extend to non convex
%   shapes 
% 2011-01-14 code clean up
% 2013-02-22 rename from meshReduce to mergeCoplanarFaces


%% Process input arguments

% set up precision
acc = 1e-5;
if ~isempty(varargin)
    var = varargin{end};
    if length(var) == 1
        acc = var;
        varargin(end) = [];
    end
end

% extract faces and edges
if length(varargin) == 1
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


function labels = grLabel(nodes, edges)
%GRLABEL associate a label to each connected component of the graph
%   LABELS = grLabel(NODES, EDGES)
%   Returns an array with as many rows as the array NODES, containing index
%   number of each connected component of the graph. If the graph is
%   totally connected, returns an array of 1.
%
%   Example
%       nodes = rand(6, 2);
%       edges = [1 2;1 3;4 6];
%       labels = grLabel(nodes, edges);
%   labels =
%       1
%       1
%       1
%       2
%       3
%       2   
%
%   See also
%   getNeighbourNodes
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-08-14,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% init
nNodes = size(nodes, 1);
labels = (1:nNodes)';

% iteration
modif = true;
while modif
    modif = false;
    
    for i=1:nNodes
        neigh = getNeighbourNodes(i, edges);
        neighLabels = labels([i;neigh]);
        
        % check for a modification
        if length(unique(neighLabels))>1
            modif = true;
        end
        
        % put new labels
        labels(ismember(labels, neighLabels)) = min(neighLabels);
    end
end

% change to have fewer labels
labels2 = unique(labels);
for i = 1:length(labels2)
    labels(labels==labels2(i)) = i;
end

function nodes2 = getNeighbourNodes(node, edges)
%GETNEIGHBOURNODES find nodes adjacent to a given node
%
%   NEIGHS = getNeighbourNodes(NODE, EDGES)
%   NODE: index of the node
%   EDGES: the complete edges list
%   NEIGHS: the nodes adjacent to the given node.
%
%   NODE can also be a vector of node indices, in this case the result is
%   the set of neighbors of any input node.
%
%
%   -----
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 16/08/2004.
%

%   HISTORY
%   10/02/2004 documentation
%   13/07/2004 faster algorithm
%   03/10/2007 can specify several input nodes

[i, j] = find(ismember(edges, node));  %#ok<ASGLU>
nodes2 = edges(i,1:2);
nodes2 = unique(nodes2(:));
nodes2 = sort(nodes2(~ismember(nodes2, node)));

function curves = graph2Contours(nodes, edges) %#ok<INUSL>
%GRAPH2CONTOURS convert a graph to a set of contour curves
% 
%   CONTOURS = GRAPH2CONTOURS(NODES, EDGES)
%   NODES, EDGES is a graph representation (type "help graph" for details)
%   The algorithm assume every node has degree 2, and the set of edges
%   forms only closed loops. The result is a list of indices arrays, each
%   array containing consecutive point indices of a contour.
%
%   To transform contours into drawable curves, please use :
%   CURVES{i} = NODES(CONTOURS{i}, :);
%
%
%   NOTE : contours are not oriented. To manage contour orientation, edges
%   also need to be oriented. So we must precise generation of edges.
%
%   -----
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 05/08/2004.
%


curves = {};
c = 0;

while size(edges,1)>0
	% find first point of the curve
	n0 = edges(1,1);   
    curve = n0;
    
    % second point of the curve
	n = edges(1,2);	
	e = 1;
    
	while true
        % add current point to the curve
		curve = [curve n];         %#ok<AGROW>
		
        % remove current edge from the list
        edges = edges((1:size(edges,1))~=e,:);
		
		% find index of edge containing reference to current node
		e = find(edges(:,1)==n | edges(:,2)==n);		    
        e = e(1);
        
		% get index of next current node
        % (this is the other node of the current edge)
		if edges(e,1)==n
            n = edges(e,2);
		else
            n = edges(e,1);
		end
		
        % if node is same as start node, loop is closed, and we stop 
        % node iteration.
        if n==n0
            break;
        end
	end
    
    % remove the last edge of the curve from edge list.
    edges = edges((1:size(edges,1))~=e,:);
    
    % add the current curve to the list, and start a new curve
    c = c+1;
    curves{c} = curve; %#ok<AGROW>
end
