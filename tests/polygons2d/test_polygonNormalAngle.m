function test_suite = test_polygonNormalAngle
%TESTPOLYGONNORMALANGLE  One-line description here, please.
%   output = testPolygonNormalAngle(input)
%
%   Example
%   testPolygonNormalAngle
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

function testPolygon1(testCase) %#ok<*DEFNU>
% test with a convex polygon 

poly = [1 1;2 1;3 2;2 2;1 2];

eps = 1e-14;

testCase.assertEqual(polygonNormalAngle(poly, 1), pi/2, 'AbsTol', eps);
testCase.assertEqual(polygonNormalAngle(poly, 2), pi/4, 'AbsTol', eps);
testCase.assertEqual(polygonNormalAngle(poly, 3), 3*pi/4, 'AbsTol', eps);
testCase.assertEqual(polygonNormalAngle(poly, 4), 0, 'AbsTol', eps);
testCase.assertEqual(polygonNormalAngle(poly, 5), pi/2, 'AbsTol', eps);


function testPolygon2(testCase)
% test with a non-convex polygon

poly = [0 0;0 1;-1 1;0 -1;1 0];
eps = 1e-14;

testCase.assertEqual(polygonNormalAngle(poly, 1), -pi/2, 'AbsTol', eps);
testCase.assertEqual(polygonNormalAngle(poly, 2), pi/2, 'AbsTol', eps);
testCase.assertEqual(polygonNormalAngle(poly, 3), pi/2+atan(.5), 'AbsTol', eps);
testCase.assertEqual(polygonNormalAngle(poly, 4), pi/4+atan(2), 'AbsTol', eps);
testCase.assertEqual(polygonNormalAngle(poly, 5), 3*pi/4, 'AbsTol', eps);


function testPolygon3(testCase)
% test with polygon oriented Clockwise instead of Counter-Clockwise

% use a single square
poly = [0 0;0 1;1 1;1 0];
eps = 1e-14;

testCase.assertEqual(polygonNormalAngle(poly, 1), -pi/2, 'AbsTol', eps);
testCase.assertEqual(polygonNormalAngle(poly, 2), -pi/2, 'AbsTol', eps);
testCase.assertEqual(polygonNormalAngle(poly, 3), -pi/2, 'AbsTol', eps);
testCase.assertEqual(polygonNormalAngle(poly, 4), -pi/2, 'AbsTol', eps);
testCase.assertEqual(sum(polygonNormalAngle(poly, 1:4)), -2*pi, 'AbsTol', eps);
