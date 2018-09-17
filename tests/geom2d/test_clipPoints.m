function test_suite = test_clipPoints
%TESTCLIPLINE  One-line description here, please.
%   output = testClipPoints(input)
%
%   Example
%   testClipPoints
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

function testAllInside(testCase) %#ok<*DEFNU>
% all points inside window, possibly touching edges

box = [0 10 0 20];
corners = [0 0;10 0;0 20;10 20];

cornersClipped = clipPoints(corners, box);
testCase.assertEqual(4, size(cornersClipped, 1));
testCase.assertEqual(corners, cornersClipped, 'AbsTol', .01);

borders = [0 5;10 5;5 0;5 20];
bordersClipped = clipPoints(borders, box);
testCase.assertEqual(4, size(bordersClipped, 1));
testCase.assertEqual(borders, bordersClipped, 'AbsTol', .01);

inside = [5 5;5 10;5 15];
insideClipped = clipPoints(inside, box);
testCase.assertEqual(size(inside, 1), size(insideClipped, 1));
testCase.assertEqual(inside, insideClipped, 'AbsTol', .01);


function testAllOutside(testCase)
% all points outside window

box = [0 10 0 20];
points = [-1 0;11 0;-1 20;11 20;0 -1;0 21;10 -1;10 21];

pointsClipped = clipPoints(points, box);
testCase.assertEqual(0, size(pointsClipped, 1));


function testMixed(testCase)
% all points inside window, possibly touching edges

box = [0 10 0 20];
points = [-5 10;0 10;5 10;10 10; 15 10];

pointsClipped = clipPoints(points, box);
testCase.assertEqual(3, size(pointsClipped, 1));
testCase.assertEqual(points(2:4,:), pointsClipped, 'AbsTol', .01);
