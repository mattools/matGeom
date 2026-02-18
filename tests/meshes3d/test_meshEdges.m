function tests = test_meshEdges
% Test suite for the file meshEdges.
%
%   Test suite for the file meshEdges
%
%   Example
%   test_meshEdges
%
%   See also
%     meshEdges

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2026-02-18,    using Matlab 25.1.0.2973910 (R2025a) Update 1
% Copyright 2026 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Octahedron(testCase) %#ok<*DEFNU>
% Test call of function without argument.

[~, f] = createOctahedron;

e = meshEdges(f);

assertEqual(testCase, 12, size(e, 1));
assertEqual(testCase, 2, size(e, 2));

function test_Cube(testCase) %#ok<*DEFNU>
% Test call of function without argument.

[~, f] = createCube;

e = meshEdges(f);

assertEqual(testCase, 12, size(e, 1));
assertEqual(testCase, 2, size(e, 2));


function test_CubeOctahedron(testCase) %#ok<*DEFNU>
% Test call of function without argument.

[~, f] = createCubeOctahedron;

e = meshEdges(f);

assertEqual(testCase, 24, size(e, 1));
assertEqual(testCase, 2, size(e, 2));

