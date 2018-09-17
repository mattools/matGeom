function test_suite = test_distancePoints
%TESTDISTANCEPOINTS  One-line description here, please.
%   output = test_distancePoints(input)
%
%   Example
%   testDistancePoints
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

function testSingleSingle(testCase) %#ok<*DEFNU>

pt1 = [10 10];
pt2 = [10 20];
pt3 = [20 20];

testCase.assertEqual(distancePoints(pt1, pt2), 10, 'AbsTol', .01);
testCase.assertEqual(distancePoints(pt2, pt3), 10, 'AbsTol', .01);
testCase.assertEqual(distancePoints(pt1, pt3), 10*sqrt(2), 'AbsTol', .01);

function testSingleSingleNorm1(testCase)
% test norm 1, equivalent to sum of absolute differences

pt1 = [10 10];
pt2 = [10 20];
pt3 = [20 20];

testCase.assertEqual(distancePoints(pt1, pt2, 1), 10, 'AbsTol', .01);
testCase.assertEqual(distancePoints(pt2, pt3, 1), 10, 'AbsTol', .01);
testCase.assertEqual(distancePoints(pt1, pt3, 1), 20, 'AbsTol', .01);

function testSingleSingleMaxNorm(testCase)

pt1 = [10 10];
pt2 = [10 20];
pt3 = [20 20];

testCase.assertEqual(distancePoints(pt1, pt2, inf), 10, 'AbsTol', .01);
testCase.assertEqual(distancePoints(pt2, pt3, inf), 10, 'AbsTol', .01);
testCase.assertEqual(distancePoints(pt1, pt3, inf), 10, 'AbsTol', .01);

function testSingleSingle3d(testCase)

pt1 = [10 10 10];
pt2 = [10 20 10];
pt3 = [20 20 10];
pt4 = [20 20 20];

testCase.assertEqual(distancePoints(pt1, pt2), 10, 'AbsTol', .01);
testCase.assertEqual(distancePoints(pt2, pt3), 10, 'AbsTol', .01);
testCase.assertEqual(distancePoints(pt1, pt3), 10*sqrt(2), 'AbsTol', .01);
testCase.assertEqual(distancePoints(pt1, pt4), 10*sqrt(3), 'AbsTol', .01);


function testSingleSingle3dNorm1(testCase)
% test norm 1, equivalent to sum of absolute differences

pt1 = [10 10 30];
pt2 = [10 20 30];
pt3 = [20 20 30];
pt4 = [20 20 40];

testCase.assertEqual(distancePoints(pt1, pt2, 1), 10, 'AbsTol', .01);
testCase.assertEqual(distancePoints(pt2, pt3, 1), 10, 'AbsTol', .01);
testCase.assertEqual(distancePoints(pt1, pt3, 1), 20, 'AbsTol', .01);
testCase.assertEqual(distancePoints(pt1, pt4, 1), 30, 'AbsTol', .01);

function testSingleSingleMaxNorm3d(testCase)

pt1 = [10 10 10];
pt2 = [10 20 10];
pt3 = [20 20 10];
pt4 = [20 20 20];

testCase.assertEqual(distancePoints(pt1, pt2, inf), 10, 'AbsTol', .01);
testCase.assertEqual(distancePoints(pt2, pt3, inf), 10, 'AbsTol', .01);
testCase.assertEqual(distancePoints(pt1, pt3, inf), 10, 'AbsTol', .01);
testCase.assertEqual(distancePoints(pt1, pt4, inf), 10, 'AbsTol', .01);

function testSingleArray(testCase)

pt1 = [10 10];
pt2 = [10 20];
pt3 = [20 20];

testCase.assertEqual(...
    distancePoints(pt1, [pt1; pt2; pt3]), ...
    [0 10 10*sqrt(2)], 'AbsTol', .01);

function testArrayArray(testCase)

pt1 = [10 10];
pt2 = [10 20];
pt3 = [20 20];
pt4 = [20 10];

array1 = [pt1;pt2;pt3];
array2 = [pt1;pt2;pt3;pt4];
res = [...
    0 10 10*sqrt(2) 10;...
    10 0 10 10*sqrt(2);...
    10*sqrt(2) 10 0 10];
    
testCase.assertEqual(distancePoints(array1, array2), res, 'AbsTol', .01);

function testArrayArrayDiag(testCase)

pt1 = [10 10];
pt2 = [10 20];
pt3 = [20 20];

array = [pt1;pt2;pt3];

testCase.assertEqual(...
    distancePoints(array, array, 'diag'), ...
    [0;0;0], 'AbsTol', .01);

function testArrayArray3dDiag(testCase)

pt1 = [10 10 30];
pt2 = [10 20 30];
pt3 = [10 20 40];

array1 = [pt1;pt2;pt3];
array2 = [pt2;pt3;pt1];

testCase.assertEqual(...
    distancePoints(array1, array2, 'diag'), ...
    [10;10;10*sqrt(2)], 'AbsTol', .01);

function testArrayArray3dNorm1Diag(testCase)

pt1 = [10 10 30];
pt2 = [10 20 30];
pt3 = [10 20 40];

array1 = [pt1;pt2;pt3];
array2 = [pt2;pt3;pt1];

testCase.assertEqual(...
    distancePoints(array1, array2, 1, 'diag'), ...
    [10;10;20], 'AbsTol', .01);


function testArrayArrayDiagMaxNorm(testCase)

pt1 = [10 10];
pt2 = [10 20];
pt3 = [20 20];

array1 = [pt1;pt2;pt3];
array2 = [pt2;pt3;pt1];

testCase.assertEqual(...
    distancePoints(array1, array2, inf, 'diag'), ...
    [10;10;10], 'AbsTol', .01);
