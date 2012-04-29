function showTestGraph03(varargin)
%SHOWTESTGRAPH03  One-line description here, please.
%
%   output = showTestGraph03(input)
%
%   Example
%   showTestGraph03
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-23,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

%% Base graph

[nodes edges] = createTestGraph03;

figure(1); clf;
drawGraph(nodes, edges);
hold on;


axis([0 150 0 100]);
axis equal;


%% Node labels

drawNodeLabels(nodes, 1:size(nodes, 1));

%% Node edges

drawEdgeLabels(nodes, edges, 1:size(edges, 1));

print(gcf, 'plots/testGraph03.png', '-dpng');
print(gcf, 'plots/testGraph03.eps', '-depsc2');
