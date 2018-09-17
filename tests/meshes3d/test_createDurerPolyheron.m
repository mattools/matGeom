function test_suite = test_createDurerPolyheron
%TEST_CREATEDURERPOLYHERON  Test case for the file createDurerPolyheron
%
%   Test case for the file createDurerPolyheron

%   Example
%   test_createDurerPolyheron
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-07-31,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument
[v, f] = createDurerPolyhedron;
testCase.assertEqual([12 3], size(v));
testCase.assertEqual(8, length(f));

function test_VEF(testCase)
% Test call of function without argument
[v, e, f] = createDurerPolyhedron;
testCase.assertEqual([12 3], size(v));
testCase.assertEqual([18 2], size(e));
testCase.assertEqual(8, length(f));
