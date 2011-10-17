function test_suite = test_distancePoints(varargin) %#ok<STOUT>
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

initTestSuite;

function testSingleSingle %#ok<*DEFNU>

pt1 = [10 10];
pt2 = [10 20];
pt3 = [20 20];

assertElementsAlmostEqual(distancePoints(pt1, pt2), 10);
assertElementsAlmostEqual(distancePoints(pt2, pt3), 10);
assertElementsAlmostEqual(distancePoints(pt1, pt3), 10*sqrt(2));

function testSingleSingleNorm1
% test norm 1, equivalent to sum of absolute differences

pt1 = [10 10];
pt2 = [10 20];
pt3 = [20 20];

assertElementsAlmostEqual(distancePoints(pt1, pt2, 1), 10);
assertElementsAlmostEqual(distancePoints(pt2, pt3, 1), 10);
assertElementsAlmostEqual(distancePoints(pt1, pt3, 1), 20);

function testSingleSingleMaxNorm

pt1 = [10 10];
pt2 = [10 20];
pt3 = [20 20];

assertElementsAlmostEqual(distancePoints(pt1, pt2, inf), 10);
assertElementsAlmostEqual(distancePoints(pt2, pt3, inf), 10);
assertElementsAlmostEqual(distancePoints(pt1, pt3, inf), 10);

function testSingleSingle3d

pt1 = [10 10 10];
pt2 = [10 20 10];
pt3 = [20 20 10];
pt4 = [20 20 20];

assertElementsAlmostEqual(distancePoints(pt1, pt2), 10);
assertElementsAlmostEqual(distancePoints(pt2, pt3), 10);
assertElementsAlmostEqual(distancePoints(pt1, pt3), 10*sqrt(2));
assertElementsAlmostEqual(distancePoints(pt1, pt4), 10*sqrt(3));


function testSingleSingle3dNorm1
% test norm 1, equivalent to sum of absolute differences

pt1 = [10 10 30];
pt2 = [10 20 30];
pt3 = [20 20 30];
pt4 = [20 20 40];

assertElementsAlmostEqual(distancePoints(pt1, pt2, 1), 10);
assertElementsAlmostEqual(distancePoints(pt2, pt3, 1), 10);
assertElementsAlmostEqual(distancePoints(pt1, pt3, 1), 20);
assertElementsAlmostEqual(distancePoints(pt1, pt4, 1), 30);

function testSingleSingleMaxNorm3d

pt1 = [10 10 10];
pt2 = [10 20 10];
pt3 = [20 20 10];
pt4 = [20 20 20];

assertElementsAlmostEqual(distancePoints(pt1, pt2, inf), 10);
assertElementsAlmostEqual(distancePoints(pt2, pt3, inf), 10);
assertElementsAlmostEqual(distancePoints(pt1, pt3, inf), 10);
assertElementsAlmostEqual(distancePoints(pt1, pt4, inf), 10);

function testSingleArray

pt1 = [10 10];
pt2 = [10 20];
pt3 = [20 20];

assertElementsAlmostEqual(...
    distancePoints(pt1, [pt1; pt2; pt3]), ...
    [0 10 10*sqrt(2)]);

function testArrayArray

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
    
assertElementsAlmostEqual(distancePoints(array1, array2), res);

function testArrayArrayDiag

pt1 = [10 10];
pt2 = [10 20];
pt3 = [20 20];

array = [pt1;pt2;pt3];

assertElementsAlmostEqual(...
    distancePoints(array, array, 'diag'), ...
    [0;0;0]);

function testArrayArray3dDiag

pt1 = [10 10 30];
pt2 = [10 20 30];
pt3 = [10 20 40];

array1 = [pt1;pt2;pt3];
array2 = [pt2;pt3;pt1];

assertElementsAlmostEqual(...
    distancePoints(array1, array2, 'diag'), ...
    [10;10;10*sqrt(2)]);

function testArrayArray3dNorm1Diag

pt1 = [10 10 30];
pt2 = [10 20 30];
pt3 = [10 20 40];

array1 = [pt1;pt2;pt3];
array2 = [pt2;pt3;pt1];

assertElementsAlmostEqual(...
    distancePoints(array1, array2, 1, 'diag'), ...
    [10;10;20]);


function testArrayArrayDiagMaxNorm

pt1 = [10 10];
pt2 = [10 20];
pt3 = [20 20];

array1 = [pt1;pt2;pt3];
array2 = [pt2;pt3;pt1];

assertElementsAlmostEqual(...
    distancePoints(array1, array2, inf, 'diag'), ...
    [10;10;10]);
