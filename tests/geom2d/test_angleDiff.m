function test_suite = test_angleDiff
%TEST_ANGLEDIFF  Test case for the file angleDiff
%
%   Test case for the file angleDiff

%   Example
%   test_angleDiff
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-07-27,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% simple tests


dif = angleDiff(0, pi/2);
testCase.assertEqual(pi/2, dif, 'AbsTol', .01);

dif = angleDiff(pi/2, 0);
testCase.assertEqual(-pi/2, dif, 'AbsTol', .01);

dif = angleDiff(0, 3*pi/2);
testCase.assertEqual(-pi/2, dif, 'AbsTol', .01);

dif = angleDiff(3*pi/2, 0);
testCase.assertEqual(pi/2, dif, 'AbsTol', .01);
