function test_suite = test_distancePointPolyline
%TESTDISTANCEPOINTEDGE  Test suite for function distancePointPolyline 
%   output = test_distancePointPolyline(input)
%
%   Example
%   testDistancePointPolyline
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

function testPointOnPolyline(testCase) %#ok<*DEFNU>
% test if the distance betwwen polyline and a point on polyline is 0

% create polyline
poly = [0 0;10 0;10 10;0 10];

p1 = [0 0];
d = distancePointPolyline(p1, poly);
testCase.assertEqual(0, d, 'AbsTol', .01);

p1 = [10 0];
d = distancePointPolyline(p1, poly);
testCase.assertEqual(0, d, 'AbsTol', .01);

p1 = [5 10];
d = distancePointPolyline(p1, poly);
testCase.assertEqual(0, d, 'AbsTol', .01);

p1 = [10 5];
d = distancePointPolyline(p1, poly);
testCase.assertEqual(0, d, 'AbsTol', .01);

function testPointNotOnPolyline(testCase)

% test various points

% create polyline
poly = [0 0;10 0;10 10;0 10];

p1 = [0 -10];
d = distancePointPolyline(p1, poly);
testCase.assertEqual(10, d, 'AbsTol', .01);

p1 = [20 0];
d = distancePointPolyline(p1, poly);
testCase.assertEqual(10, d, 'AbsTol', .01);

p1 = [0 5];
d = distancePointPolyline(p1, poly);
testCase.assertEqual(5, d, 'AbsTol', .01);

p1 = [5 5];
d = distancePointPolyline(p1, poly);
testCase.assertEqual(5, d, 'AbsTol', .01);

function testManyPoints(testCase)

% test several points in one call...

% create polyline
poly = [0 0;10 0;10 10;0 10];

pts = [0 -10;20 0;0 5; 5 5];
dist = distancePointPolyline(pts, poly);
exp = [10 10 5 5]';

testCase.assertEqual(exp, dist, 'AbsTol', .01);

