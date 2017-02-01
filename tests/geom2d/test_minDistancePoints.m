function test_suite = test_minDistancePoints
%TESTMINDISTANCEPOINTS  One-line description here, please.
%   output = testMinDistancePoints(input)
%
%   Example
%   testMinDistancePoints
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

function testArray(testCase) %#ok<*DEFNU>

pts = [50 10;40 60;30 30;20 0;10 60;10 30;0 10];
testCase.assertEqual(minDistancePoints(pts), 20, 'AbsTol', .01);

function testArrayIndInd(testCase)

pts = [10 10;25 5;20 20;30 20;10 30];
[dist, ind1, ind2] = minDistancePoints(pts);
testCase.assertEqual(10, dist, 'AbsTol', .01);
testCase.assertEqual(3, ind1, 'AbsTol', .01);
testCase.assertEqual(4, ind2, 'AbsTol', .01);


function testPointArray(testCase)

pts = [0 80;10 60;20 40;30 20;40 0;0 0;100 0;0 100;0 -10;-10 -20];
testCase.assertEqual(minDistancePoints([40 50], pts), 10*sqrt(5), 'AbsTol', .01);
testCase.assertEqual(minDistancePoints([25 30], pts), 5*sqrt(5), 'AbsTol', .01);
testCase.assertEqual(minDistancePoints([30 40], pts), 10, 'AbsTol', .01);
testCase.assertEqual(minDistancePoints([20 40], pts), 0, 'AbsTol', .01);

function testArrayArray(testCase)

pts1 = [40 50;25 30;40 20];
pts2 = [0 80;10 60;20 40;30 20;40 0;0 0;100 0;0 100;0 -10;-10 -20];
res = [10*sqrt(5);5*sqrt(5);10];
testCase.assertEqual(minDistancePoints(pts1, pts2), res, 'AbsTol', .01);


function testArrayNorm(testCase)

% an array of points with several pairs at distance (+-20,+/-10).
% resulting in distance equal to 30 with L1 metric.
pts = [50 10; 40 60; 40 30; 20 0; 10 60; 10 30; 0 10];

testCase.assertEqual(minDistancePoints(pts, 1), 30, 'AbsTol', .01);
testCase.assertEqual(minDistancePoints(pts, 100), 20, 'AbsTol', .01);


function testPointArrayNorm(testCase)

pts = [0 80;10 60;20 40;30 20;40 0;0 0;100 0;0 100;0 -10;-10 -20];
testCase.assertEqual(minDistancePoints([40 50], pts, 2), 10*sqrt(5), 'AbsTol', .01);
testCase.assertEqual(minDistancePoints([25 30], pts, 2), 5*sqrt(5), 'AbsTol', .01);
testCase.assertEqual(minDistancePoints([30 40], pts, 2), 10, 'AbsTol', .01);
testCase.assertEqual(minDistancePoints([20 40], pts, 2), 0, 'AbsTol', .01);
testCase.assertEqual(minDistancePoints([40 50], pts, 1), 30, 'AbsTol', .01);
testCase.assertEqual(minDistancePoints([25 30], pts, 1), 15, 'AbsTol', .01);
testCase.assertEqual(minDistancePoints([30 40], pts, 1), 10, 'AbsTol', .01);
testCase.assertEqual(minDistancePoints([20 40], pts, 1), 0, 'AbsTol', .01);

function testArrayArrayNorm(testCase)

pts1 = [40 50;25 30;40 20];
pts2 = [0 80;10 60;20 40;30 20;40 0;0 0;100 0;0 100;0 -10;-10 -20];
res1 = [10*sqrt(5);5*sqrt(5);10];
testCase.assertEqual(minDistancePoints(pts1, pts2, 2), res1, 'AbsTol', .01);

res2 = [30;15;10];
testCase.assertEqual(minDistancePoints(pts1, pts2, 1), res2, 'AbsTol', .01);

function testArrayArrayIndices(testCase)

pts1    = [40 50;20 30;40 20];
pts2    = [0 80;10 60;20 40;30 20;40 0;0 0;100 0;0 100;0 -10;-10 -20];
dists0  = [10*sqrt(5);10;10];
inds1   = [3;3;4];
[minDists, inds] = minDistancePoints(pts1, pts2);
testCase.assertEqual(dists0, minDists, 'AbsTol', .01);
testCase.assertEqual(inds1, inds, 'AbsTol', .01);

