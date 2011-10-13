function test_suite = test_createBasisTransform(varargin) %#ok<STOUT>
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

initTestSuite;


function test_Translate %#ok<*DEFNU>
% Basic test to check the function runs

p1 = [3 4];
p2 = [10 20];
basis1 = [p1 1 0 0 1];
basis2 = [p2 1 0 0 1];

dp = p1-p2;
exp = [eye(2) dp' ; 0 0 1];

trans = createBasisTransform(basis1, basis2);
assertElementsAlmostEqual(exp, trans);
