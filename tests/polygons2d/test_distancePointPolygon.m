function test_suite = test_distancePointPolygon
%TESTDISTANCEPOINTEDGE  One-line description here, please.
%   output = testDistancePointPolygon(input)
%
%   Example
%   testDistancePointPolygon
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

function testPointOnPolygon(testCase) %#ok<*DEFNU>

poly = [0 0;10 0;10 10;0 10];

p1 = [0 0];
d = distancePointPolygon(p1, poly);
testCase.assertEqual(0, d, 'AbsTol', .01);

p1 = [10 0];
d = distancePointPolygon(p1, poly);
testCase.assertEqual(0, d, 'AbsTol', .01);

p1 = [5 10];
d = distancePointPolygon(p1, poly);
testCase.assertEqual(0, d, 'AbsTol', .01);

p1 = [10 5];
d = distancePointPolygon(p1, poly);
testCase.assertEqual(0, d, 'AbsTol', .01);

p1 = [0 5];
d = distancePointPolygon(p1, poly);
testCase.assertEqual(0, d, 'AbsTol', .01);

function testPointNotOnPolygon(testCase)

poly = [0 0;10 0;10 10;0 10];

p1 = [0 -10];
d = distancePointPolygon(p1, poly);
testCase.assertEqual(10, d, 'AbsTol', .01);

p1 = [20 0];
d = distancePointPolygon(p1, poly);
testCase.assertEqual(10, d, 'AbsTol', .01);

p1 = [5 5];
d = distancePointPolygon(p1, poly);
testCase.assertEqual(5, d, 'AbsTol', .01);

p1 = [1 5];
d = distancePointPolygon(p1, poly);
testCase.assertEqual(1, d, 'AbsTol', .01);

p1 = [-1 5];
d = distancePointPolygon(p1, poly);
testCase.assertEqual(1, d, 'AbsTol', .01);
