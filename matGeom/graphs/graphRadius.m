function r = graphRadius(v, e, l)
%GRAPHRADIUS Radius of a graph
%
%   R = graphRadius(V, E)
%   Computes the radius of the graph given by V and E. The radius of the
%   graph is the smallest eccentricity over all vertices in the graph.
%
%   R = graphRadius(V, E, L)
%   Specifies the weight of each edge for computing the distances. Default
%   is to consider a weight of 1 for each edge.
%
%   Example
%     nodes = [20 20;20 50;20 80;50 50;80 20;80 50;80 80];
%     edges = [1 2;2 3;2 4;4 6;5 6;6 7];
%     figure; drawGraph(nodes, edges);
%     axis([0 100 0 100]); axis equal; hold on
%     R = graphRadius(nodes, edges)
%     R = 
%          2
%
%   See Also
%   grPropagateDistance, grVertexEccentricity
%   graphCenter, graphDiameter, graphPeripheralVertices
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-09-07,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% ensure there is a valid length array
if nargin<3
    l = ones(size(e,1), 1);
end

g = grVertexEccentricity(v, e, l);

r = min(g);