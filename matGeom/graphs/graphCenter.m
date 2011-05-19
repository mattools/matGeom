function center = graphCenter(v, e, l)
%GRAPHCENTER Center of a graph
%
%   CENTER = graphCenter(V, E)
%   Computes the center of the graph given by V and E. The center of the
%   graph is the set of vertices whose eccentricity is minimal. The
%   function returns indices of center vertices.
%
%   CENTER = graphCenter(V, E, L)
%   Specifies the weight of each edge for computing the distances. Default
%   is to consider a weight of 1 for each edge.
%
%   Example
%     nodes = [20 20;20 50;20 80;50 50;80 20;80 50;80 80];
%     edges = [1 2;2 3;2 4;4 6;5 6;6 7];
%     figure; drawGraph(nodes, edges);
%     axis([0 100 0 100]); axis equal; hold on
%     C = graphCenter(nodes, edges)
%     C = 
%         4  
%
%   See Also
%   grPropagateDistance, grVertexEccentricity
%   graphRadius, graphDiameter, graphPeripheralVertices
%
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

center = find(g==min(g));
