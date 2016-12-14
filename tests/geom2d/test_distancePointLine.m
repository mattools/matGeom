function test_suite = test_distancePointLine
%TESTDISTANCEPOINTEDGE  One-line description here, please.
%   output = test_distancePointLine(input)
%
%   Example
%   testDistancePointLine
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-10-24,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function testBasic(testCase) %#ok<*DEFNU>
point = [0 0];
line = [1 2 1 0];
testCase.assertEqual(2, distancePointLine(point, line), 'AbsTol', .01);

function testHorizontal(testCase)
% an horizontal line, with points all around
line = [2 2 2 0];
testCase.assertEqual(distancePointLine([1 1], line), 1, 'AbsTol', .01);
testCase.assertEqual(distancePointLine([2 1], line), 1, 'AbsTol', .01);
testCase.assertEqual(distancePointLine([3 1], line), 1, 'AbsTol', .01);
testCase.assertEqual(distancePointLine([4 1], line), 1, 'AbsTol', .01);
testCase.assertEqual(distancePointLine([5 1], line), 1, 'AbsTol', .01);
testCase.assertEqual(distancePointLine([5 2], line), 0, 'AbsTol', .01);
testCase.assertEqual(distancePointLine([5 3], line), 1, 'AbsTol', .01);


function testDiagonal(testCase)
% diagonal (slope 2)
line = [1 1 3 6];
testCase.assertEqual(0, distancePointLine([3 5], line));
testCase.assertEqual(sqrt(5), distancePointLine([3 0], line), 'AbsTol', .01);

function testSingleMulti(testCase)
point = [5 5];
lines = [0 0 3 0;10 0 0 3;10 10 -3 0;10 0 3 3];
exp = [5 5 5 5*sqrt(2)];
testCase.assertEqual(exp, distancePointLine(point, lines), 'AbsTol', .01);

function testSingleMultiWithInvalid(testCase)
point = [5 5];
lines = [0 0 3 0;10 0 0 3;10 10 -3 0;10 0 3 3;10 0 0 0];
exp = [5 5 5 5*sqrt(2) 5*sqrt(2)];
testCase.assertEqual(exp, distancePointLine(point, lines), 'AbsTol', .01);


function testMultiSingle(testCase)
line  = [10 10 5 0];
points = [10 10;15 10;20 10;10 0;30 10];
exp = [0; 0; 0; 10; 0];
testCase.assertEqual(exp, distancePointLine(points, line), 'AbsTol', .01);

function testMultiSingleInvalidLine(testCase)
line  = [15 10 0 0];
points = [10 10; 15 10; 20 10; 10 10; 30 10];
exp = [5; 0; 5; 5; 15];
testCase.assertEqual(exp, distancePointLine(points, line), 'AbsTol', .01);

function testMultiMulti(testCase)
lines  = [10 30 10 0; 20 30 0 10;20 40 -10 0;10 40 0 -10];
points = [14 33;15 38];
exp = [3 6 7 4;8 5 2 5];
testCase.assertEqual(exp, distancePointLine(points, lines), 'AbsTol', .01);

function testMultiMultiWithInvalid(testCase)
lines  = [10 30 10 0; 20 30 0 10;20 40 -10 0;10 40 0 -10;10 30 0 0];
points = [14 33;15 38];
exp = [3 6 7 4 5;8 5 2 5 hypot(8, 5)];
testCase.assertEqual(exp, distancePointLine(points, lines), 'AbsTol', .01);
