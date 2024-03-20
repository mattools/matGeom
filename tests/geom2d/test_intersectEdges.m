function test_suite = test_intersectEdges 
%TESTINTERSECTEDGES Unit test suite for function intersectEdges.
%   output = testIntersectEdges(input)
%
%   Example
%   testIntersectEdges
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 


function testOrthogonal(testCase) %#ok<*DEFNU>
% basic test with two orthogonal edges
edge1 = [1 2 5 2];
edge2 = [3 1 3 4];
assertEqual(testCase, intersectEdges(edge1, edge2), [3 2], 'AbsTol', .01);
assertEqual(testCase, intersectEdges(edge2, edge1), [3 2], 'AbsTol', .01);


function testParallel(testCase)
% basic test with two parallel edges
edge1 = [1 2 4 4];
edge2 = [2 1 8 5];
assertTrue(testCase, sum(isnan(intersectEdges(edge1, edge2)))==2);
assertTrue(testCase, sum(isnan(intersectEdges(edge2, edge1)))==2);


function testColinearIntersect(testCase)
% basic test with two colinear edges
edge1 = [1 2 7 6];
edge2 = [4 4 13 10];
assertTrue(testCase, sum(isinf(intersectEdges(edge1, edge2)))==2);
assertTrue(testCase, sum(isinf(intersectEdges(edge2, edge1)))==2);


function testColinearDisjoint(testCase)
% basic test with two parallel edges
edge1 = [1 2 4 4];
edge2 = [7 6 13 10];
assertTrue(testCase, sum(isnan(intersectEdges(edge1, edge2)))==2);
assertTrue(testCase, sum(isnan(intersectEdges(edge1, edge2)))==2);


function testColinearTouches1(testCase)
% basic test with two parallel edges
eps = 1e-14;
edge1 = [1 2 7 6];
edge2 = [7 6 10 8];
assertEqual(testCase, intersectEdges(edge1, edge2), [7 6], 'AbsTol', eps);
assertEqual(testCase, intersectEdges(edge2, edge1), [7 6], 'AbsTol', eps);


function testColinearTouches2(testCase)
% basic test with two parallel edges
eps = 1e-14;
edge1 = [1 2 7 6];
edge2 = [10 8 7 6];
assertEqual(testCase, intersectEdges(edge1, edge2), [7 6], 'AbsTol', eps);
assertEqual(testCase, intersectEdges(edge2, edge1), [7 6], 'AbsTol', eps);


function testLargeDerivative(testCase)
% check for dx and dy very big
edge1 = [1 2 50000 2];
edge2 = [3 1 3 4];
assertEqual(testCase, intersectEdges(edge1, edge2), [3 2]);


function testDiagonal(testCase)
% check diagonal edges
edge1 = [5 1 1 5];
edge2 = [2 2 2 6];
assertEqual(testCase, intersectEdges(edge1, edge2), [2 4], 'AbsTol', .01);

edge3 = [3 1 6 4];
assertEqual(testCase, intersectEdges(edge1, edge3), [4 2], 'AbsTol', .01);


function testWithNaN(testCase)
% check comparison with NaN
edge2 = [2 2 2 6];
edge3 = [3 1 6 4];
assertEqual(testCase, intersectEdges(edge2, edge3), [NaN NaN]);


function testOneCorner(testCase)
% check intersection with one corner
edge1 = [5 1 1 5];
edge2 = [0 5 3 5];
assertEqual(testCase, intersectEdges(edge1, edge2), [1 5], 'AbsTol', .01);


function testTwoCorners(testCase)
% both with one corner
edge1 = [5 1 1 5];
edge2 = [1 5 3 5];
assertEqual(testCase, intersectEdges(edge1, edge2), [1 5], 'AbsTol', .01);


function test_singleEdge_multipleEdges(testCase)
% Check intersection of two edge groups

edges1 = [20 10 20 40];
edges2 = [10 20 30 20; 10 30 30 30; 10 50 30 50];
inters = intersectEdges(edges1, edges2);
assertEqual(testCase, [3 2], size(inters));

expected = [20 20;20 30;NaN NaN];
assertEqual(testCase, expected, inters, 'AbsTol', .01);


function test_multipleEdges_singleEdge(testCase)
% Check intersection of two edge groups

edges1 = [10 20 30 20; 10 30 30 30; 10 50 30 50];
edges2 = [20 10 20 40];
inters = intersectEdges(edges1, edges2);
assertEqual(testCase, [3 2], size(inters));

expected = [20 20;20 30;NaN NaN];
assertEqual(testCase, expected, inters, 'AbsTol', .01);


function testSeveralEdgesWithParallelAndColinear(testCase)
% Check intersection of two edge groups

edges1 = [10 20 40 20];
edges2 = [10 20 30 20; 30 10 30 30; 10 50 30 50];

inters = intersectEdges(edges1, edges2);
assertEqual(testCase, [3 2], size(inters));

expected = [Inf Inf;30 20;NaN NaN];
assertEqual(testCase, expected, inters, 'AbsTol', .01);


function test_severalColinear(testCase)
% check with four colinear edges with different configurations:
% two edges that touch, one that is inside, one that is outside

edges1 = [20 20 30 20];
edges2 = [10 20 20 20; 30 20 40 20; 22 20 28 20; 35 20 45 20];

inters = intersectEdges(edges1, edges2);
assertEqual(testCase, [4 2], size(inters));

% expected = [Inf Inf;30 20;NaN NaN];
% assertEqual(testCase, expected, inters, 'AbsTol', .01);
