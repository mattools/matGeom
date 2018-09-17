function test_suite = test_polygonSelfIntersections
%TESTPOLYGONSELFINTERSECTIONS  One-line description here, please.
%   output = testPolygonSelfIntersections(input)
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

function testSquare(testCase) %#ok<*DEFNU>

poly = [0 0;10 0;10 10;0 10];
intersects = polygonSelfIntersections(poly);
testCase.assertTrue(isempty(intersects));


function testSingleIntersect(testCase)

% use a 8-shaped polygon.
poly = [10 0;0 0;0 10;20 10;20 20;10 20];
intersects = polygonSelfIntersections(poly);

testCase.assertEqual(1, size(intersects, 1));
testCase.assertEqual([10 10], intersects, 'AbsTol', .01);

function test_S_Shape(testCase)
% Test on a S-shaped polygon, crossing is between last and first vertices

poly = [10 0;0 0;0 10;20 10;20 20;10 20];

res = polygonSelfIntersections(poly);
exp = [10 10];
testCase.assertEqual(exp, res, 'AbsTol', .01);


function testEllipseArc(testCase)

t = linspace(-pi/2, pi/2, 60)';
arc = [10+3*cos(t) 20+5*sin(t)];

intersects = polygonSelfIntersections(arc);

testCase.assertTrue(isempty(intersects));


function testCrossingAtFirstPoint(testCase)

poly = [20 20; 30 20;20 30;20 10; 10 20];
intersects = polygonSelfIntersections(poly);

testCase.assertEqual(1, size(intersects, 1));

exp = [20 20];
testCase.assertEqual(exp, intersects, 'AbsTol', .01);

function testCrossingAtVertex(testCase)

poly = [10 10;20.3 10; 20 20;20.1 30;30 30;30 20;20 20;10 20];

intersects = polygonSelfIntersections(poly);

exp = [20 20];
testCase.assertEqual(exp, intersects, 'AbsTol', .01);
