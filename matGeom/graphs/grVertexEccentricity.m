function g = grVertexEccentricity(v, e, l, inds)
%GRVERTEXECCENTRICITY Eccentricity of vertices in the graph
%
%   G = grVertexEccentricity(V, E, L)
%   V is the array of vertices
%   E is the array of edges
%   L is a column vector containing length of each edge (assumes 1 for each
%   edge if not specified).
%   G is the maximal geodesic length of each vertex.
%
%   G = grVertexEccentricity(V, E, L, INDV)
%   Compute eccentricity only for vertices whose index is given in INDV.
%
%   Example
%     nodes = [20 20;20 50;20 80;50 50;80 20;80 50;80 80];
%     edges = [1 2;2 3;2 4;4 6;5 6;6 7];
%     figure; drawGraph(nodes, edges);
%     axis([0 100 0 100]); axis equal; hold on
%     G = grVertexEccentricity(nodes, edges);
%     drawNodeLabels(nodes+2, G);
%
%   See Also
%   graphRadius, graphCenter, graphDiameter, graphPeripheralVertices
%   grPropagateDistance
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-09-07,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% init result
Nv = size(v, 1);
g = zeros(Nv, 1);

% ensure there is a valid length array
if nargin<3
    l = ones(size(e,1), 1);
end

if nargin<4
    inds = 1:Nv;
end

% compuite maximal geodesic length for each vertex
for i=1:Nv
    g(i) = max(grPropagateDistance(v, e, inds(i), l));
end
