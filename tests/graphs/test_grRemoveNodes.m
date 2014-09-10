function test_suite = test_grRemoveNodes(varargin) %#ok<STOUT>
%TEST_GRREMOVENODES  Test case for the file grRemoveNodes
%
%   Test case for the file grRemoveNodes

%   Example
%   test_grRemoveNodes
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2014-03-07,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2014 INRA - Cepia Software Platform.

initTestSuite;

function test_RemoveOneVertex %#ok<*DEFNU>
% Test call of function without argument
[nodes, edges] = makeSimpleGraph();
[nodes2, edges2] = grRemoveNodes(nodes, edges, 3);
assertEqual(5, size(nodes2, 1));
assertEqual(7, size(edges2, 1));

function test_RemoveTwoMiddleVertices
% Test call of function without argument
[nodes, edges] = makeSimpleGraph();
[nodes2, edges2] = grRemoveNodes(nodes, edges, [3 4]);
assertEqual(4, size(nodes2, 1));
assertEqual(5, size(edges2, 1));

function test_RemoveTwoExtremeVertices
% Test call of function without argument
[nodes, edges] = makeSimpleGraph();
[nodes2, edges2] = grRemoveNodes(nodes, edges, [1 6]);
assertEqual(4, size(nodes2, 1));
assertEqual(3, size(edges2, 1));


function [nodes, edges] = makeSimpleGraph()
nodes = [...
    10 10; 20 10; 30 10; ...
    10 20; 20 20; 30 20];
edges = [...
    1 2; 1 4; 1 5; ...
    2 3; 2 5; 2 6; ...
    3 6; 4 5; 5 6];
    