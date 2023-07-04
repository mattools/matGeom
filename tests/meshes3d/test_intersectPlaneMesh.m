function test_suite = test_intersectPlaneMesh
%TEST_INTERSECTPLANEMESH  Test case for the file intersectPlaneMesh
%
%   Test case for the file intersectPlaneMesh
%
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

function test_cube_horizPlane(testCase)
plane = createPlane([5 5 5], [0 0 1]);
[v, f] = createCube;
f = triangulateFaces(f);
v = v * 10;
polys = intersectPlaneMesh(plane, v, f);

testCase.assertTrue(iscell(polys));
testCase.assertEqual(1, length(polys));
testCase.assertEqual(8, size(polys{1}, 1));


function test_cube_diagPlane(testCase)
plane = createPlane([1 1 1], [3 4 5]);
[v, f] = createCube;
f = triangulateFaces(f);
v = v * 5;
polys = intersectPlaneMesh(plane, v, f);

testCase.assertTrue(iscell(polys));
testCase.assertEqual(1, length(polys));
testCase.assertEqual(6, size(polys{1}, 1));


function test_cube_planeOutside(testCase)
plane = createPlane([15 15 15], [0 0 1]);
[v, f] = createCube;
f = triangulateFaces(f);
v = v * 5;
polys = intersectPlaneMesh(plane, v, f);

testCase.assertTrue(iscell(polys));
testCase.assertEqual(0, length(polys));


function test_torus(testCase)
% expect two polygons as intersection

torus = [0 0 0  30 10 0 0];
[v, f] = torusMesh(torus);
f = triangulateFaces(f);
plane = [0 0 0  1 0 0  0 0 1];
polys = intersectPlaneMesh(plane, v, f);

testCase.assertEqual(2, length(polys));


function test_verticalTriangle(testCase)
% Expect a single polyline as output.

v = [0 0 0; 10 0 0;0 0 10];
f = [1 2 3];
plane = [0 0 5  1 0 0  0 1 0];

[rings, curves] = intersectPlaneMesh(plane, v, f);

assertEqual(testCase, 0, length(rings));
assertEqual(testCase, 1, length(curves));
assertEqual(testCase, [2 3], size(curves{1}));


function test_openCube(testCase)
% Intersect plane with a cube with two opposite faces removed.
% expect two open polylines as output.

[v, f] = createCube;
f = triangulateFaces(f(1:4, :));
plane = [0 0 0.5  1 0 0  0 1 0];

[rings, curves] = intersectPlaneMesh(plane, v, f);

assertEqual(testCase, 0, length(rings));
assertEqual(testCase, 2, length(curves));
assertEqual(testCase, [3 3], size(curves{1}));
assertEqual(testCase, [3 3], size(curves{2}));
