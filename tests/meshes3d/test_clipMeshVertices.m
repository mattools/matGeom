function test_suite = test_clipMeshVertices
%TEST_TRIMESHMEANBREADTH  Test case for the file clipMeshVertices
%
%   Test case for the file clipMeshVertices

%   Example
%   test_clipMeshVertices
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-10-17,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function test_Cube(testCase) %#ok<*DEFNU>

[v, f] = createCube;
f = triangulateFaces(f);
box = [.5 2 -2 2 -2 2];

[v2, f2] = clipMeshVertices(v, f, box);

% expect two faces and four vertices
testCase.assertEqual(4, size(v2, 1));
testCase.assertEqual(2, size(f2, 1));

function test_Cube_trimMesh(testCase)

[v, f] = createCube;
f = triangulateFaces(f);
box = [.5 2 .5 2 -2 2];

[v2, f2] = clipMeshVertices(v, f, box, 'trimMesh', true);

% expect two faces and four vertices
testCase.assertEqual(0, size(v2, 1));
testCase.assertEqual(0, size(f2, 1));

