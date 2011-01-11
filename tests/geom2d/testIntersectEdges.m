function test_suite = testIntersectEdges(varargin)
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
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.
% Licensed under the terms of the LGPL, see the file "license.txt"

initTestSuite;


function testOrthogonal
% basic test with two orthogonal edges
edge1 = [1 2 5 2];
edge2 = [3 1 3 4];
assertElementsAlmostEqual(intersectEdges(edge1, edge2), [3 2]);
assertElementsAlmostEqual(intersectEdges(edge2, edge1), [3 2]);

function testParallel
% basic test with two parallel edges
edge1 = [1 2 4 4];
edge2 = [2 1 8 5];
assertTrue(sum(isnan(intersectEdges(edge1, edge2)))==2);
assertTrue(sum(isnan(intersectEdges(edge2, edge1)))==2);

function testColinearIntersect
% basic test with two colinear edges
edge1 = [1 2 7 6];
edge2 = [4 4 13 10];
assertTrue(sum(isinf(intersectEdges(edge1, edge2)))==2);
assertTrue(sum(isinf(intersectEdges(edge2, edge1)))==2);

function testColinearDisjoint
% basic test with two parallel edges
edge1 = [1 2 4 4];
edge2 = [7 6 13 10];
assertTrue(sum(isnan(intersectEdges(edge1, edge2)))==2);
assertTrue(sum(isnan(intersectEdges(edge1, edge2)))==2);

function testColinearTouches
% basic test with two parallel edges
eps = 1e-14;
edge1 = [1 2 7 6];
edge2 = [7 6 10 8];
assertElementsAlmostEqual(intersectEdges(edge1, edge2), [7 6], 'absolute', eps);
assertElementsAlmostEqual(intersectEdges(edge2, edge1), [7 6], 'absolute', eps);

edge1 = [1 2 7 6];
edge2 = [10 8 7 6];
assertElementsAlmostEqual(intersectEdges(edge1, edge2), [7 6], 'absolute', eps);
assertElementsAlmostEqual(intersectEdges(edge2, edge1), [7 6], 'absolute', eps);

function testLargeDerivative
% check for dx and dy very big
edge1 = [1 2 50000 2];
edge2 = [3 1 3 4];
assertElementsAlmostEqual(intersectEdges(edge1, edge2), [3 2]);

function testDiagonal
% check diagonal edges
edge1 = [5 1 1 5];
edge2 = [2 2 2 6];
assertElementsAlmostEqual(intersectEdges(edge1, edge2), [2 4]);

edge3 = [3 1 6 4];
assertElementsAlmostEqual(intersectEdges(edge1, edge3), [4 2]);

function testWithNaN
% check comparison with NaN
edge2 = [2 2 2 6];
edge3 = [3 1 6 4];
assertElementsAlmostEqual(intersectEdges(edge2, edge3), [NaN NaN]);

function testOneCorner
% check intersection with one corner
edge1 = [5 1 1 5];
edge2 = [0 5 3 5];
assertElementsAlmostEqual(intersectEdges(edge1, edge2), [1 5]);

function testTwoCorners
% both with one corner
edge1 = [5 1 1 5];
edge2 = [1 5 3 5];
assertElementsAlmostEqual(intersectEdges(edge1, edge2), [1 5]);


function testSeveralEdges
% Check intersection of two edge groups

edges1 = [20 10 20 40];
edges2 = [10 20 30 20; 10 30 30 30; 10 50 30 50];
inters = intersectEdges(edges1, edges2);
assertEqual([3 2], size(inters));

expected = [20 20;20 30;NaN NaN];
assertElementsAlmostEqual(expected, inters);
