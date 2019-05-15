function test_suite = test_distancePointTriangle3d(varargin)
%TEST_DISTANCEPOINTTRIANGLE3D  One-line description here, please.
%
%   output = test_distancePointTriangle3d(input)
%
%   Example
%   test_distancePointTriangle3d
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-03-08,    using Matlab 9.3.0.713579 (R2017b)
% Copyright 2018 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function testHorizontalTriangle(testCase) %#ok<*DEFNU>
% test a triangle whose all vertices have same z-coordinate

tri = [10 10 10 ; 20 10 10 ; 10 20 10];

% around lower left corner
testCase.assertEqual(2, distancePointTriangle3d([ 10  8 10 ], tri), .0001);
testCase.assertEqual(2, distancePointTriangle3d([  8 10 10 ], tri), .0001);
testCase.assertEqual(2, distancePointTriangle3d([ 12  8 10 ], tri), .0001);
testCase.assertEqual(2, distancePointTriangle3d([  8 12 10 ], tri), .0001);
testCase.assertEqual(2*sqrt(2), distancePointTriangle3d([  8  8 10 ], tri), .0001);

% around right corner
testCase.assertEqual(2, distancePointTriangle3d([ 20  8 10 ], tri), .0001);
testCase.assertEqual(2, distancePointTriangle3d([ 18  8 10 ], tri), .0001);
testCase.assertEqual(2, distancePointTriangle3d([ 22 10 10 ], tri), .0001);
testCase.assertEqual(2*sqrt(2), distancePointTriangle3d([ 22  8 10 ], tri), .0001);

% around top corner
testCase.assertEqual(2, distancePointTriangle3d([  8 20 10 ], tri), .0001);
testCase.assertEqual(2, distancePointTriangle3d([  8 18 10 ], tri), .0001);
testCase.assertEqual(2, distancePointTriangle3d([ 10 22 10 ], tri), .0001);
testCase.assertEqual(2*sqrt(2), distancePointTriangle3d([ 8 22 10 ], tri), .0001);
