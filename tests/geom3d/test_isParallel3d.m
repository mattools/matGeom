function test_suite = test_isParallel3d
%Check parallelism of 2 vectors
%   output = testIsParallel3d(input)
%
%   Example
%   testIsParallel3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-19,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testSingle(testCase) %#ok<*DEFNU>
v1  = [10 20 30];
v2  = [20 40 60];
res = isParallel3d(v1, v2);
testCase.assertEqual(true, res);

function testSingleArray(testCase)
v1  = [10 20 30];
v2  = [20 40 60;1 2 3;5 10 15;10 19 30];
res = isParallel3d(v1, v2);
testCase.assertEqual([true;true;true;false], res);

function testArraySingle(testCase)
v1  = [20 40 60;1 2 3;5 10 15;10 19 30];
v2  = [10 20 30];
res = isParallel3d(v1, v2);
testCase.assertEqual([true;true;true;false], res);

function testArrayArray(testCase)
v1  = [1 2 3;10 18 30;5 10 15;10 20 30];
v2  = [20 40 60;1 2 3;5 10 15;10 18 30];
res = isParallel3d(v1, v2);
testCase.assertEqual([true;false;true;false], res);

function testTolerance(testCase)
v1  = [10 20 30];
v2  = [10 20 30.000001];
testCase.assertEqual(false, isParallel3d(v1, v2));
testCase.assertEqual(true, isParallel3d(v1, v2, 1e-4));

