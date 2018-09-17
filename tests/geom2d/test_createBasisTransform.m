function test_suite = test_createBasisTransform
%TEST_CREATEBASISTRANSFORM  Test case for the file createBasisTransform
%
%   Test case for the file createBasisTransform

%   Example
%   test_createBasisTransform
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-10-13,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function test_Translate(testCase) %#ok<*DEFNU>
% Basic test to check the function runs

p1 = [3 4];
p2 = [10 20];
basis1 = [p1 1 0 0 1];
basis2 = [p2 1 0 0 1];

dp = p1-p2;
exp = [eye(2) dp' ; 0 0 1];

trans = createBasisTransform(basis1, basis2);
testCase.assertEqual(exp, trans, 'AbsTol', .01);


function test_NonOrthogonalBasis(testCase)
% Check consistency of transfomating to Non Ortho bases, and back to global

src = [0 0  1 0  0 1];
tgt = [1 2  3 4  -5 6];

% transform a polygon to TGT basis
poly = [10 10;30 10; 30 20; 20 20;20 40; 10 40];
trans = createBasisTransform(src, tgt);
poly2 = transformPoint(poly, trans);

% transform back to original basis
trans2 = createBasisTransform(tgt, src);
poly3 = transformPoint(poly2, trans2);

testCase.assertEqual(poly, poly3, 'AbsTol', .01);

