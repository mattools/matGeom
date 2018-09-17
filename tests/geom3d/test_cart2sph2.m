function test_suite = test_cart2sph2
%TEST_CART2SPH2  One-line description here, please.
%
%   output = test_cart2sph2(input)
%
%   Example
%   testCart2sph2
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

[theta, phi, rho] = cart2sph2(0, 0, 1);
testCase.assertEqual(0, theta);
testCase.assertEqual(0, phi);
testCase.assertEqual(1, rho);

function testPointOx(testCase)

[theta, phi, rho] = cart2sph2(10, 0, 0);
testCase.assertEqual(pi/2, theta);
testCase.assertEqual(0, phi);
testCase.assertEqual(10, rho);

function testPointXY(testCase)

[theta, phi, rho] = cart2sph2(10, 10, 0);
testCase.assertEqual(pi/2, theta);
testCase.assertEqual(pi/4, phi);
testCase.assertEqual(10*sqrt(2), rho);

function testSingleInput(testCase)

[theta, phi, rho] = cart2sph2([0, 0, 1]);
testCase.assertEqual(0, theta);
testCase.assertEqual(0, phi);
testCase.assertEqual(1, rho);

function testSingleOutput(testCase)

res = cart2sph2([0, 0, 1]);
testCase.assertEqual(0, res(1));
testCase.assertEqual(0, res(2));
testCase.assertEqual(1, res(3));


function testManyPoints(testCase)

pts = [10 0 0;0 10 0;10 10 0;10 0 10;0 10 10;10 10 10];

[theta, phi, rho] = cart2sph2(pts);
pts2 = sph2cart2(theta, phi, rho);

testCase.assertEqual(pts2, pts, 'AbsTol', .0001);
