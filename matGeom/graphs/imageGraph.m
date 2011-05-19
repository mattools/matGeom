function varargout = imageGraph(img, varargin)
%IMAGEGRAPH Create equivalent graph of a binary image
%
%   [N E] = imageGraph(IMG);
%   or 
%   [N E F] = imageGraph(IMG);
%   create graph representing adjacencies in image. N is the array of
%   nodes, E is the array of edges, and F is a 4-columns array containing
%   indices of vertices of each face.
%   IMG can be either 2D or 3D image.
%   This functions uses only 4 neighbors in 2D, and 6 neighbors in 3D.
%
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 28/06/2004.
%

%   HISTORY


%% Initialisations

nodes = [];
edges = zeros(0, 2);
faces = zeros(0, 4);
cells = [];

dim = size(img);


%% Main processing

if ndims(img)==2
    N1 = dim(1);
    N2 = dim(2);
    
    % first find nodes, equivalent to pixels
    ind = find(img);
    [x y] = ind2sub([N1 N2], ind);
    nodes = [x y];
    
    % find vertical edges
    ind = find(img(1:N1, 1:N2-1) & img(1:N1, 2:N2));
    for i=1:length(ind)
        [x y] = ind2sub([N1 N2-1], ind(i));
        i1 = find(ismember(nodes, [x y], 'rows'));
        i2 = find(ismember(nodes, [x y+1], 'rows'));
        edges(size(edges, 1)+1, 1:2) = [i1 i2];
    end
    
    % find horizontal edges
    ind = find(img(1:N1-1, 1:N2) & img(2:N1, 1:N2));
    for i=1:length(ind)
        [x y] = ind2sub([N1-1 N2], ind(i));
        i1 = find(ismember(nodes, [x y], 'rows'));
        i2 = find(ismember(nodes, [x+1 y], 'rows'));
        edges(size(edges, 1)+1, 1:2) = [i1 i2];
    end
    
    % find faces
    ind = find(img(1:N1-1, 1:N2-1) & img(2:N1, 1:N2-1) & ...
               img(1:N1-1, 2:N2) & img(2:N1, 2:N2) );
    for i=1:length(ind)
        [x y] = ind2sub([N1-1 N2-1], ind(i));
        i1 = find(ismember(nodes, [x y], 'rows'));
        i2 = find(ismember(nodes, [x+1 y], 'rows'));
        i3 = find(ismember(nodes, [x+1 y+1], 'rows'));
        i4 = find(ismember(nodes, [x y+1], 'rows'));
        faces(size(faces, 1)+1, 1:4) = [i1 i2 i3 i4];
    end
    
elseif ndims(img)==3
    N1 = dim(1);
    N2 = dim(2);
    N3 = dim(3);
    
    % first find nodes, equivalent to pixels
    ind = find(img);
    [x y z] = ind2sub([N1 N2 N3], ind);
    nodes = [x y z];
    
    % find edges in direction 1
    ind = find(img(1:N1-1, 1:N2, 1:N3) & img(2:N1, 1:N2, 1:N3));
    [x y z] = ind2sub([N1-1 N2 N3], ind);
    i1 = find(ismember(nodes, [x y z], 'rows'));
    i2 = find(ismember(nodes, [x+1 y z], 'rows'));
    edges = [edges ; [i1 i2]];
  
    % find edges in direction 2
    ind = find(img(1:N1, 1:N2-1, 1:N3) & img(1:N1, 2:N2, 1:N3));
    [x y z] = ind2sub([N1 N2-1 N3], ind);
    i1 = find(ismember(nodes, [x y z], 'rows'));
    i2 = find(ismember(nodes, [x y+1 z], 'rows'));
    edges = [edges ; [i1 i2]];
   
    % find edges in direction 3
    ind = find(img(1:N1, 1:N2, 1:N3-1) & img(1:N1, 1:N2, 2:N3));
    [x y z] = ind2sub([N1 N2 N3-1], ind);
    i1 = find(ismember(nodes, [x y z], 'rows'));
    i2 = find(ismember(nodes, [x y z+1], 'rows'));
    edges = [edges ; [i1 i2]];
    
    
    % find faces in direction 1
    ind = find(img(1:N1, 1:N2-1, 1:N3-1) & img(1:N1, 1:N2-1, 2:N3) & ...
               img(1:N1, 2:N2, 1:N3-1)   & img(1:N1, 2:N2, 2:N3) );
    [x y z] = ind2sub([N1 N2-1 N3-1], ind);
    i1 = find(ismember(nodes, [x y z],  'rows'));
    i2 = find(ismember(nodes, [x y+1 z], 'rows'));
    i3 = find(ismember(nodes, [x y+1 z+1], 'rows'));
    i4 = find(ismember(nodes, [x y z+1], 'rows'));
    faces = [faces; [i1 i2 i3 i4]];
    
    % find faces in direction 2
    ind = find(img(1:N1-1, 1:N2, 1:N3-1) & img(1:N1-1, 1:N2, 2:N3) & ...
               img(2:N1, 1:N2, 1:N3-1)   & img(2:N1, 1:N2, 2:N3) );
    [x y z] = ind2sub([N1-1 N2 N3-1], ind);
    i1 = find(ismember(nodes, [x y z], 'rows'));
    i2 = find(ismember(nodes, [x+1 y z], 'rows'));
    i3 = find(ismember(nodes, [x+1 y z+1], 'rows'));
    i4 = find(ismember(nodes, [x y z+1], 'rows'));
    faces = [faces; [i1 i2 i3 i4]];
   
    % find faces in direction 3
    ind = find(img(1:N1-1, 1:N2-1, 1:N3) & img(1:N1-1, 2:N2, 1:N3) & ...
               img(2:N1, 1:N2-1, 1:N3)   & img(2:N1, 2:N2, 1:N3) );
    [x y z] = ind2sub([N1-1 N2-1 N3], ind);
    i1 = find(ismember(nodes, [x y z], 'rows'));
    i2 = find(ismember(nodes, [x+1 y z], 'rows'));
    i3 = find(ismember(nodes, [x+1 y+1 z], 'rows'));
    i4 = find(ismember(nodes, [x y+1 z], 'rows'));
    faces = [faces; [i1 i2 i3 i4]];
    
end


%% Format output

if nargout==1
    graph.nodes = nodes;
    graph.edges = edges;
    graph.faces = faces;
    if ndims(img)>2
        graph.cells =  cells;
    end
    varargout{1} = graph;    
elseif nargout==2
    varargout{1} = nodes;
    varargout{2} = edges;
elseif nargout==3
    varargout{1} = nodes;
    varargout{2} = edges;
    varargout{3} = faces;
end



