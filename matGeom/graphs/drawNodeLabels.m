function varargout = drawNodeLabels(nodes, value)
%DRAWNODELABELS Draw values associated to graph nodes
% 
%   Usage:
%   drawNodeLabels(NODES, VALUES);
%   NODES: array of double, containing x and y values of nodes
%   VALUES is an array the same length of EDGES, containing values
%   associated to each edges of the graph.
%
%   H = drawNodeLabels(...) 
%   Returns array of handles to each text structure, making it possible to
%   change font, color, size 
%
%   -----
%   author: David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 10/02/2003.
%

%   HISTORY
%   10/03/2004 included into lib/graph library

% number and dimension of nodes
Nn = size(nodes, 1);
Nd = size(nodes, 2);

% check input size
if length(value) ~= Nn
    error('Value array must have same length as node number');
end

% allocate memory
h = zeros(Nn, 1);

if Nd == 2
    % Draw labels of 2D nodes
    for i = 1:Nn
        x = nodes(i, 1);
        y = nodes(i, 2);
        h(i) = text(x, y, sprintf('%3d', floor(value(i))));
    end
    
elseif Nd == 3
    % Draw labels of 3D nodes
    for i = 1:Nn
        x = nodes(i, 1);
        y = nodes(i, 2);
        z = nodes(i, 3);
        h(i) = text(x, y, z, sprintf('%3d', floor(value(i))));
    end
    
else
    error('Node dimension must be 2 or 3');
end

if nargout == 1
    varargout = {h};
end
