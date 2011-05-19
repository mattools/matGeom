function varargout = clipGraph(nodes, edges, varargin)
%CLIPGRAPH Clip a graph with a rectangular area
%
%   [N2 E2] = clipGraph(N, E, BOX);
%   [N2 E2 F2] = clipGraph(N, E, F, BOX);
%   N is an array ov vertices, E an array of edges, containing indices of
%   first ans second vertices, and F (optional) is either a matrice or a
%   cell array containing indices of vertices for each face.
%   BOX is either a box given as a matrix: [XMIN XMAX;YMIN YMAX], or a row
%   vector following matlab axis format: [XMIN XMAX YMIN YMAX].
%
%   Example
%   clipGraph
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-01-18
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.


%% Format inputs

% extract input arguments
faces = [];
if length(varargin)==1
    box     = varargin{1};
elseif length(varargin)==2
    faces   = varargin{1};
    box     = varargin{2};
else
    error('Wrong number of  arguments in clipGraph');
end

% uniformization of input for box.
box = box';
box = box(:);

% accuracy of numeric computations
ACC = 1e-14;


%% Get bounding lines

% get bounds of the box
xmin = box(1);
xmax = box(2);
ymin = box(3);
ymax = box(4);

% create box corners
corners = [ ...
    xmin ymin; ...
    xmin ymax; ...
    xmax ymin; ...
    xmax ymax]; ...

%% Clip the nodes

% find nodes inside clipping window
insideNodes = ...
    nodes(:,1)-xmin>ACC & nodes(:,1)-xmax<ACC & ...
    nodes(:,2)-ymin>ACC & nodes(:,2)-ymax<ACC;

% convert to indices
indNodes = find(insideNodes);

% create correspondance between original nodes and inside nodes
hashNodes = zeros(size(nodes, 1), 1);
for i=1:length(indNodes)
    hashNodes(indNodes(i)) = i;
end

% select clipepd nodes
nodes2 = nodes(indNodes, :);


%% Clip edges

% initialize empty array
edges2 = zeros([0 2]);

% create correspondance map between old edges and clipped edges.
hashEdges = zeros(size(edges, 1), 1);


% iterate over each edge
for e=1:size(edges, 1)    
    % current edge
    edge = [nodes(edges(e, 1), :) nodes(edges(e, 2), :)];
    
    % flags to indicate whether nodes are inside box or not
    in1 = ismember(edges(e, 1), indNodes);
    in2 = ismember(edges(e, 2), indNodes);
    
    % check if edge is totally inside window -> no clip
    if in1 && in2
        edges2 = [edges2; hashNodes(edges(e, :))']; %#ok<AGROW>
        hashEdges(e) = size(edges2, 1);
        continue;
    end

    % check that edge is not totally clipped -> no edge
    if edge(1)-xmin<ACC && edge(3)-xmin<ACC, continue; end
    if edge(1)-xmax>ACC && edge(3)-xmax>ACC, continue; end
    if edge(2)-ymin<ACC && edge(4)-ymin<ACC, continue; end
    if edge(2)-ymax>ACC && edge(4)-ymax>ACC, continue; end
   
    % otherwise, we have to clip the edge !
    edge = clipEdge(edge, [box(1) box(2); box(3) box(4)]);
    
    % display debug info
    %disp(sprintf('clip edge n°%2d, from %2d to %2d', e, edges(e,1), edges(e,2)));
    
    % Node for first vertex
    if ~in1
        nodes2 = [nodes2; edge([1 2])]; %#ok<AGROW>
        indN1 = size(nodes2, 1);
    else
        indN1 = hashNodes(edges(e, 1));
    end
    
    % Node for second vertex
    if ~in2
        nodes2 = [nodes2; edge([3 4])]; %#ok<AGROW>
        indN2 = size(nodes2, 1);
    else
        indN2 = hashNodes(edges(e, 2));
    end
    
    % add clipped edge to the list
    edges2 = [edges2; indN1 indN2]; %#ok<AGROW>
    hashEdges(e) = size(edges2, 1);
end
    

%% Clip the faces
faces2 = {};
for f = 1:length(faces)
    % indices of vertices of current face
    face = faces{f};
    
    % if the face is not clipped, use directly new indices of nodes
    face2 = hashNodes(face)';
    if ~ismember(0, face2)
        faces2 = [faces2, {face2}]; %#ok<AGROW>
        continue;
    end
    
    % At least one vertex is clipped. Here is some more special processing
    
    % edges of current face
    faceEdges = sort([face' face([2:end 1])'], 2);
    
    % indices of face edges in edges array
    indEdges = ismember(edges, faceEdges, 'rows');
    
    % convert to indices of edges in clipped edges array. indEdges with
    % value=0 correspond to totally clipped edges, and can be removed.
    indEdges = hashEdges(indEdges);
    indEdges = indEdges(indEdges~=0);
    
    % case of face totally clipped: break and continuue with next face
    if isempty(indEdges)
        continue;
    end
    
    % extract indices of vertices of the clipped face
    face2 = edges2(indEdges, :);
    face2 = unique(face2(:));

    % Test whether one should add one of the corner of the box.
    poly = [nodes(face, 1) nodes(face, 2)];
    ind = inpolygon(corners(:,1), corners(:,2), poly(:,1), poly(:,2));
    if sum(ind)>0
        nodes2 = [nodes2; corners(ind, :)]; %#ok<AGROW>
        face2 = [face2; size(nodes2, 1)]; %#ok<AGROW>
    end
    
    % vertices of the face, as points
    faceNodes = nodes2(face2, :);

    % sort vertices according to their angle around the centroid
    [faceNodes I] = angleSort(faceNodes, centroid(faceNodes)); %#ok<ASGLU>
    
    % add current face to list of faces
    faces2 = [faces2, {face2(I)'}]; %#ok<AGROW>
end


%% Format output arguments

% clean up nodes to ensure coord correspond to clipping box.
nodes2(:,1) = min(max(nodes2(:,1), box(1)), box(2));
nodes2(:,2) = min(max(nodes2(:,2), box(3)), box(4));

if nargout==2
    varargout{1} = nodes2;
    varargout{2} = edges2;
elseif nargout==3
    varargout{1} = nodes2;
    varargout{2} = edges2;
    varargout{3} = faces2;
end    

