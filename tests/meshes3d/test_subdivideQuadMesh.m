function tests = test_subdivideQuadMesh
% Test suite for the file subdivideQuadMesh.
%
%   Test suite for the file subdivideQuadMesh
%
%   Example
%   test_subdivideQuadMesh
%
%   See also
%     subdivideQuadMesh

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2026-02-18,    using Matlab 25.1.0.2973910 (R2025a) Update 1
% Copyright 2026 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Cube_Sub2(testCase) %#ok<*DEFNU>
% Test call of function without argument.

[v, f] = createCube;
[v2, f2] = subdivideQuadMesh(v, f, 2);

nv2 = 8 + 12 + 6;
nf2 = 6 * 4;
assertEqual(testCase, size(v2, 1), nv2);
assertEqual(testCase, size(f2, 1), nf2);


function test_Cube_Sub3(testCase) %#ok<*DEFNU>
% Test call of function without argument.

[v, f] = createCube;
[v2, f2] = subdivideQuadMesh(v, f, 3);

nv2 = 8 + 12 * 2 + 6 * 4;
nf2 = 6 * 9;
assertEqual(testCase, size(v2, 1), nv2);
assertEqual(testCase, size(f2, 1), nf2);
