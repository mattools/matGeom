function [nodes, edges, faces] = gcontour3d(img)
%GCONTOUR3D Create contour graph of a 3D binary image.
%
%
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 28/06/2004.
%

nodes = zeros([0 3]);   % 3 coordinates vertices
edges = zeros([0 2]);   % first node and second nodes
faces = zeros([0 4]);   % indices of 4 corners of each square face

D1 = size(img, 1);
D2 = size(img, 2);
D3 = size(img, 3);

% first direction for image
for y=1:D2  
    for z=1:D3
        % find transitions between the two phases
        ind = find(img(1:D1-1, y, z)~=img(2:D1, y, z));
    
        % process each transition in direction 1
        for i2 = 1:length(ind)
        
            % coordinates of each node
            n1 = [ind(i2)+.5 y-.5 z-.5];
            n2 = [ind(i2)+.5 y-.5 z+.5];
            n3 = [ind(i2)+.5 y+.5 z+.5];
            n4 = [ind(i2)+.5 y+.5 z-.5];
        
            % add the face (and edges) with the 4 given nodes
            [nodes edges faces] = addFace(nodes, edges, faces, [n1; n2; n3; n4]);
        end        
    end
end

% second direction for image
for x=1:D1  
    for z=1:D3
        % find transitions between the two phases
        ind = find(img(x, 1:D2-1, z)~=img(x, 2:D2, z));
    
        % process each transition in direction 1
        for i2 = 1:length(ind)
        
            % coordinates of each node
            n1 = [x-.5 ind(i2)+.5 z-.5];
            n2 = [x-.5 ind(i2)+.5 z+.5];
            n3 = [x+.5 ind(i2)+.5 z+.5];
            n4 = [x+.5 ind(i2)+.5 z-.5];           
        
            % add the face (and edges) with the 4 given nodes
            [nodes edges faces] = addFace(nodes, edges, faces, [n1; n2; n3; n4]);
        end        
    end
end

% third direction for image
for x=1:D1  
    for y=1:D2
        % find transitions between the two phases
        ind = find(img(x, y, 1:D3-1)~=img(x, y, 2:D3));
    
        % process each transition in direction 1
        for i2 = 1:length(ind)
        
            % coordinates of each node
            n1 = [x-.5 y-.5 ind(i2)+.5];
            n2 = [x-.5 y+.5 ind(i2)+.5];
            n3 = [x+.5 y+.5 ind(i2)+.5];
            n4 = [x+.5 y-.5 ind(i2)+.5];
        
            % add the face (and edges) with the 4 given nodes
            [nodes edges faces] = addFace(nodes, edges, faces, [n1; n2; n3; n4]);
        end        
    end
end



return;



function [nodes, edges, faces] = addFace(nodes, edges, faces, faceNodes)
% add given nodes and coresponding face to the graph.


n1 = faceNodes(1,:);
n2 = faceNodes(2,:);
n3 = faceNodes(3,:);
n4 = faceNodes(4,:);

% search indices of each nodes
ind1 = find(ismember(nodes, n1, 'rows'));       
ind2 = find(ismember(nodes, n2, 'rows'));
ind3 = find(ismember(nodes, n3, 'rows'));       
ind4 = find(ismember(nodes, n4, 'rows'));

% if nodes are not in the list, we add them
if isempty(ind1)
    nodes = [nodes; n1];
    ind1 = size(nodes, 1);
end
if isempty(ind2)
    nodes = [nodes; n2];
    ind2 = size(nodes, 1);
end
if isempty(ind3)
    nodes = [nodes; n3];
    ind3 = size(nodes, 1);
end
if isempty(ind4)
    nodes = [nodes; n4];
    ind4 = size(nodes, 1);
end

% add current face to the list
faces(size(faces, 1)+1, 1:4) = [ind1(1) ind2(1) ind3(1) ind4(1)];

% create edges of the face 
% (first index is the smallest one, by convention)
e1 = [min(ind1, ind2) max(ind1, ind2)];
e2 = [min(ind2, ind3) max(ind2, ind3)];
e3 = [min(ind3, ind4) max(ind3, ind4)];
e4 = [min(ind4, ind1) max(ind4, ind1)];

 % if nodes are not in the list, we add them
if isempty(find(ismember(edges, e1, 'rows'), 1))
    edges = [edges; e1];
end
if isempty(find(ismember(edges, e2, 'rows'), 1))
    edges = [edges; e2];
end
if isempty(find(ismember(edges, e3, 'rows'), 1))
    edges = [edges; e3];
end
if isempty(find(ismember(edges, e4, 'rows'), 1))
    edges = [edges; e4];
end
