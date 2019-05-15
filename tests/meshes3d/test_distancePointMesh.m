function test_suite = test_distancePointMesh
%TEST_DISTANCEPOINTTRIMESH  One-line description here, please.
%
%   output = test_distancePointMesh(input)
%
%   Example
%   test_distancePointMesh
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-03-08,    using Matlab 9.3.0.713579 (R2017b)
% Copyright 2018 INRA - Cepia Software Platform.

% corps du fichier contenant la suite de tests

% testSuite = buildFunctionHandleTestSuite(localfunctions);
test_suite = functiontests(localfunctions);


function testTetraedron(testCase) %#ok<*DEFNU>

[v, f] = createOctahedron;

testCase.assertEqual(1, distancePointMesh([2 0 0], v, f), .0001);
testCase.assertEqual(1, distancePointMesh([0 2 0], v, f), .0001);
testCase.assertEqual(1, distancePointMesh([0 0 2], v, f), .0001);
testCase.assertEqual(1, distancePointMesh([-2 0 0], v, f), .0001);
testCase.assertEqual(1, distancePointMesh([0 -2 0], v, f), .0001);
testCase.assertEqual(1, distancePointMesh([0 0 -2], v, f), .0001);

exp = sqrt(2) / 2;
testCase.assertEqual(exp, distancePointMesh([1 1 0], v, f), .0001);
testCase.assertEqual(exp, distancePointMesh([1 0 1], v, f), .0001);
testCase.assertEqual(exp, distancePointMesh([0 1 1], v, f), .0001);


function testSingleTriangle(testCase) 

v = [10 10 10 ; 20 10 10 ; 10 20 10];
f = [1 2 3];

% around lower left corner
testCase.assertEqual(2, distancePointMesh([ 10  8 10 ], v, f), .0001);
testCase.assertEqual(2, distancePointMesh([  8 10 10 ], v, f), .0001);
testCase.assertEqual(2, distancePointMesh([ 12  8 10 ], v, f), .0001);
testCase.assertEqual(2, distancePointMesh([  8 12 10 ], v, f), .0001);
testCase.assertEqual(2*sqrt(2), distancePointMesh([  8  8 10 ], v, f), .0001);
% more around lower left corner
testCase.assertEqual(sqrt(5), distancePointMesh([  8  9 10 ], v, f), .0001);
testCase.assertEqual(sqrt(5), distancePointMesh([  9  8 10 ], v, f), .0001);

% around right corner
testCase.assertEqual(2, distancePointMesh([ 20  8 10 ], v, f), .0001);
testCase.assertEqual(2, distancePointMesh([ 18  8 10 ], v, f), .0001);
testCase.assertEqual(2, distancePointMesh([ 22 10 10 ], v, f), .0001);
testCase.assertEqual(2*sqrt(2), distancePointMesh([ 22  8 10 ], v, f), .0001);
testCase.assertEqual(sqrt(5), distancePointMesh([ 22  9 10 ], v, f), .0001);

% around top left corner
testCase.assertEqual(sqrt(5), distancePointMesh([  9 22 10 ], v, f), .0001);


function test_ortho_diag(testCase)
% bug found when updating distancePointMesh function
%
% mesh is a single face, query point is above the largest side of the
% triangle. 
v = [0 0 0; 10 0 0; 0 10 0];
f = [1 2 3];
point111 = [11 1 0];
d = distancePointMesh(point111, v, f, 'algorithm', 'vectorized');
testCase.assertEqual(sqrt(2), d, 0.0001);
