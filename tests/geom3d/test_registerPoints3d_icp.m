function tests = test_registerPoints3d_icp
% Test suite for the file registerPoints3d_icp.
%
%   Test suite for the file registerPoints3d_icp
%
%   Example
%   test_registerPoints3d_icp
%
%   See also
%     registerPoints3d_icp

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2024-02-15,    using Matlab 23.2.0.2459199 (R2023b) Update 5
% Copyright 2024 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Default(testCase) %#ok<*DEFNU>
% Test call of function without argument.

[v, ~] = readMesh('bunny_F5k.ply');

% initialize transform
rot = eulerAnglesToRotation3d([30 20 10]);
tra = createTranslation3d([4 3 2]);
transfo0 = tra * rot;
v2 = transformPoint3d(v, transfo0);

transfo = registerPoints3d_icp(v, v2, ...
    'Matching', 'Delaunay', ...
    'Minimize', 'Point');

assertEqual(testCase, size(transfo, 1), 4);
assertEqual(testCase, size(transfo, 2), 4);


function test_Matching_Delaunay(testCase) %#ok<*DEFNU>
% Test call of function without argument.

[v, ~] = readMesh('bunny_F5k.ply');

% initialize transform
rot = eulerAnglesToRotation3d([30 20 10]);
tra = createTranslation3d([4 3 2]);
transfo0 = tra * rot;
v2 = transformPoint3d(v, transfo0);

transfo = registerPoints3d_icp(v, v2, ...
    'Matching', 'Delaunay');

assertEqual(testCase, size(transfo, 1), 4);
assertEqual(testCase, size(transfo, 2), 4);



function test_Matching_kDTree(testCase) %#ok<*DEFNU>
% Test call of function without argument.

[v, ~] = readMesh('bunny_F5k.ply');

% initialize transform
rot = eulerAnglesToRotation3d([30 20 10]);
tra = createTranslation3d([4 3 2]);
transfo0 = tra * rot;
v2 = transformPoint3d(v, transfo0);

transfo = registerPoints3d_icp(v, v2, ...
    'Matching', 'kDTree');

assertEqual(testCase, size(transfo, 1), 4);
assertEqual(testCase, size(transfo, 2), 4);


function test_Minimize_Plane(testCase) %#ok<*DEFNU>
% Test call of function without argument.

[v, ~] = readMesh('bunny_F5k.ply');

% initialize transform
rot = eulerAnglesToRotation3d([30 20 10]);
tra = createTranslation3d([4 3 2]);
transfo0 = tra * rot;
v2 = transformPoint3d(v, transfo0);

transfo = registerPoints3d_icp(v, v2, ...
    'Minimize', 'Plane');

assertEqual(testCase, size(transfo, 1), 4);
assertEqual(testCase, size(transfo, 2), 4);

