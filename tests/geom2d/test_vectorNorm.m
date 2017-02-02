function test_suite = test_vectorNorm
% One-line description here, please.
%   output = testVectorNorm(input)
%
%   Example
%   testVectorNorm
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testEuclidean(testCase) %#ok<*DEFNU>

v = [3 4];
norm = vectorNorm(v);
testCase.assertEqual(5, norm, 'AbsTol', .01);

function testEuclideanArray(testCase)

v = [3 4;4 3;6 8;5 12];
norm = vectorNorm(v);
testCase.assertEqual([5;5;10;13], norm, 'AbsTol', .01);

function testExplicitEuclideanArray(testCase)

v = [3 4;4 3;6 8;5 12];
norm = vectorNorm(v, 2);
testCase.assertEqual([5;5;10;13], norm, 'AbsTol', .01);

function testNorm1Array(testCase)

v = [3 4;4 3;6 8;5 12];
norm = vectorNorm(v, 1);
testCase.assertEqual([7;7;14;17], norm, 'AbsTol', .01);

function testNormInfArray(testCase)

v = [3 4;4 3;6 8;5 12];
norm = vectorNorm(v, inf);
testCase.assertEqual([4;4;8;12], norm, 'AbsTol', .01);

