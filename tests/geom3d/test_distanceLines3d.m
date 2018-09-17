function test_suite = test_distanceLines3d
%TESTDISTANCELINES3D  One-line description here, please.
%
%   output = testDistanceLines3d(input)
%
%   Example
%   testDistanceLines3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-01-21,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testOrthogonal(testCase) %#ok<*DEFNU>

line1 = [0 0 0   0 0 1];
line2 = [10 0 0  0 1 0];

d = distanceLines3d(line1, line2);
testCase.assertEqual(10, d, 'AbsTol', .01);

line1 = [0 0 0   0 0 1];
line2 = [0 10 0  1 0 0];

d = distanceLines3d(line1, line2);
testCase.assertEqual(10, d, 'AbsTol', .01);

line1 = [0 0 0   0 1 0];
line2 = [0 0 10  1 0 0];

d = distanceLines3d(line1, line2);
testCase.assertEqual(10, d, 'AbsTol', .01);


function testNotOrthogonal(testCase) %#ok<*DEFNU>

line1 = [0 0 0   0 2 3];
line2 = [10 0 0  0 -1 4];

d = distanceLines3d(line1, line2);
testCase.assertEqual(10, d, 'AbsTol', .01);


function testArrays(testCase)

line1 = [0 0 0   0 2 3];
line2 = [10 0 0  0 -1 4];

dist = distanceLines3d(line1, repmat(line2, 5, 1));
exp = repmat(10, 1, 5);
testCase.assertEqual(exp, dist, 'AbsTol', .01);

dist = distanceLines3d(repmat(line1, 5, 1), line2);
exp = repmat(10, 5, 1);
testCase.assertEqual(exp, dist, 'AbsTol', .01);

