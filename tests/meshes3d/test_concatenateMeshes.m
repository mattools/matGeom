function tests = test_concatenateMeshes
% Test suite for the file concatenateMeshes.
%
%   Test suite for the file concatenateMeshes
%
%   Example
%   test_concatenateMeshes
%
%   See also
%     concatenateMeshes

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2024-11-12,    using Matlab 24.1.0.2653294 (R2024a) Update 5
% Copyright 2024 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_inputVertexFaces(testCase) %#ok<*DEFNU>
% Test call of function without argument.

[v1, f1] = createOctahedron();
[v2, f2] = createOctahedron();
v2 = v2 + [2 2 0];

[vRes, fRes] = concatenateMeshes(v1, f1, v2, f2);

assertEqual(testCase, size(vRes,1), 12);
assertEqual(testCase, size(fRes,1), 16);


function test_inputStruct(testCase) %#ok<*DEFNU>
% Test call of function without argument.

mesh1 = createOctahedron();
mesh2 = createOctahedron();
mesh2.vertices = mesh2.vertices + [2 2 0];

res = concatenateMeshes(mesh1, mesh2);

assertEqual(testCase, size(res.vertices,1), 12);
assertEqual(testCase, size(res.faces,1), 16);

