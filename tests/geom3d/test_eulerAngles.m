function test_suite = test_eulerAngles
%TESTEULERANGLES Test conversion euler angles <-> rotation matrix
%
%   output = test_EulerAngles(input)
%
%   Example
%     runtests('test_EulerAngles.m')
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-20,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testPositiveAngles(testCase) %#ok<*DEFNU>

mat = eulerAnglesToRotation3d(10, 20, 30);
[phi, theta, psi] = rotation3dToEulerAngles(mat);

testCase.assertEqual(10, phi, 'AbsTol', .01);
testCase.assertEqual(20, theta, 'AbsTol', .01);
testCase.assertEqual(30, psi, 'AbsTol', .01);


function testNegativeAngles(testCase)

mat = eulerAnglesToRotation3d(-10, -20, -30);
[phi, theta, psi] = rotation3dToEulerAngles(mat);

testCase.assertEqual(-10, phi, 'AbsTol', .01);
testCase.assertEqual(-20, theta, 'AbsTol', .01);
testCase.assertEqual(-30, psi, 'AbsTol', .01);

function testRandomAnglesZYX(testCase)

phi=-360+720*rand;
theta=-360+720*rand;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat);
mat2 = eulerAnglesToRotation3d(phi, theta, psi);

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

%% ZXY
function testRandomAnglesZXY(testCase)

phi=-360+720*rand;
theta=-360+720*rand;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'ZXY');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'ZXY');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

function testGimbalLockZXY(testCase)

phi=-360+720*rand;
theta=0;
psi=270;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'ZXY');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'ZXY');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

%% YXZ
function testRandomAnglesYXZ(testCase)

phi=-360+720*rand;
theta=-360+720*rand;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'YXZ');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'YXZ');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

function testGimbalLockYXZ(testCase)

phi=-360+720*rand;
theta=0;
psi=270;

mat = eulerAnglesToRotation3d(phi, theta, psi)';
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'YXZ');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'YXZ');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

%% YXZ
function testRandomAnglesYZX(testCase)

phi=-360+720*rand;
theta=-360+720*rand;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'YZX');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'YZX');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

function testGimbalLockYZX(testCase)

phi=90;
theta=-360+720*rand;
psi=0;

mat = eulerAnglesToRotation3d(phi, theta, psi)';
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'YZX');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'YZX');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

%% XYZ
function testRandomAnglesXYZ(testCase)

phi=-360+720*rand;
theta=-360+720*rand;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'XYZ');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'XYZ');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

function testGimbalLockXYZ(testCase)

phi=0;
theta=90;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi)';
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'XYZ');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'XYZ');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

%% XZY
function testRandomAnglesXZY(testCase)

phi=-360+720*rand;
theta=-360+720*rand;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'XZY');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'XZY');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

function testGimbalLockXZY(testCase)

phi=90;
theta=-360+720*rand;
psi=0;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'XZY');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'XZY');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

%% ZYZ
function testRandomAnglesZYZ(testCase)

phi=-360+720*rand;
theta=-360+720*rand;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'ZYZ');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'ZYZ');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)
