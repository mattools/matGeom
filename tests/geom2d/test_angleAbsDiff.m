function test_suite = test_angleAbsDiff
%TEST_ANGLEABSDIFF  Test case for the file angleAbsDiff
%
%   Test case for the file angleDiff

%   Example
%   test_angleAbsDiff
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

exp = pi/2;

dif = angleAbsDiff(pi/2, 0);
testCase.assertEqual(exp, dif, 'AbsTol', .01);

dif = angleAbsDiff(0, pi/2);
testCase.assertEqual(exp, dif, 'AbsTol', .01);

dif = angleAbsDiff(0, 3*pi/2);
testCase.assertEqual(exp, dif, 'AbsTol', .01);

dif = angleAbsDiff(3*pi/2, 0);
testCase.assertEqual(exp, dif, 'AbsTol', .01);
