function tests = test_registerPoints3d_affine
% Test suite for the file registerPoints3d_affine.
%
%   Test suite for the file registerPoints3d_affine
%
%   Example
%   test_registerPoints3d_affine
%
%   See also
%     registerPoints3d_affine

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2024-07-11,    using Matlab 24.1.0.2628055 (R2024a) Update 4
% Copyright 2024 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_motion(testCase) %#ok<*DEFNU>
% Test call of function without argument.

% read 3D data points
[v, ~] = readMesh('bunny_F5k.ply');

% initialize transform
rot = eulerAnglesToRotation3d([5 4 3]);
tra = createTranslation3d([0.8 0.6 0.4]);
% sca1 = createScaling3d([0.96 1.03 0.98]);
% sca2 = createScaling3d([1.01 0.97 1.02]);
% transfo0 = tra * sca2 * rot * sca1;
transfo0 = tra * rot;
v2 = transformPoint3d(v, transfo0);

transfo = registerPoints3d_affine(v, v2);

assertEqual(testCase, size(transfo, 1), 4);
assertEqual(testCase, size(transfo, 2), 4);
assertEqual(testCase, transfo, transfo0, 'AbsTol', 0.01);


function test_affine(testCase) %#ok<*DEFNU>
% Test call of function without argument.

% read 3D data points
[v, ~] = readMesh('bunny_F5k.ply');

% initialize transform
rot = eulerAnglesToRotation3d([5 4 3]);
tra = createTranslation3d([0.8 0.6 0.4]);
sca1 = createScaling3d([0.97 1.02 0.99]);
sca2 = createScaling3d([1.01 0.98 1.02]);
transfo0 = tra * sca2 * rot * sca1;
v2 = transformPoint3d(v, transfo0);

transfo = registerPoints3d_affine(v, v2);

assertEqual(testCase, size(transfo, 1), 4);
assertEqual(testCase, size(transfo, 2), 4);
assertEqual(testCase, transfo, transfo0, 'AbsTol', 0.01);
