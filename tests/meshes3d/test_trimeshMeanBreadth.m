function test_suite = test_trimeshMeanBreadth
%TEST_TRIMESHMEANBREADTH  Test case for the file trimeshMeanBreadth
%
%   Test case for the file trimeshMeanBreadth

%   Example
%   test_trimeshMeanBreadth
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
f2 = triangulateFaces(f);

exp = 3/2;
mb = trimeshMeanBreadth(v, f2);
testCase.assertEqual(exp, mb, 'AbsTol', .01);

function test_Octagon(testCase) %#ok<*DEFNU>

[v, f] = createOctahedron;

exp = 1.175 * sqrt(2);
mb = trimeshMeanBreadth(v, f);
testCase.assertEqual(exp, mb, 'AbsTol', .01);

% function test_DiscretizedBall(testCase) %#ok<*DEFNU>
% 
% radius = 40;
% [v, f] = sphereMesh([0 0 0 radius], 'nTheta', 30, 'nPhi', 60);
% f2 = triangulateFaces(f);
% mb = trimeshMeanBreadth(v, f2);
% 
% exp = 2 * radius;
% testCase.assertEqual(exp, mb, 'AbsTol', .1);
