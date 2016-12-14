function test_suite = test_distancePolygons
%test_distancePolygons  One-line description here, please.
%   output = test_distancePolygons(input)
%
%   Example
%   test_distancePolygons
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-17,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.
% Licensed under the terms of the LGPL, see the file "license.txt"

test_suite = functiontests(localfunctions); 

function testNoCross(testCase) %#ok<*DEFNU>

poly1 = [10 10;20 10;20 20;10 20];
poly2 = [30 20;50 20;40 45];
exp = 10;

dist = distancePolygons(poly1, poly2);

testCase.assertEqual(exp, dist, 'AbsTol', .01);


function testCrossing(testCase)

poly1 = [30 20; 70 20; 70 80; 30 80];
poly2 = [10 40; 90 40; 90 60; 10 60];
% expected distance is 0 for crossing polygons
exp = 0;

dist = distancePolygons(poly1, poly2);

testCase.assertEqual(exp, dist, 'AbsTol', .01);
