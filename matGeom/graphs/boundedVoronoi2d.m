function [nodes, edges, faces] = boundedVoronoi2d(box, germs)
%BOUNDEDVORONOI2D Computes a bounded voronoi diagram as a graph structure.
%   
%   [NODES, EDGES, FACES] = boundedVoronoi2d(BOX, GERMS)
%   GERMS an array of points with dimension 2
%   NODES, EDGES, FACES: usual graph representation, FACES as cell array
%
%   Example
%     % clip a graph with
%     box = [0 100 0 100];
%     [n, e, f] = boundedVoronoi2d(box, rand(100, 2)*100);
%     [n, e, f] = clipGraph(n, e, f, box);
%     drawGraph(n, e);
%
%   See also 
%     graphs, boundedCentroidalVoronoi2d, clipGraph, clipGraphPolygon

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2007-01-12
% Copyright 2007-2023 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas

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
faces = cell(1, size(germs, 1));

% for each cell associated to a germ, we retrieve the nodes of the Voronoi
% diagram, remove 1 because first vertex at infinity is removed, keep the
% list of vertices that constitute the face, and generate the set of edges
% around face. 
for i = 1:size(germs, 1)   
    face = C{i};
    face = face-1;
    faces{i} = face;
    edges = [edges; sort([face' face([2:end 1])'], 2)]; %#ok<AGROW>
end

% remove duplicate edges as they were created twice (once for each face)
edges = unique(edges, 'rows');

