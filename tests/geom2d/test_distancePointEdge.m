function test_suite = test_distancePointEdge
%TESTDISTANCEPOINTEDGE  One-line description here, please.
%   output = test_distancePointEdge(input)
%
%   Example
%   testDistancePointEdge
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

function testBasic(testCase) %#ok<*DEFNU>
point = [0 0];
edge = [1 2 3 4];
testCase.assertEqual(distancePointEdge(point, edge), sqrt(5), 'AbsTol', .01);

function testHorizontal(testCase)
% an horizontal edge, with points all around
edge = [2 2 4 2];
testCase.assertEqual(distancePointEdge([1 1], edge), sqrt(2), 'AbsTol', .01);
testCase.assertEqual(distancePointEdge([2 1], edge), 1, 'AbsTol', .01);
testCase.assertEqual(distancePointEdge([3 1], edge), 1, 'AbsTol', .01);
testCase.assertEqual(distancePointEdge([4 1], edge), 1, 'AbsTol', .01);
testCase.assertEqual(distancePointEdge([5 1], edge), sqrt(2), 'AbsTol', .01);
testCase.assertEqual(distancePointEdge([5 2], edge), 1, 'AbsTol', .01);


function testDiagonal(testCase)
% diagonal (slope 1.5)
edge = [1 1 5 7];
testCase.assertEqual(distancePointEdge([0 0], edge), sqrt(2), 'AbsTol', .01);
testCase.assertEqual(distancePointEdge([2 0], edge), sqrt(2), 'AbsTol', .01);
testCase.assertEqual(distancePointEdge([4 8], edge), sqrt(2), 'AbsTol', .01);
testCase.assertEqual(distancePointEdge([1 0], edge), 1, 'AbsTol', .01);
testCase.assertEqual(distancePointEdge([0 1], edge), 1, 'AbsTol', .01);
testCase.assertEqual(distancePointEdge([6 7], edge), 1, 'AbsTol', .01);
testCase.assertEqual(distancePointEdge([5 8], edge), 1, 'AbsTol', .01);
testCase.assertEqual(distancePointEdge([6 2], edge), sqrt(13), 'AbsTol', .01);
testCase.assertEqual(distancePointEdge([0 6], edge), sqrt(13), 'AbsTol', .01);

function testSingleMulti(testCase)
point = [5 5];
edges = [0 0 10 0;10 0 10 10;10 10 20 10;10 0 0 10];
exp = [5 5 5*sqrt(2) 0];
testCase.assertEqual(exp, distancePointEdge(point, edges), 'AbsTol', .01);

function testSingleMultiWithInvalid(testCase)
point = [5 5];
edges = [0 0 10 0;10 0 10 10;10 10 20 10;5 0 5 0];
exp = [5 5 5*sqrt(2) 5];
testCase.assertEqual(exp, distancePointEdge(point, edges), 'AbsTol', .01);


function testMultiSingle(testCase)
edge  = [10 10 20 10];
points = [10 10;15 10;20 10;10 0;30 10];
exp = [0;0;0;10;10];
testCase.assertEqual(exp, distancePointEdge(points, edge), 'AbsTol', .01);

function testMultiSingleInvalidEdge(testCase)
edge  = [15 10 15 10];
points = [10 10;15 10;20 10;10 10;30 10];
exp = [5;0;5;5;15];
testCase.assertEqual(exp, distancePointEdge(points, edge), 'AbsTol', .01);

function testMultiMulti(testCase)
edges  = [10 30 20 30; 20 30 20 40;20 40 10 40;10 40 10 30];
points = [14 33;15 38];
exp = [3 6 7 4;8 5 2 5];
testCase.assertEqual(exp, distancePointEdge(points, edges), 'AbsTol', .01);

function testMultiMultiWithInvalid(testCase)
edges  = [10 30 20 30; 20 30 20 40;20 40 10 40;10 40 10 30;10 30 10 30];
points = [14 33;15 38];
exp = [3 6 7 4 5;8 5 2 5 hypot(8, 5)];
testCase.assertEqual(exp, distancePointEdge(points, edges), 'AbsTol', .01);
