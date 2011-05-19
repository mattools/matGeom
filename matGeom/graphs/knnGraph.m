function edges = knnGraph(nodes, varargin)
%KNNGRAPH Create the k-nearest neighbors graph of a set of points
%
%   EDGES = knnGraph(NODES)
%
%   Example
%   nodes = rand(10, 2);
%   edges = knnGraph(nodes);
%   drawGraph(nodes, edges);
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2008-07-28,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% get number of neighbors for each node
k = 2;
if ~isempty(varargin)
    k = varargin{1};
end

% init size of arrays
n       = size(nodes, 1);
edges   = zeros(k*n, 2);

% iterate on nodes
for i = 1:n
    dists = distancePoints(nodes(i,:), nodes);
    [dists inds]    = sort(dists); %#ok<ASGLU>
    for j = 1:k
        edges(k*(i-1)+j, :) = [i inds(j+1)];
    end
end

% remove double edges
edges = unique(sort(edges, 2), 'rows');
