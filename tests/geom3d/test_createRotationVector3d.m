function test_suite = test_createRotationVector3d
%TEST_CREATEROTATIONVECTOR3D  Test case for the file createRotationVector3d
%
%   Test case for the file createRotationVector3d
%   
%   Example
%     runtests('test_createRotationVector3d.m')
%
%   See also
%
% ------
% Author: oqilipo
% Created: 2017-08-08, using Matlab R2016b
% Copyright 2017

test_suite = functiontests(localfunctions); 

function test_random(testCase)
A=-1+2.*rand(1,3);
B=-2+4.*rand(1,3);
ROT = createRotationVector3d(A,B);
C = transformVector3d(A,ROT);
testCase.assertEqual(normalizeVector3d(B),normalizeVector3d(C), 'AbsTol', 1e-14);
testCase.assertEqual(vectorNorm3d(A),vectorNorm3d(C), 'AbsTol', 1e-14)

function test_parallel(testCase)
A=-1+2.*rand(1,3);
B=A*2;
ROT = createRotationVector3d(A,B);
C = transformVector3d(A,ROT);
testCase.assertEqual(normalizeVector3d(B),normalizeVector3d(C), 'AbsTol', 1e-14);
testCase.assertEqual(vectorNorm3d(A),vectorNorm3d(C), 'AbsTol', 1e-14)

function test_antiparallel(testCase)
A=-1+2.*rand(1,3);
B=A*-3;
ROT = createRotationVector3d(A,B);
C = transformVector3d(A,ROT);
testCase.assertEqual(normalizeVector3d(B),normalizeVector3d(C), 'AbsTol', 1e-14);
testCase.assertEqual(vectorNorm3d(A),vectorNorm3d(C), 'AbsTol', 1e-14)

