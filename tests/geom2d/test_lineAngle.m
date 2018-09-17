function test_suite = test_lineAngle
%TESTLINEANGLE  One-line description here, please.
%   output = testLineAngle(input)
%
%   Example
%   testLineAngle
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

function testLineAngle1(testCase) %#ok<*DEFNU>
% test lineAngle with one parameter

% horizontal
line1 = createLine([2 3 1 0]);
testCase.assertEqual(lineAngle(line1), 0, 'AbsTol', .01);

line1 = createLine([2 3 0 1]);
testCase.assertEqual(lineAngle(line1), pi/2, 'AbsTol', .01);

line1 = createLine([2 3 1 1]);
testCase.assertEqual(lineAngle(line1), pi/4, 'AbsTol', .01);

line1 = createLine([2 3 5 -1]);
testCase.assertEqual(lineAngle(line1), mod(atan2(-1, 5)+2*pi, 2*pi), 'AbsTol', .01);

line1 = createLine([2 3 5000 -1000]);
testCase.assertEqual(lineAngle(line1), mod(atan2(-1, 5)+2*pi, 2*pi), 'AbsTol', .01);

line1 = createLine([2 3 -1 0]);
testCase.assertEqual(lineAngle(line1), pi, 'AbsTol', .01);



function testLineAngle2(testCase)
% test lineAngle with two parameters : angle between 2 lines

% check for 2 orthogonal lines
line1 = createLine([1 3 1 0]);
line2 = createLine([-2 -1 0 1]);
testCase.assertEqual(lineAngle(line1, line2), pi/2, 'AbsTol', .01);
testCase.assertEqual(lineAngle(line2, line1), 3*pi/2, 'AbsTol', .01);


% check for 2 orthogonal lines, with very different parametrizations
line1 = createLine([1 3 1 1]);
line2 = createLine([-2 -1 -1000 1000]);
testCase.assertEqual(lineAngle(line1, line2), pi/2, 'AbsTol', .01);
testCase.assertEqual(lineAngle(line2, line1), 3*pi/2, 'AbsTol', .01);


