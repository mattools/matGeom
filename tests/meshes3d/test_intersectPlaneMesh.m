function test_suite = test_intersectPlaneMesh
%TEST_INTERSECTPLANEMESH  Test suite for the file intersectPlaneMesh.
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
% e-mail: david.legland@inrae.fr
% Created: 2012-07-31,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);


function test_cube_horizPlane(testCase)
plane = createPlane([5 5 5], [0 0 1]);
[v, f] = createCube;
f = triangulateFaces(f);
v = v * 10;
polys = intersectPlaneMesh(plane, v, f);

assertTrue(testCase, iscell(polys));
assertEqual(testCase, 1, length(polys));
assertEqual(testCase, 8, size(polys{1}, 1));


function test_cube_diagPlane(testCase)
plane = createPlane([1 1 1], [3 4 5]);
[v, f] = createCube;
f = triangulateFaces(f);
v = v * 5;
polys = intersectPlaneMesh(plane, v, f);

assertTrue(testCase, iscell(polys));
assertEqual(testCase, 1, length(polys));
assertEqual(testCase, 6, size(polys{1}, 1));


function test_cube_planeOutside(testCase)
plane = createPlane([15 15 15], [0 0 1]);
[v, f] = createCube;
f = triangulateFaces(f);
v = v * 5;
polys = intersectPlaneMesh(plane, v, f);

assertTrue(testCase, iscell(polys));
assertEqual(testCase, 0, length(polys));


function test_torus(testCase)
% expect two polygons as intersection

torus = [0 0 0  30 10 0 0];
[v, f] = torusMesh(torus);
f = triangulateFaces(f);
plane = [0 0 0  1 0 0  0 0 1];
polys = intersectPlaneMesh(plane, v, f);

assertEqual(testCase, 2, length(polys));


function test_verticalTriangle(testCase)
% Expect a single polyline as output.

v = [0 0 0; 10 0 0;0 0 10];
f = [1 2 3];
plane = [0 0 5  1 0 0  0 1 0];

[polys, flags] = intersectPlaneMesh(plane, v, f);

assertEqual(testCase, 1, length(polys));
assertEqual(testCase, 1, length(flags));
assertEqual(testCase, false, flags);
assertEqual(testCase, [2 3], size(polys{1}));


function test_openCube(testCase)
% Intersect plane with a cube with two opposite faces removed.
% expect two open polylines as output.

[v, f] = createCube;
f = triangulateFaces(f(1:4, :));
plane = [0 0 0.5  1 0 0  0 1 0];

[polys, flags] = intersectPlaneMesh(plane, v, f);

assertEqual(testCase, 2, length(polys));
assertEqual(testCase, 2, length(flags));
assertEqual(testCase, [false false], flags);
assertEqual(testCase, [3 3], size(polys{1}));
assertEqual(testCase, [3 3], size(polys{2}));
