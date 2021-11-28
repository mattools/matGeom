function tests = test_meshCurvatures
% Test suite for the file meshCurvatures.
%
%   Test suite for the file meshCurvatures
%
%   Example
%   test_meshCurvatures
%
%   See also
%     meshCurvatures

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2021-09-29,    using Matlab 9.9.0.1570001 (R2020b) Update 4
% Copyright 2021 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_SimpleCall(testCase) %#ok<*DEFNU>
% Check output of two curvatures.

% create a simplified mesh
[v, f] = torusMesh('nPhi', 12, 'nTheta', 12);
f = triangulateFaces(f);

options = {'Verbose', false, 'ShowProgress', false};
[c1, c2] = meshCurvatures(v, f, options{:});

nv = size(v, 1);
assertEqual(testCase, size(c1, 1), nv);
assertEqual(testCase, size(c2, 1), nv);


function test_OutputDirectionVectors(testCase) %#ok<*DEFNU>
% Check output of two curvatures.

% create a simplified mesh
[v, f] = torusMesh('nPhi', 12, 'nTheta', 12);
f = triangulateFaces(f);

options = {'Verbose', false, 'ShowProgress', false};
[c1, c2, v1, v2] = meshCurvatures(v, f, options{:});

nv = size(v, 1);
assertEqual(testCase, size(c1, 1), nv);
assertEqual(testCase, size(c2, 1), nv);
assertEqual(testCase, size(v1, 1), nv);
assertEqual(testCase, size(v1, 2), 3);
assertEqual(testCase, size(v2, 1), nv);
assertEqual(testCase, size(v2, 2), 3);


function test_OutputAll(testCase) %#ok<*DEFNU>
% Check output of two curvatures.

% create a simplified mesh
[v, f] = torusMesh('nPhi', 12, 'nTheta', 12);
f = triangulateFaces(f);

options = {'Verbose', false, 'ShowProgress', false};
[c1, c2, v1, v2, H, K, N] = meshCurvatures(v, f, options{:});

nv = size(v, 1);
assertEqual(testCase, size(c1, 1), nv);
assertEqual(testCase, size(c2, 1), nv);
assertEqual(testCase, size(v1, 1), nv);
assertEqual(testCase, size(v1, 2), 3);
assertEqual(testCase, size(v2, 1), nv);
assertEqual(testCase, size(v2, 2), 3);
assertEqual(testCase, size(H, 1), nv);
assertEqual(testCase, size(K, 1), nv);
assertEqual(testCase, size(N, 1), nv);
assertEqual(testCase, size(N, 2), 3);

