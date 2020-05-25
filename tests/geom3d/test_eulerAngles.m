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

function testPositiveAngles(testCase)

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

%% ZYX
function testRandomAnglesZYX(testCase)

phi=-360+720*rand;
theta=-360+720*rand;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'ZYX');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'ZYX');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

function testGimbalLockZYX(testCase)

phi=-360+720*rand;
theta=90;
psi=90;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'ZYX');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'ZYX');

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

function testGimbalLockZYZ(testCase)

phi=-360+720*rand;
theta=0;
psi=180;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'ZYZ');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'ZYZ');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

%% ZXZ
function testRandomAnglesZXZ(testCase)

phi=-360+720*rand;
theta=-360+720*rand;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'ZXZ');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'ZXZ');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

function testGimbalLockZXZ(testCase)

phi=-360+720*rand;
theta=0;
psi=180;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'ZXZ');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'ZXZ');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

%% YZY
function testRandomAnglesYZY(testCase)

phi=-360+720*rand;
theta=-360+720*rand;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'YZY');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'YZY');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

function testGimbalLockYZY(testCase)

phi=180;
theta=-360+720*rand;
psi=180;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'YZY');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'YZY');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

%% YXY
function testRandomAnglesYXY(testCase)

phi=-360+720*rand;
theta=-360+720*rand;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'YXY');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'YXY');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

function testGimbalLockYXY(testCase)

phi=180;
theta=-360+720*rand;
psi=180;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'YXY');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'YXY');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

%% XZX
function testRandomAnglesXZX(testCase)

phi=-360+720*rand;
theta=-360+720*rand;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'XZX');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'XZX');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

function testGimbalLockXZX(testCase)

phi=180;
theta=180;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'XZX');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'XZX');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

%% XYX
function testRandomAnglesXYX(testCase)

phi=-360+720*rand;
theta=-360+720*rand;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'XYX');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'XYX');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)

function testGimbalLockXYX(testCase)

phi=180;
theta=180;
psi=-360+720*rand;

mat = eulerAnglesToRotation3d(phi, theta, psi);
[phi, theta, psi] = rotation3dToEulerAngles(mat, 'XYX');
mat2 = eulerAnglesToRotation3d(phi, theta, psi, 'XYX');

testCase.assertEqual(zeros(4,4),(mat-mat2), 'AbsTol', 10*eps)
