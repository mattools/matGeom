function test_suite = test_createScaling
%TESTCREATESCALING  One-line description here, please.
%   output = testCreateScaling(input)
%
%   Example
%   testCreateScaling
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

function testCentered(testCase) %#ok<*DEFNU>

% same coeff for both x and y
trans = createScaling(2);
testCase.assertEqual(trans, [2 0 0;0 2 0;0 0 1], 'AbsTol', .01);

% different factor
trans = createScaling(2, 3);
testCase.assertEqual(trans, [2 0 0;0 3 0;0 0 1], 'AbsTol', .01);

% different factor
trans = createScaling([2 3]);
testCase.assertEqual(trans, [2 0 0;0 3 0;0 0 1], 'AbsTol', .01);

function testShifted(testCase)

sx = 2;
sy = 3;
p0 = [4 5];

trans1 = createScaling(p0, sx, sy);
t1 = createTranslation(-p0);
sca = createScaling(sx, sy);
t2 = createTranslation(p0);
trans2 = t2*sca*t1;

testCase.assertEqual(trans1, trans2, 'AbsTol', .01);
