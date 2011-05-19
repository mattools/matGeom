function [v e] = quiverToGraph(x, y, dx, dy)
%QUIVERTOGRAPH Converts quiver data to quad mesh
%
%   [V E] = quiverToGraph(x, y, dx, dy)
%   x, y, dx and dy are matrices the same dimension, typically ones used
%   for display using 'quiver'.
%   V and E are vertex coordinates, and edge vertex indices of the graph
%   joining end points of vector arrows.
%
%   Example
%   quiverToGraph
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-06-16,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% compute vertex coordinates
vx = x+dx;
vy = y+dy;
v = [vx(:) vy(:)];

% index of vertices
labels = reshape(1:numel(x), size(x));

% compute indices of vertical edges
N1 = numel(labels(1:end-1,:));
vedges = [reshape(labels(1:end-1, :), [N1 1]) reshape(labels(2:end, :), [N1 1])];

% compute indices of horizontal edges
N2 = numel(labels(:, 1:end-1));
hedges = [reshape(labels(:, 1:end-1), [N2 1]) reshape(labels(:, 2:end), [N2 1])];

% concatenate horizontal and vertical edges
e = [hedges ; vedges];