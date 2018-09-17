function test_suite = test_sph2cart2
%TESTSPH2CART2  One-line description here, please.
%
%   output = testSph2cart2(input)
%
%   Example
%   testSph2cart2
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

[x, y, z] = sph2cart2(0, 0, 1);
testCase.assertEqual(0, x, 'AbsTol', .01);
testCase.assertEqual(0, y, 'AbsTol', .01);
testCase.assertEqual(1, z, 'AbsTol', .01);

function testPointOx(testCase)

[x, y, z] = sph2cart2(pi/2, 0, 10);
testCase.assertEqual(10, x, 'AbsTol', .01);
testCase.assertEqual(0, y, 'AbsTol', .01);
testCase.assertEqual(0, z, 'AbsTol', .01);

function testPointXY(testCase)

[x, y, z] = sph2cart2(pi/2, pi/4, 10*sqrt(2));
testCase.assertEqual(10, x, 'AbsTol', .01);
testCase.assertEqual(10, y, 'AbsTol', .01);
testCase.assertEqual(0, z, 'AbsTol', .01);


function testSingleInput(testCase)

[x, y, z] = sph2cart2([0, 0, 1]);
testCase.assertEqual(0, x, 'AbsTol', .01);
testCase.assertEqual(0, y, 'AbsTol', .01);
testCase.assertEqual(1, z, 'AbsTol', .01);

function testSingleOutput(testCase)

res = sph2cart2([0, 0, 1]);
testCase.assertEqual(0, res(1), 'AbsTol', .01);
testCase.assertEqual(0, res(2), 'AbsTol', .01);
testCase.assertEqual(1, res(3), 'AbsTol', .01);


function testManyPoints(testCase)

pts = [ ...
    0 0 10; ...
    pi/2 0 10; ...
    pi/2 pi/2 10; ...
    pi/2 3*pi/5 10; ...
    pi/3 7*pi/3 20; ...
    2*pi/3 7*pi/3 2];

[theta, phi, rho] = cart2sph2(pts);
pts2 = sph2cart2(theta, phi, rho);

testCase.assertEqual(pts2, pts, 'AbsTol', .01);
