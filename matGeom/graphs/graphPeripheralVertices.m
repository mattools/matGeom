function inds = graphPeripheralVertices(v, e, l)
%GRAPHPERIPHERALVERTICES Peripheral vertices of a graph
%
%   INDS = graphPeripheralVertices(V, E)
%   Return indices of peripheral vertices, that is, vertices whose
%   eccentricity is maximal and equal to the diameter of the graph.
%
%   INDS = graphPeripheralVertices(V, E, L)
%   Specify length of each edge. Default is 1 for each edge.
%
%
%   Example
%     nodes = [20 20;20 50;20 80;50 50;80 20;80 50;80 80];
%     edges = [1 2;2 3;2 4;4 6;5 6;6 7];
%     figure; drawGraph(nodes, edges);
%     axis([0 100 0 100]); axis equal; hold on
%     INDP = graphPeripheralVertices(nodes, edges);
%     INDP = 
%         1
%         3
%         5
%         7
%         
%
%   See Also
%   grPropagateDistance, grVertexEccentricity
%   graphCenter, graphDiameter, graphRadius
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

inds = find(g==max(g));
