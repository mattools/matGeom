function varargout = boundaryGraph(img)
%BOUNDARYGRAPH Get boundary of image as a graph
%
%   [NODES, EDGES] = boundaryGraph(IMG)         (2D)
%   [NODES, EDGES, FACES] = boundaryGraph(IMG)  (3D)
%   Create a graph on the boundary of binary image IMG. Each pixel is
%   considered as a unit square (or cube), centered on integer coordinates. 
%   Boundary of the shape is selected as a graph.
%
%   Result is a set of nodes with (x,y) or (x,y,z) coordinates, a set of
%   edges linking two neighbour nodes, and in 3D also a set of square
%   faces, containing reference to each 4-tuple of nodes.
%   
%   The resulting shell is open if the binary structure touches edges of
%   image.
%
%   See also :
%   imPatch, drawMesh
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 28/06/2004.
%

%   HISTORY
%   05/08/2004 : change name and add 2D case.


dim = size(img);
nd = length(dim);
if nd==2 && (dim(1)==1 || dim(2)==1)
    nd=1;
end


nodes = zeros([0 nd]);  % coordinates of vertices
edges = zeros([0 2]);   % first node and second nodes
faces = zeros([0 4]);   % indices of 4 corners of each square face

if nd==1
    img = img(:)>0;
    D1 = size(img,1);
    nodes = find(img(1:D1-1)~=img(2:D1))+.5;
    
    if nargout==1
        varargout{1} = nodes;
    end
    return
    
elseif nd==2
    D1 = size(img, 1);
	D2 = size(img, 2);
	
	px = [];
	py = [];
	
	ind = find(img(1:D1-1, :)~=img(2:D1, :));
	[x y] = ind2sub([D1-1 D2], ind);
	px = [px; reshape([x+.5 x+.5]', length(x)*2,1)];
	py = [py; reshape([y-.5 y+.5]', length(x)*2,1)];
	
	ind = find(img(:, 1:D2-1)~=img(:, 2:D2));
	[x y] = ind2sub([D1 D2-1], ind);
	px = [px; reshape([x-.5 x+.5]', length(x)*2,1)];
	py = [py; reshape([y+.5 y+.5]', length(x)*2,1)];	
	
	[nodes, i, j] = unique([py px], 'rows'); %#ok<ASGLU>
	

	ne = floor(size(px, 1)/2);
	edges = repmat(1:2, [ne 1]) + repmat((0:2:2*ne-1)', [1 2]);
	
	for i=1:length(edges(:))
        edges(i) = j(edges(i));
	end
    edges = unique(sort(edges, 2), 'rows');
    
elseif nd==3
	D1 = size(img, 1);
	D2 = size(img, 2);
	D3 = size(img, 3);
	
	px = [];
	py = [];
	pz = [];
	
	ind = find(img(1:D1-1, :, :)~=img(2:D1, :, :));
	[x y z] = ind2sub([D1-1 D2 D3], ind);
	px = [px; reshape([x+.5 x+.5 x+.5 x+.5]', length(x)*4,1)];
	py = [py; reshape([y-.5 y+.5 y+.5 y-.5]', length(x)*4,1)];
	pz = [pz; reshape([z-.5 z-.5 z+.5 z+.5]', length(x)*4,1)];
	
	
	ind = find(img(:, 1:D2-1, :)~=img(:, 2:D2, :));
	[x y z] = ind2sub([D1 D2-1 D3], ind);
	px = [px; reshape([x-.5 x-.5 x+.5 x+.5]', length(x)*4,1)];
	py = [py; reshape([y+.5 y+.5 y+.5 y+.5]', length(x)*4,1)];
	pz = [pz; reshape([z-.5 z+.5 z+.5 z-.5]', length(x)*4,1)];
	
	ind = find(img(:, :, 1:D3-1)~=img(:, :, 2:D3));
	[x y z] = ind2sub([D1 D2 D3-1], ind);
	px = [px; reshape([x-.5 x+.5 x+.5 x-.5]', length(x)*4,1)];
	py = [py; reshape([y-.5 y-.5 y+.5 y+.5]', length(x)*4,1)];
	pz = [pz; reshape([z+.5 z+.5 z+.5 z+.5]', length(x)*4,1)];
	
	
	[nodes, i, j] = unique([py px pz], 'rows'); %#ok<ASGLU>
	
	nf = floor(size(px, 1)/4);
	faces = repmat(1:4, [nf 1]) + repmat((0:4:4*nf-1)', [1 4]);
	
	for i=1:length(faces(:))
        faces(i) = j(faces(i));
	end
	
	edges = [edges ; [faces(:,1) faces(:,2)]];
	edges = [edges ; [faces(:,2) faces(:,3)]];
	edges = [edges ; [faces(:,3) faces(:,4)]];
	edges = [edges ; [faces(:,4) faces(:,1)]];
	edges = unique(sort(edges, 2), 'rows');
end


% format output arguments

if nargout==3
    varargout{1} = nodes;
    varargout{2} = edges;
    varargout{3} = faces;
elseif nargout==2
    varargout{1} = nodes;
    varargout{2} = edges;
elseif nargout==1
    graph.nodes = nodes;
    graph.edges = edges;
    graph.faces = faces;
    varargout{1} = graph;
end
