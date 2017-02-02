function test_suite = test_polygonPoint
%TESTPOLYGONPOINT  One-line description here, please.
%   output = testPolygonPoint(input)
%
%   Example
%   testPolygonPoint
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-16,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function testSquare(testCase) 
p1 = [10 10];
p2 = [20 10];
p3 = [20 20];
p4 = [10 20];
square = [p1;p2;p3;p4];
testCase.assertEqual(polygonPoint(square, 0), p1, 'AbsTol', .01);
testCase.assertEqual(polygonPoint(square, 1), p2, 'AbsTol', .01);
testCase.assertEqual(polygonPoint(square, 2), p3, 'AbsTol', .01);
testCase.assertEqual(polygonPoint(square, 3), p4, 'AbsTol', .01);
testCase.assertEqual(polygonPoint(square, 4), p1, 'AbsTol', .01);
testCase.assertEqual(polygonPoint(square, 3.5), centroid([p1;p4]), 'AbsTol', .01);
