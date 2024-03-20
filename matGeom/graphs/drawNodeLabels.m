function varargout = drawNodeLabels(nodes, value, varargin)
%DRAWNODELABELS Draw values associated to graph nodes.
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

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-02-10
% Copyright 2003-2023 INRA - TPV URPOI - BIA IMASTE

% extract handle of axis to draw on
if isAxisHandle(nodes)
    ax = nodes;
    nodes = value;
    value = varargin{1};
else
    ax = gca;
end

% number and dimension of nodes
Nn = size(nodes, 1);
Nd = size(nodes, 2);

% check input size
if length(value) ~= Nn
    error('Value array must have same length as node number');
end

% allocate memory
h = zeros(Nn, 1);

axes(ax);

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
