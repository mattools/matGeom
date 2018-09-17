function test_suite = test_angleSort
%TESTCLIPLINE  One-line description here, please.
%   output = testAngleSort(input)
%
%   Example
%   testAngleSort
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

p1 = [0 0];
p2 = [10 0];
p3 = [10 10];
p4 = [0 10];
pts = [p1;p2;p3;p4];
center = [5 5];
expected = pts([3 4 1 2], :);
testCase.assertEqual(expected, angleSort(pts, center), 'AbsTol', .01);

function testSimpleWithAngle(testCase)

p1 = [0 0];
p2 = [10 0];
p3 = [10 10];
p4 = [0 10];
pts = [p1;p2;p3;p4];
center = [5 5];
testCase.assertEqual(pts, angleSort(pts, center, -pi), 'AbsTol', .01);

