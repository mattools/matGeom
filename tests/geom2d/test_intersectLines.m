function test_suite = test_intersectLines 
%TESTINTERSECTLINES  One-line description here, please.
%   output = testIntersectLines(input)
%
%   Example
%   testIntersectLines
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
% basic test with two orthogonal lines
line1 = [3 1 0 1];
line2 = [1 4 1 0];
testCase.assertEqual(intersectLines(line1, line2), [3 4], 'AbsTol', .01);

function testOrthogonalDiagonals(testCase)
% orthognal diagonal lines
line1 = [0 0 3 2];
line2 = [5 -1 4 -6];
testCase.assertEqual(intersectLines(line1, line2), [3 2], 'AbsTol', .01);

function testDiagonalHorizontal(testCase)
% one diagonal and one horizontal line
line1 = [10 2 25 0];
line2 = [5 -1 4 -6];
testCase.assertEqual(intersectLines(line1, line2), [3 2], 'AbsTol', .01);

function testBigDerivative(testCase)
% check for dx and dy very big compared to other line
line1 = [3 1 0 1000];
line2 = [1 4 -14 0];
testCase.assertEqual(intersectLines(line1, line2), [3 4], 'AbsTol', .01);

line1 = [2 0 20000 30000];
line2 = [1 6 1 -1];
testCase.assertEqual(intersectLines(line1, line2), [4 3], 'AbsTol', .01);

function testSingleArray(testCase)

line1 = [3 1 0 1];
line2 = repmat([1 4 1 0], 5, 1);
exp = repmat([3 4], 5, 1);

inters = intersectLines(line1, line2);
testCase.assertEqual(exp, inters, 'AbsTol', .01);


function testArraySingle(testCase)

line1 = repmat([3 1 0 1], 5, 1);
line2 = [1 4 1 0];
exp = repmat([3 4], 5, 1);

inters = intersectLines(line1, line2);
testCase.assertEqual(exp, inters, 'AbsTol', .01);


function testArrayArray(testCase)

line1 = repmat([3 1 0 1], 5, 1);
line2 = repmat([1 4 1 0], 5, 1);
exp = repmat([3 4], 5, 1);

inters = intersectLines(line1, line2);
testCase.assertEqual(exp, inters, 'AbsTol', .01);
