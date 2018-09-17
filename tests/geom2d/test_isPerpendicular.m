function test_suite = test_isPerpendicular
%testIsPerpendicular  One-line description here, please.
%   output = testIsPerpendicular(input)
%
%   Example
%   testIsPerpendicular
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

test_suite = functiontests(localfunctions); 


function testPerpendicular(testCase) %#ok<*DEFNU>

v1 = [1 2];
v2 = [-4 2];
b  = isPerpendicular(v1, v2);
testCase.assertTrue(b);


function testNotPerpendicular(testCase)

v1 = [1 2];
v2 = [-4 1];
b  = isPerpendicular(v1, v2);
testCase.assertFalse(b);

function testArrayAndSingle(testCase)

v1  = [1 0; 1 1; 1 2];
v2  = [-4 2];
th  = [false; false; true];

res = isPerpendicular(v1, v2);
testCase.assertEqual(res, th);

res = isPerpendicular(v2, v1);
testCase.assertEqual(res, th);


function testArrayArray(testCase)

v1  = [1 0; 1 1; 1 2];
v2  = [0 1; 1 2; 1 1];

th  = [true; false; false];

res = isPerpendicular(v1, v2);
testCase.assertEqual(res, th);

res = isPerpendicular(v1, v2);
testCase.assertEqual(res, th);
