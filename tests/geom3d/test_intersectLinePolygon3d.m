function test_suite = test_intersectLinePolygon3d
%TESTINTERSECTLINEPOLYGON3D  One-line description here, please.
%
%   output = testIntersectLinePolygon3d(input)
%
%   Example
%   testIntersectLinePolygon3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testTriangle(testCase) %#ok<*DEFNU>

pts3d = [3 0 0; 0 6 0;0 0 9];
line1 = [0 0 0 1 2 3];

inter = intersectLinePolygon3d(line1, pts3d);
exp = [1 2 3];
testCase.assertEqual(exp, inter);

line2 = [10 0 0 1 2 3];

[inter, inside] = intersectLinePolygon3d(line2, pts3d); %#ok<ASGLU>
testCase.assertFalse(inside);


function testReverseTriangle(testCase)

pts3d = [3 0 0; 0 6 0;0 0 9];
line1 = [0 0 0 1 2 3];

inter = intersectLinePolygon3d(line1, pts3d);
exp = [1 2 3];
testCase.assertEqual(exp, inter);


function testLineArray(testCase)

pts3d = [3 0 0;0 0 9; 0 6 0];
lines = [0 0 0 3 6 9 ; 10 0 0 3 6 9; 3 6 9 3 6 9];

[inters, inside] = intersectLinePolygon3d(lines, pts3d);
testCase.assertEqual(3, size(inters, 1));
testCase.assertEqual([true;false;true], inside);

function testBrianMurrihy(testCase)

lines = [...
    -5 5 1  0 0 -1; ...
    -6 6 1  0 0 -1; ...
    -7 7 1  0 0 -1; ...
     8 8 1  0 0 -1; ...
     9 9 1  0 0 -1];

poly = [0 0 0; 10 0 0; 10 10 0; 0 10 0];

[inters, inside] = intersectLinePolygon3d(lines, poly); %#ok<ASGLU>

exp = [false; false; false; true; true];
testCase.assertEqual(exp, inside);

