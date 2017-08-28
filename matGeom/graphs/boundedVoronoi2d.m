function [nodes, edges, faces] = boundedVoronoi2d(box, germs)
%BOUNDEDVORONOI2D Return a bounded voronoi diagram as a graph structure
%   
%   [NODES, EDGES, FACES] = boundedVoronoi2d(BOX, GERMS)
%   GERMS an array of points with dimension 2
%   NODES, EDGES, FACES: usual graph representation, FACES as cell array
%
%   Example
%   [n, e, f] = boundedVoronoi2d([0 100 0 100], rand(100, 2)*100);
%   drawGraph(n, e);
%
%   See also
%     graphs, boundedCentroidalVoronoi2d, clipGraph, clipGraphPolygon

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2007-01-12
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% uniformize input for box.
box = box';
box = box(:);

% add points far enough
boxSizeX  = box(2) - box(1);
boxSizeY  = box(4) - box(3);
farPoints = [...
    box(2)+2*boxSizeX  box(4)+3*boxSizeY;...
    box(1)-3*boxSizeX  box(4)+2*boxSizeY;...
    box(1)-2*boxSizeX  box(3)-3*boxSizeY;...
    box(2)+3*boxSizeX  box(3)-2*boxSizeY;...
    ];

% extract voronoi vertices and face structure
[V, C] = voronoin([germs ; farPoints]);

% initialize graph structure, without edges and without faces
nodes = V(2:end, :);
edges = zeros(0, 2);
faces = {};

for i = 1:size(germs, 1)   
    cell = C{i};
    cell = cell-1;
    edges = [edges; sort([cell' cell([2:end 1])'], 2)]; %#ok<AGROW>
    faces{length(faces)+1} = cell; %#ok<AGROW>
end

edges = unique(edges, 'rows');


