function test_suite = test_subdivideMesh
%TEST_SUBDIVIDEMESH  Test case for the file subdivideMesh
%
%   Test case for the file subdivideMesh

%   Example
%   test_subdivideMesh
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-08-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);


function test_Subdivide_N2(testCase) %#ok<*DEFNU>
% subdivide by a factor of 2

[v, f] = createSimpleMesh();
[v2, f2] = subdivideMesh(v, f, 2);

testCase.assertEqual(9, size(v2, 1));
nFaces = size(f2, 1);
testCase.assertEqual(8, nFaces);

function test_Subdivide_N3(testCase)
% subdivide by a factor of 3

[v, f] = createSimpleMesh();
[v2, f2] = subdivideMesh(v, f, 3);

testCase.assertEqual(16, size(v2, 1));
nFaces = size(f2, 1);
testCase.assertEqual(18, nFaces);

function test_Subdivide_N4(testCase)
% subdivide by a factor of 4

[v, f] = createSimpleMesh();
[v2, f2] = subdivideMesh(v, f, 4);

testCase.assertEqual(25, size(v2, 1));
nFaces = size(f2, 1);
testCase.assertEqual(32, nFaces);


function [v, f] = createSimpleMesh()
% create simple mesh formed by two triangle faces
v = [20 26;10 20;20 14;30 20];
f = [1 2 3;1 3 4];
