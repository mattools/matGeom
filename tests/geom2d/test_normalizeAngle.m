function test_suite = test_normalizeAngle
%  One-line description here, please.
%   output = testNormalizeAngle(input)
%
%   Example
%   testAngle2Points
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testDefault(testCase) %#ok<*DEFNU>

theta = pi/2;
testCase.assertEqual(theta, normalizeAngle(theta), 'AbsTol', .01);

theta = pi;
testCase.assertEqual(theta, normalizeAngle(theta), 'AbsTol', .01);

theta = 3*pi/2;
testCase.assertEqual(theta, normalizeAngle(theta), 'AbsTol', .01);

function testPiCentered(testCase)

theta = pi/2;
testCase.assertEqual(theta, normalizeAngle(theta, pi), 'AbsTol', .01);

theta = pi;
testCase.assertEqual(theta, normalizeAngle(theta, pi), 'AbsTol', .01);

theta = 3*pi/2;
testCase.assertEqual(theta, normalizeAngle(theta, pi), 'AbsTol', .01);


function testVector(testCase)

theta = linspace(0, 2*pi-.1, 100);
testCase.assertEqual(theta, normalizeAngle(theta), 'AbsTol', .01);


function testZeroCentered(testCase)

theta = 0;
testCase.assertEqual(theta, normalizeAngle(theta, 0), 'AbsTol', .01);

theta = pi/2;
testCase.assertEqual(theta, normalizeAngle(theta, 0), 'AbsTol', .01);

theta = -pi;
testCase.assertEqual(theta, normalizeAngle(theta, 0), 'AbsTol', .01);

theta = 7*pi/2;
testCase.assertEqual(-pi/2, normalizeAngle(theta, 0), 'AbsTol', .01);

function testVectorZeroCentered(testCase)

theta = linspace(-pi+.1, pi-.1, 100);
testCase.assertEqual(theta, normalizeAngle(theta, 0), 'AbsTol', .01);


