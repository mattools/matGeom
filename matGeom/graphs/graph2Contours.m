function varargout = graph2Contours(nodes, edges) %#ok<INUSL>
%GRAPH2CONTOURS Convert a graph to a set of contour curves
% 
%   CONTOURS = GRAPH2CONTOURS(NODES, EDGES)
%   NODES, EDGES is a graph representation (type "help graphs" for details)
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

if nargout == 1
    varargout = {curves};
end
