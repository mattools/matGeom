function test_suite = test_cart2sph2d
%TEST_CART2SPH2D  One-line description here, please.
%
%   output = test_cart2sph2d(input)
%
%   Example
%   testCart2sph2d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-29,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testNorthPole(testCase) %#ok<*DEFNU>

[theta, phi, rho] = cart2sph2d(0, 0, 1);
testCase.assertEqual(0, theta, 'AbsTol', .001);
testCase.assertEqual(0, phi, 'AbsTol', .001);
testCase.assertEqual(1, rho, 'AbsTol', .001);

function testPointOx(testCase)

[theta, phi, rho] = cart2sph2d(10, 0, 0);
testCase.assertEqual(90, theta, 'AbsTol', .001);
testCase.assertEqual(0, phi, 'AbsTol', .001);
testCase.assertEqual(10, rho, 'AbsTol', .001);

function testPointXY(testCase)

[theta, phi, rho] = cart2sph2d(10, 10, 0);
testCase.assertEqual(90, theta, 'AbsTol', .001);
testCase.assertEqual(45, phi, 'AbsTol', .001, 'AbsTol', .001);
testCase.assertEqual(10*sqrt(2), rho);


function testSingleInput(testCase)

[theta, phi, rho] = cart2sph2d([0, 0, 1]);
testCase.assertEqual(0, theta, 'AbsTol', .001);
testCase.assertEqual(0, phi, 'AbsTol', .001);
testCase.assertEqual(1, rho, 'AbsTol', .001);

function testSingleOutput(testCase)

res = cart2sph2d([0, 0, 1]);
testCase.assertEqual(0, res(1), 'AbsTol', .001);
testCase.assertEqual(0, res(2), 'AbsTol', .001);
testCase.assertEqual(1, res(3), 'AbsTol', .001);


function testManyPoints(testCase)

pts = [10 0 0;0 10 0;10 10 0;10 0 10;0 10 10;10 10 10];

[theta, phi, rho] = cart2sph2d(pts);
pts2 = sph2cart2d(theta, phi, rho);

testCase.assertEqual(pts2, pts, 'AbsTol', .001);
