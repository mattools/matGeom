function test_suite = test_isParallel
%TESTISPARALLEL  One-line description here, please.
%   output = testIsParallel(input)
%
%   Example
%   testIsParallel
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


function testParallel(testCase) %#ok<*DEFNU>

v1 = [1 2];
v2 = [2 4];
b  = isParallel(v1, v2);
testCase.assertTrue(b);

function testParallelLargeValues(testCase) 

v1 = [30000.5 50000.4];
v2 = v1 * 3.2;
b  = isParallel(v1, v2);
testCase.assertTrue(b);


function testNotParallel(testCase)

v1 = [1 2];
v2 = [2 5];
b  = isParallel(v1, v2);
testCase.assertFalse(b);


function testArraySingle(testCase)

v1  = [1 0;1 1;1 2];
v2  = [2 4];
th  = [false; false; true];
res = isParallel(v1, v2);
testCase.assertEqual(res, th);


function testSingleArray(testCase)

v1  = [2 4];
v2  = [1 0;1 1;1 2];
th  = [false; false; true];
res = isParallel(v1, v2);
testCase.assertEqual(res, th);
