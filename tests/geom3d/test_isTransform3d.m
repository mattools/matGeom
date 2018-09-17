function test_suite = test_isTransform3d
%Check if input is a homogeneous transformation
%
%   Example
%     runtests('test_isTransform3d.m')
%
% ------
% Author: oqilipo
% Created: 2018-07-05
% Copyright 2018

test_suite = functiontests(localfunctions);

function testPureRotationAndSize(testCase)
rot = createRotationOx(rand*2*pi)*createRotationOy(rand*2*pi)*createRotationOx(rand*2*pi);
testCase.assertEqual(true, isTransform3d(rot, 'rot',true));
rot(5,:) = zeros(1,size(rot,2));
testCase.assertEqual(false, isTransform3d(rot, 'rot',true));
rot(4:5,:) = [];
testCase.assertEqual(true, isTransform3d(rot, 'rot',true));
rot(:,5) = zeros(size(rot,1),1);
testCase.assertEqual(false, isTransform3d(rot, 'rot',true));
rot(:,4:5) = [];
testCase.assertEqual(true, isTransform3d(rot, 'rot',true));
rot(3,:) = [];
testCase.assertEqual(false, isTransform3d(rot, 'rot',true));
rot(:,3) = [];
testCase.assertEqual(false, isTransform3d(rot, 'rot',true));

function testRotationAndTranslationAndNanAndInf(testCase)
rot = createRotationOx(rand*2*pi)*createRotationOy(rand*2*pi)*createRotationOx(rand*2*pi);
trans = rot*createTranslation3d(rand(1,3));
testCase.assertEqual(true, isTransform3d(trans));
trans2 = trans; trans2(1,1) = nan;
testCase.assertEqual(false, isTransform3d(trans2));
trans2 = trans; trans2(1,1) = Inf;
testCase.assertEqual(false, isTransform3d(trans2));

function testLastRow(testCase)
trans=eye(4);
trans2 = trans; trans2(4,4) = 2;
testCase.assertEqual(false, isTransform3d(trans2));
trans2 = trans; trans2(4,1:3) = 1;
testCase.assertEqual(false, isTransform3d(trans2));

function testTransposeAndDeterminat(testCase)
rot = createRotationOx(rand*2*pi)*createRotationOy(rand*2*pi)*createRotationOx(rand*2*pi);
trans = rot*createTranslation3d(rand(1,3));
trans2 = trans; trans2(1,1) = trans2(1,1)*2;
testCase.assertEqual(false, isTransform3d(trans2, 'rot',true));
trans2 = eye(4); trans2(1,1)=-1;
testCase.assertEqual(false, isTransform3d(trans2, 'rot',true));