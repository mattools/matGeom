function test_suite = test_intersectEdges 
%TESTINTERSECTEDGES  One-line description here, please.
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
testCase.assertEqual(intersectEdges(edge1, edge2), [3 2], 'AbsTol', .01);
testCase.assertEqual(intersectEdges(edge2, edge1), [3 2], 'AbsTol', .01);

function testParallel(testCase)
% basic test with two parallel edges
edge1 = [1 2 4 4];
edge2 = [2 1 8 5];
testCase.assertTrue(sum(isnan(intersectEdges(edge1, edge2)))==2);
testCase.assertTrue(sum(isnan(intersectEdges(edge2, edge1)))==2);

function testColinearIntersect(testCase)
% basic test with two colinear edges
edge1 = [1 2 7 6];
edge2 = [4 4 13 10];
testCase.assertTrue(sum(isinf(intersectEdges(edge1, edge2)))==2);
testCase.assertTrue(sum(isinf(intersectEdges(edge2, edge1)))==2);

function testColinearDisjoint(testCase)
% basic test with two parallel edges
edge1 = [1 2 4 4];
edge2 = [7 6 13 10];
testCase.assertTrue(sum(isnan(intersectEdges(edge1, edge2)))==2);
testCase.assertTrue(sum(isnan(intersectEdges(edge1, edge2)))==2);

function testColinearTouches(testCase)
% basic test with two parallel edges
eps = 1e-14;
edge1 = [1 2 7 6];
edge2 = [7 6 10 8];
testCase.assertEqual(intersectEdges(edge1, edge2), [7 6], 'AbsTol', eps);
testCase.assertEqual(intersectEdges(edge2, edge1), [7 6], 'AbsTol', eps);

edge1 = [1 2 7 6];
edge2 = [10 8 7 6];
testCase.assertEqual(intersectEdges(edge1, edge2), [7 6], 'AbsTol', eps);
testCase.assertEqual(intersectEdges(edge2, edge1), [7 6], 'AbsTol', eps);

function testLargeDerivative(testCase)
% check for dx and dy very big
edge1 = [1 2 50000 2];
edge2 = [3 1 3 4];
testCase.assertEqual(intersectEdges(edge1, edge2), [3 2]);

function testDiagonal(testCase)
% check diagonal edges
edge1 = [5 1 1 5];
edge2 = [2 2 2 6];
testCase.assertEqual(intersectEdges(edge1, edge2), [2 4], 'AbsTol', .01);

edge3 = [3 1 6 4];
testCase.assertEqual(intersectEdges(edge1, edge3), [4 2], 'AbsTol', .01);

function testWithNaN(testCase)
% check comparison with NaN
edge2 = [2 2 2 6];
edge3 = [3 1 6 4];
testCase.assertEqual(intersectEdges(edge2, edge3), [NaN NaN]);

function testOneCorner(testCase)
% check intersection with one corner
edge1 = [5 1 1 5];
edge2 = [0 5 3 5];
testCase.assertEqual(intersectEdges(edge1, edge2), [1 5], 'AbsTol', .01);

function testTwoCorners(testCase)
% both with one corner
edge1 = [5 1 1 5];
edge2 = [1 5 3 5];
testCase.assertEqual(intersectEdges(edge1, edge2), [1 5], 'AbsTol', .01);


function testSeveralEdges(testCase)
% Check intersection of two edge groups

edges1 = [20 10 20 40];
edges2 = [10 20 30 20; 10 30 30 30; 10 50 30 50];
inters = intersectEdges(edges1, edges2);
testCase.assertEqual([3 2], size(inters));

expected = [20 20;20 30;NaN NaN];
testCase.assertEqual(expected, inters, 'AbsTol', .01);

function testSeveralEdgesWithParallelAndColinear(testCase)
% Check intersection of two edge groups

edges1 = [10 20 40 20];
edges2 = [10 20 30 20; 30 10 30 30; 10 50 30 50];

inters = intersectEdges(edges1, edges2);
testCase.assertEqual([3 2], size(inters));

expected = [Inf Inf;30 20;NaN NaN];
testCase.assertEqual(expected, inters, 'AbsTol', .01);
