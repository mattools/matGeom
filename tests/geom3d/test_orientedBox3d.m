function test_suite = test_orientedBox3d
%TEST_ORIENTEDBOX3D  Test case for the file orientedBox3d
%
%   Test case for the file orientedBox3d
%
%   Example
%   test_orientedBox3d
%
%   See also
%   orientedBox3d
%
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-07-26,    using Matlab 9.4.0.813654 (R2018a)
% Copyright 2018 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function test_CenteredDodecahedron(testCase) %#ok<*DEFNU>
% Test call of function without argument

mesh = createDodecahedron;
pts = mesh.vertices;

box3d = orientedBox3d(pts);

testCase.assertEqual([0 0 0], box3d(1:3), 'AbsTol', .01);

function test_TranslatedDodecahedron(testCase) %#ok<*DEFNU>

mesh = createDodecahedron;
pts = mesh.vertices;

tra = createTranslation3d([5 4 3]);
pts = transformPoint3d(pts, tra);

box3d = orientedBox3d(pts);

testCase.assertEqual([5 4 3], box3d(1:3), 'AbsTol', .01);

