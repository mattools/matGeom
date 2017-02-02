function test_suite = test_angle2Points
%TESTCLIPLINE  One-line description here, please.
%   output = testAngle2Points(input)
%
%   Example
%   testAngle2Points
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

function testHoriz(testCase) %#ok<*DEFNU>
% all points inside window, possibly touching edges

p1 = [0 0];
p2 = [10 0];
angle = angle2Points(p1, p2);
testCase.assertEqual(0, angle, 'AbsTol', .01);

angle = angle2Points(p2, p1);
testCase.assertEqual(pi, angle, 'AbsTol', .01);

function testVert(testCase)
% all points inside window, possibly touching edges

p1 = [0 0];
p2 = [0 10];
angle = angle2Points(p1, p2);
testCase.assertEqual(pi/2, angle, 'AbsTol', .01);

angle = angle2Points(p2, p1);
testCase.assertEqual(3*pi/2, angle, 'AbsTol', .01);


function testMultiMulti(testCase)
% all points inside window, possibly touching edges

p1 = [0 0;0 0;0 0;0 0];
p2 = [10 0;10 10;0 10;-10 10];
angle = angle2Points(p1, p2);
testCase.assertEqual(size(p1, 1), size(angle, 1), 'AbsTol', .01);

res = [0;pi/4;pi/2;3*pi/4];
testCase.assertEqual(res, angle, 'AbsTol', .01);

function testOneMulti(testCase)
% all points inside window, possibly touching edges

p1 = [0 0];
p2 = [10 0;10 10;0 10;-10 10];
angle = angle2Points(p1, p2);
testCase.assertEqual(size(p2, 1), size(angle, 1), 'AbsTol', .01);

res = [0;pi/4;pi/2;3*pi/4];
testCase.assertEqual(res, angle, 'AbsTol', .01);

