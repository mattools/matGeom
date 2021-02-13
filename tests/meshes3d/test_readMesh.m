function tests = test_readMesh
% Test suite for the file readMesh.
%
%   Test suite for the file readMesh
%
%   Example
%   test_readMesh
%
%   See also
%     readMesh

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2021-01-25,    using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2021 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);


function test_off_VF(testCase) %#ok<*DEFNU>

[v, f] = readMesh('mushroom.off');

assertEqual(testCase, 226, size(v, 1));
assertEqual(testCase, 448, size(f, 1));


function test_off_single(testCase) %#ok<*DEFNU>

mesh = readMesh('mushroom.off');

assertTrue(testCase, isstruct(mesh));
assertTrue(testCase, isfield(mesh, 'vertices'));
assertTrue(testCase, isfield(mesh, 'faces'));

assertEqual(testCase, 226, size(mesh.vertices, 1));
assertEqual(testCase, 448, size(mesh.faces, 1));


function test_ply_VF(testCase) %#ok<*DEFNU>

[v, f] = readMesh('apple.ply');

assertEqual(testCase, 867, size(v, 1));
assertEqual(testCase, 1704, size(f, 1));


function test_ply_single(testCase) %#ok<*DEFNU>

mesh = readMesh('apple.ply');

assertTrue(testCase, isstruct(mesh));
assertTrue(testCase, isfield(mesh, 'vertices'));
assertTrue(testCase, isfield(mesh, 'faces'));

assertEqual(testCase, 867, size(mesh.vertices, 1));
assertEqual(testCase, 1704, size(mesh.faces, 1));

