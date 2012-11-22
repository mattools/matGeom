function test_suite = test_intersectPlaneMesh(varargin) %#ok<STOUT>
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

initTestSuite;

function test_cube_horizPlane %#ok<*DEFNU>
% Test call of function without argument

plane = createPlane([5 5 5], [0 0 1]);
[v f] = createCube;
v = v * 10;

polys = intersectPlaneMesh(plane, v, f);
assertTrue(iscell(polys));
assertEqual(1, length(polys));
assertEqual(4, size(polys{1}, 1));



function test_cube_diagPlane
% Test call of function without argument

plane = createPlane([1 1 1], [3 4 5]);
[v f] = createCube;
v = v * 5;

polys = intersectPlaneMesh(plane, v, f);

assertTrue(iscell(polys));
assertEqual(1, length(polys));
assertEqual(3, size(polys{1}, 1));



function test_cube_planeOutside
% Test call of function without argument

plane = createPlane([15 15 15], [0 0 1]);
[v f] = createCube;
v = v * 5;

polys = intersectPlaneMesh(plane, v, f);

assertTrue(iscell(polys));
assertEqual(0, length(polys));



