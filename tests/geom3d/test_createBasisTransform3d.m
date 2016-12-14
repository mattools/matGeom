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
