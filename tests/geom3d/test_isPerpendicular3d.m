function test_suite = test_isPerpendicular3d
%Check orthogonality 2 vectors
%   output = testIsPerpendicular3d(input)
%
%   Example
%   testIsPerpendicular3d
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
v1  = [10 0 0];
v2  = [0 20 0];
v3  = [0 0 30];

testCase.assertTrue(isPerpendicular3d(v1, v2));
testCase.assertTrue(isPerpendicular3d(v1, v3));
testCase.assertTrue(isPerpendicular3d(v2, v3));

function testNegative(testCase)
v1  = [10 0 0];
v2  = [-1 -5 0];

testCase.assertFalse(isPerpendicular3d(v1, v2));

function testSingleArray(testCase)
v1  = [10 0 0];
v2  = [0 20 0];
v3  = [0 0 30];
res = isPerpendicular3d(v1, [v1; v2; v3]);
testCase.assertEqual([false;true;true], res);

function testArraySingle(testCase)
v1  = [10 0 0];
v2  = [0 20 0];
v3  = [0 0 30];
res = isPerpendicular3d([v1; v2; v3], v1);
testCase.assertEqual([false;true;true], res);

