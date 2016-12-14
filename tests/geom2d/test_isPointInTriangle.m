function test_suite = test_isPointInTriangle
%TESTISPOINTINTRIANGLE  One-line description here, please.
%
%   output = testIsPointInTriangle(input)
%
%   Example
%   testIsPointInTriangle
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-17,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testSimple(testCase) %#ok<*DEFNU>

p1 = [0 0];
p2 = [10 0];
p3 = [5 10];
tri = [p1;p2;p3];

res1 = isPointInTriangle([0 0], tri);
testCase.assertTrue(res1);

res2 = isPointInTriangle([5 5], tri);
testCase.assertTrue(res2);

res3 = isPointInTriangle([10 5], tri);
testCase.assertFalse(res3);

function testArray(testCase)

p1 = [0 0];
p2 = [10 0];
p3 = [5 10];
tri = [p1;p2;p3];

res = isPointInTriangle([0 0;1 0;0 1], tri);
exp = [true;true;false];
testCase.assertEqual(exp, res);
