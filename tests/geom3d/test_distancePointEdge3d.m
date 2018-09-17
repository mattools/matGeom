function test_suite = test_distancePointEdge3d
%TEST_DISTANCEPOINTEDGE3D  Test case for the file distancePointEdge3d
%
%   Test case for the file distancePointEdge3d

%   Example
%   test_distancePointEdge3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-04-29,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument

edge = [10 10 10 30 10 10];

p0 = [10 10 10];
exp0 = 0;
testCase.assertEqual(exp0, distancePointEdge3d(p0, edge), 'AbsTol', .01);

p1 = [30 10 10];
exp1 = 0;
testCase.assertEqual(exp1, distancePointEdge3d(p1, edge), 'AbsTol', .01);

p2 = [0 0 0];
exp2 = 10 * sqrt(3);
testCase.assertEqual(exp2, distancePointEdge3d(p2, edge), 'AbsTol', 1e-14);

p3 = [40 20 20];
exp3 = 10 * sqrt(3);
testCase.assertEqual(exp3, distancePointEdge3d(p3, edge), 'AbsTol', 1e-14);

function testArray(testCase)

edge = [10 10 10 30 10 10];
pts = [10 10 10;30 10 10;0 0 0;40 20 20];
exp = [0 0 10*sqrt(3) 10*sqrt(3)]';
testCase.assertEqual(exp, distancePointEdge3d(pts, edge), 'AbsTol', 1e-14);

