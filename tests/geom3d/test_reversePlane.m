function test_suite = test_reversePlane
%TEST_REVERSEPLANE  Test case for the file reversePlane
%
%   Test case for the file reversePlane

%   Example
%   test_reversePlane
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2017-02-03,    using Matlab 9.1.0.441655 (R2016b)
% Copyright 2017 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>

plane = [0 0 0 1 0 0 0 1 0];

revPlane = reversePlane(plane);
normal = planeNormal(revPlane);

exp = [0 0 -1];
testCase.assertEqual(exp, normal, 'AbsTol', .01);

