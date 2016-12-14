function test_suite = test_angle3Points
% One-line description here, please.
%   output = testAngle3Points(input)
%
%   Example
%   testAngle3Points
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

function testSimple(testCase) %#ok<*DEFNU>
% all points inside window, possibly touching edges

p1 = [10 0];
p2 = [0 0];
p3 = [0 10];
angle = angle3Points(p1, p2, p3);
testCase.assertEqual(pi/2, angle, 'AbsTol', .01);


function testBundledInput(testCase)
% all points inside window, possibly touching edges

p1 = [10 0];
p2 = [0 0];
p3 = [0 10];
angle = angle3Points([p1; p2; p3]);
testCase.assertEqual(pi/2, angle, 'AbsTol', .01);

function testArray(testCase)
% all points inside window, possibly touching edges

p1 = [10 0; 20 0];
p2 = [0 0;0 0];
p3 = [0 10; 0 20];
angle = angle3Points(p1, p2, p3);

testCase.assertEqual(2, size(angle, 1));
testCase.assertEqual([pi/2;pi/2], angle, 'AbsTol', .01);

