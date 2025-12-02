function tests = test_isPointInMesh
% Test suite for the file isPointInMesh.
%
%   Test suite for the file isPointInMesh
%
%   Example
%   test_isPointInMesh
%
%   See also
%     isPointInMesh

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2025-12-02,    using Matlab 25.1.0.2943329 (R2025a)
% Copyright 2025 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_cube(testCase) %#ok<*DEFNU>
% Test call of function without argument.

mesh = createCube();

assertTrue(testCase, isPointInMesh([0.1 0.1 0.1], mesh));
assertTrue(testCase, isPointInMesh([0.9 0.9 0.8], mesh));
assertFalse(testCase, isPointInMesh([-0.1  0.1  0.1], mesh));
assertFalse(testCase, isPointInMesh([ 1.1  0.1  0.1], mesh));
assertFalse(testCase, isPointInMesh([ 0.1 -0.1  0.1], mesh));
assertFalse(testCase, isPointInMesh([ 0.1  1.1  0.1], mesh));
assertFalse(testCase, isPointInMesh([ 0.1  0.1 -0.1], mesh));
assertFalse(testCase, isPointInMesh([ 0.1  0.1  1.1], mesh));

