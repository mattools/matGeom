function test_suite = test_distancePointPlane
%testDistancePointPlane  One-line description here, please.
%   output = testDistancePointPlane(input)
%
%   Example
%   testDistancePointPlane
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-19,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testAboveOx(testCase) %#ok<*DEFNU>
% plane orthogonal to Ox axis
point   = [10 10 10];
plane   = createPlane([0 0 0], [1 0 0]);
distTh  = 10;
dist    = distancePointPlane(point, plane);
testCase.assertEqual(distTh, dist, 'AbsTol', .01);

function testAboveOy(testCase)
% plane orthogonal to Ox axis
point   = [10 10 10];
plane   = createPlane([0 0 0], [0 1 0]);
distTh  = 10;
dist    = distancePointPlane(point, plane);
testCase.assertEqual(distTh, dist, 'AbsTol', .01);

function testAboveOz(testCase)
% plane orthogonal to Ox axis
point   = [10 10 10];
plane   = createPlane([0 0 0], [0 0 1]);
distTh  = 10;
dist    = distancePointPlane(point, plane);
testCase.assertEqual(distTh, dist, 'AbsTol', .01);


function testBelowOx(testCase)
% plane orthogonal to Ox axis
point   = [0 0 0];
plane   = createPlane([10 10 10], [1 0 0]);
distTh  = -10;
dist    = distancePointPlane(point, plane);
testCase.assertEqual(distTh, dist, 'AbsTol', .01);

function testBelowOy(testCase)
% plane orthogonal to Ox axis
point   = [0 0 0];
plane   = createPlane([10 10 10], [0 1 0]);
distTh  = -10;
dist    = distancePointPlane(point, plane);
testCase.assertEqual(distTh, dist, 'AbsTol', .01);

function testBelowOz(testCase)
% plane orthogonal to Ox axis
point   = [0 0 0];
plane   = createPlane([10 10 10], [0 0 1]);
distTh  = -10;
dist    = distancePointPlane(point, plane);
testCase.assertEqual(distTh, dist, 'AbsTol', .01);

function testPointArray(testCase)

points  = [10 0 0;10 20 30;10 10 10;10 0 20];
plane   = createPlane([0 0 0], [1 0 0]);
distTh  =  [10;10;10;10];
dist    = distancePointPlane(points, plane);
testCase.assertEqual(distTh, dist, 'AbsTol', .01);

function testPlaneArray(testCase)

point   = [0 0 0];
planes  = createPlane([10 0 0;10 20 30;10 10 10;10 0 20], [1 0 0]);
distTh  =  [-10;-10;-10;-10];
dist    = distancePointPlane(point, planes);
testCase.assertEqual(distTh, dist, 'AbsTol', .01);

function testBothArray(testCase)

points  = [0 0 0;0 20 30;0 10 10;0 0 20];
planes  = createPlane([10 0 0;10 20 30;10 10 10;10 0 20], [1 0 0]);
distTh  =  [-10;-10;-10;-10];
dist    = distancePointPlane(points, planes);
testCase.assertEqual(distTh, dist, 'AbsTol', .01);

