function test_suite = test_readMesh_off
%TEST_MESHVOLUME  Test case for the file readMesh_off
%
%   Test case for the file readMesh_off
%
%   Example
%   test_readMesh_off
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-10-01,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function test_mushroom(testCase) %#ok<*DEFNU>
[v, f] = readMesh_off('mushroom.off');
assertEqual(testCase, 226, size(v, 1));
assertEqual(testCase, 448, size(f, 1));


function test_mushroom_singleOutput(testCase) %#ok<*DEFNU>

mesh = readMesh_off('mushroom.off');

assertTrue(testCase, isstruct(mesh));
assertTrue(testCase, isfield(mesh, 'vertices'));
assertTrue(testCase, isfield(mesh, 'faces'));

assertEqual(testCase, 226, size(mesh.vertices, 1));
assertEqual(testCase, 448, size(mesh.faces, 1));
