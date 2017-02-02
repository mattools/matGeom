function test_suite = test_projPointOnPlane
%TEST_PROJPOINTONPLANE  Test case for the file projPointOnPlane
%
%   Test case for the file projPointOnPlane

%   Example
%   test_projPointOnPlane
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-07-03,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument

plane = createPlane([10 20 30], [0 0 1]);
point = [12 23 34];

proj = projPointOnPlane(point, plane);
exp = [12 23 30];

testCase.assertEqual(exp, proj, 'AbsTol', 1e-12);


