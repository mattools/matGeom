function test_suite = test_createBasisTransform3d
%TEST_CREATEBASISTRANSFORM3D  Test case for the file createBasisTransform3d
%
%   Test case for the file createBasisTransform3d

%   Example
%   test_createBasisTransform3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-10-13,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function test_Translate(testCase) %#ok<*DEFNU>
% Basic test to check the function runs

p1 = [3 4 5];
p2 = [10 20 30];
basis1 = [p1 1 0 0 0 1 0];
basis2 = [p2 1 0 0 0 1 0];

dp = p1-p2;
exp = [eye(3) dp' ; 0 0 0 1];

trans = createBasisTransform3d(basis1, basis2);
testCase.assertEqual(exp, trans, 'AbsTol', .01);


function test_TransformPointTranslation(testCase) %#ok<*DEFNU>
% Basic test to check the function runs

% two bases with different origins and same directions
basis1 = [0 0 0     1 0 0  0 1 0];
basis2 = [10 20 30  1 0 0  0 1 0];

trans = createBasisTransform3d(basis1, basis2);

% pt1 = [0 0 0];
% pt1T = transformPoint3d(pt1, trans);
% exp1 = [0 0 0];
% testCase.assertEqual(exp1, pt1T, 'AbsTol', .01);

pt2 = [10 20 30];
pt2T = transformPoint3d(pt2, trans);
exp2 = [0 0 0];
testCase.assertEqual(exp2, pt2T, 'AbsTol', .01);




function test_Rotate(testCase) %#ok<*DEFNU>
% Basic test to check the function runs

p1 = [3 4 5];
basis1 = [p1  1 0 0   0 1 0];
basis2 = [p1  0 1 0  -1 0 0];

trans = createBasisTransform3d(basis1, basis2);

% restrict the test to the linear part
exp = [0 1 0; -1 0 0; 0 0 1];
testCase.assertEqual(exp, trans(1:3, 1:3), 'AbsTol', .01);



function test_TransformedPoints(testCase) %#ok<*DEFNU>
% test a combination of translation and axis permutation

% origin basis
basis1 = [10 10 10   1 0 0   0 1 0];
% translation and permutation
basis2 = [0 0 0   0 1 0   0 0 1];

trans = createBasisTransform3d(basis1, basis2);

pt1 = [0 0 0];
pt1T = transformPoint3d(pt1, trans);

exp1 = [10 10 10];
testCase.assertEqual(exp1, pt1T, 'AbsTol', .01);
