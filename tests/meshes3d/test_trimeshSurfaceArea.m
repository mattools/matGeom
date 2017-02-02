function test_suite = test_trimeshSurfaceArea
%TEST_TRIMESHSURFACEAREA  Test case for the file trimeshSurfaceArea
%
%   Test case for the file trimeshSurfaceArea

%   Example
%   test_trimeshSurfaceArea
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

function test_Octahedron(testCase) %#ok<*DEFNU>

[v, e, f] = createOctahedron(); %#ok<ASGLU>
area = trimeshSurfaceArea(v, f);

a = sqrt(2);
exp = 2 * sqrt(3) * a * a;

testCase.assertEqual(exp, area, 'AbsTol', .1);
