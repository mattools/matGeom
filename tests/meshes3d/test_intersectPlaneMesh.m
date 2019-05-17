function test_suite = test_intersectPlaneMesh
%TEST_INTERSECTPLANEMESH  Test case for the file intersectPlaneMesh
%
%   Test case for the file intersectPlaneMesh

%   Example
%   test_intersectPlaneMesh
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


function test_cube_horizPlane(testCase) %#ok<*DEFNU>
% Test call of function without argument

plane = createPlane([5 5 5], [0 0 1]);
[v, f] = createCube;
v = v * 10;

polys = intersectPlaneMesh(plane, v, f);
testCase.assertTrue(iscell(polys));
testCase.assertEqual(1, length(polys));
testCase.assertEqual(4, size(polys{1}, 1));



function test_cube_diagPlane(testCase)
% Test call of function without argument

plane = createPlane([1 1 1], [3 4 5]);
[v, f] = createCube;
v = v * 5;

polys = intersectPlaneMesh(plane, v, f);

testCase.assertTrue(iscell(polys));
testCase.assertEqual(1, length(polys));
testCase.assertEqual(3, size(polys{1}, 1));



function test_cube_planeOutside(testCase)
% Test call of function without argument

plane = createPlane([15 15 15], [0 0 1]);
[v, f] = createCube;
v = v * 5;

polys = intersectPlaneMesh(plane, v, f);

testCase.assertTrue(iscell(polys));
testCase.assertEqual(0, length(polys));

function test_torus(testCase)

torus = [0 0 0  30 10 0 0];
[v, f] = torusMesh(torus);

plane = [0 0 0  1 0 0  0 0 1];

polys = intersectPlaneMesh(plane, v, f);

testCase.assertEqual(2, length(polys));


