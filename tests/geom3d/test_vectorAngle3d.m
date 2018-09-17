function test_suite = test_vectorAngle3d
%TESTVECTORANGLE3D  One-line description here, please.
%
%   output = testVectorAngle3d(input)
%
%   Example
%   testVectorAngle3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2010-11-16,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testOrthogonalUnitVectors(testCase) %#ok<*DEFNU>

v1 = [1 0 0];
v2 = [0 1 0];
v3 = [0 0 1];
exp = pi/2;

angle1 = vectorAngle3d(v1, v2);
testCase.assertEqual(exp, angle1);

angle2 = vectorAngle3d(v1, v3);
testCase.assertEqual(exp, angle2);

angle3 = vectorAngle3d(v2, v3);
testCase.assertEqual(exp, angle3);

angle1 = vectorAngle3d(v1, -v2);
testCase.assertEqual(exp, angle1);

angle2 = vectorAngle3d(v1, -v3);
testCase.assertEqual(exp, angle2);

angle3 = vectorAngle3d(v2, -v3);
testCase.assertEqual(exp, angle3);

function testOrthogonalVectors(testCase)

v1 = [3 0 0];
v2 = [0 4 0];
v3 = [0 0 5];
exp = pi/2;

angle1 = vectorAngle3d(v1, v2);
testCase.assertEqual(exp, angle1);

angle2 = vectorAngle3d(v1, v3);
testCase.assertEqual(exp, angle2);

angle3 = vectorAngle3d(v2, v3);
testCase.assertEqual(exp, angle3);


function testParallelVectors(testCase)

v1 = [3 0 0];
v2 = [5 0 0];
exp = 0;

angle1 = vectorAngle3d(v1, v2);
testCase.assertEqual(exp, angle1);


v1 = [3 4 5]*7;
v2 = [3 4 5]*11;
exp = 0;

angle1 = vectorAngle3d(v1, v2);
testCase.assertEqual(exp, angle1);


function testSingleByArray(testCase)

v0 = [7 0 0];
v1 = [3 0 0];
v2 = [0 4 0];
v3 = [0 0 5];
vecs = cat(1, v1, v2, v3);

exp = [0; pi/2; pi/2];
angles = vectorAngle3d(v0, vecs);
testCase.assertEqual(exp, angles);

function testArrayByArray(testCase)

v0 = [7 0 0];
v1 = [3 0 0];
v2 = [0 4 0];
v3 = [0 0 5];
vecs1 = cat(1, v0, v0, v0);
vecs2 = cat(1, v1, v2, v3);

exp = [0; pi/2; pi/2];
angles = vectorAngle3d(vecs1, vecs2);
testCase.assertEqual(exp, angles);

