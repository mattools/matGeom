function test_suite = test_planePoint
%TEST_PLANEPOINT  Test case for the file planePoint
%
%   Test case for the file planePoint

%   Example
%   test_planePoint
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-10-09,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument

plane = [10 20 30  1 0 0  0 1 0];
exp = [10 20 30] + [2 3 0];
pt = planePoint(plane, [2 3]);
testCase.assertEqual(exp, pt);


function test_NPoints(testCase)
% Test call of function without argument

plane = [10 20 30  1 0 0  0 1 0];
exp = repmat([10 20 30] + [2 3 0], 5, 1);
pt = planePoint(plane, repmat([2 3], 5, 1));
testCase.assertEqual(exp, pt);

function test_NPlanes(testCase)
% Test call of function without argument

plane = [10 20 30  1 0 0  0 1 0];
exp = repmat([10 20 30] + [2 3 0], 5, 1);
pt = planePoint(repmat(plane, 5, 1), [2 3]);
testCase.assertEqual(exp, pt);

function test_NBoth(testCase)
% Test call of function without argument

plane = [10 20 30  1 0 0  0 1 0];
exp = repmat([10 20 30] + [2 3 0], 5, 1);
pt = planePoint(repmat(plane, 5, 1), repmat([2 3], 5, 1));
testCase.assertEqual(exp, pt);

