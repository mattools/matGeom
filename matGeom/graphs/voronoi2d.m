function [nodes, edges, faces] = voronoi2d(germs)
%VORONOI2D Compute a voronoi diagram as a graph structure
%   
%   [NODES, EDGES, FACES] = voronoi2d(GERMS)
%   GERMS an array of points with dimension 2
%   NODES, EDGES, FACES: usual graph representation, FACES as cell array
%
%   Example
%   [n e f] = voronoi2d(rand(100, 2)*100);
%   drawGraph(n, e);
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2007-01-12
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% compute generic Voronoi diagram
[V, C] = voronoin(germs);

% declaration of array for storing results
nodes = V(2:end, :);
edges = zeros(0, 2);
faces = {};

% iterate on voronoi 'cells'
for i = 1:length(C)
    % get node indices of current polygonal domain
    cell = C{i};
    
    % do not process unbounded domains
    if ismember(1, cell)
        continue;
    end
    
    % fix indexing of nodes
    cell = cell - 1;
    
    % compute indices of edge and domain nodes 
    edges = [edges; sort([cell' cell([2:end 1])'], 2)]; %#ok<AGROW>
    faces{length(faces)+1} = cell; %#ok<AGROW>
end

% remove duplicate edges
edges = unique(edges, 'rows');
