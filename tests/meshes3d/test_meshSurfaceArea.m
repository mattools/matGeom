function test_suite = test_meshSurfaceArea
%TEST_MESHSURFACEAREA  Test case for the file meshSurfaceArea
%
%   Test case for the file meshSurfaceArea

%   Example
%   test_meshSurfaceArea
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-10-17,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);


function test_Cube(testCase) %#ok<*DEFNU>

[v, e, f] = createCube; %#ok<ASGLU>
area = meshSurfaceArea(v, f);

exp = 6;
testCase.assertEqual(exp, area, 'AbsTol', .1);


function test_Octahedron(testCase)

[v, e, f] = createOctahedron(); %#ok<ASGLU>
area = meshSurfaceArea(v, f);

a = sqrt(2);
exp = 2 * sqrt(3) * a * a;

testCase.assertEqual(exp, area, 'AbsTol', .1);

