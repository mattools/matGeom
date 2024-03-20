function tests = test_triangulateMesh
% Test suite for the file triangulateMesh.
%
%   Test suite for the file triangulateMesh
%
%   Example
%   test_triangulateMesh
%
%   See also
%     triangulateMesh

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2024-02-16,    using Matlab 23.2.0.2459199 (R2023b) Update 5
% Copyright 2024 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_VF_to_VF(testCase) %#ok<*DEFNU>
% Test call of function without argument.

[v, f] = createCube;
[v2, f2] = triangulateMesh(v, f);

assertEqual(testCase, size(v2), size(v));
assertEqual(testCase, size(f2, 1), 6*2);


function test_mesh_to_mesh(testCase) %#ok<*DEFNU>
% Test call of function without argument.

mesh = createCube;
mesh2 = triangulateMesh(mesh);

assertTrue(testCase, isstruct(mesh2));
assertTrue(testCase, isfield(mesh2, 'vertices'));
assertTrue(testCase, isfield(mesh2, 'faces'));
assertEqual(testCase, size(mesh2.vertices), size(mesh.vertices));
assertEqual(testCase, size(mesh2.faces, 1), 6*2);


function test_FacesAsCellArray(testCase) %#ok<*DEFNU>
% Test call of function without argument.

mesh = createSoccerBall;
mesh2 = triangulateMesh(mesh);

assertTrue(testCase, isstruct(mesh2));
assertTrue(testCase, isfield(mesh2, 'vertices'));
assertTrue(testCase, isfield(mesh2, 'faces'));
assertEqual(testCase, size(mesh2.vertices), size(mesh.vertices));
assertEqual(testCase, size(mesh2.faces, 1), 116); % 12*3 + 20*4




