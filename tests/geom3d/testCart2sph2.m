function test_suite = testCart2sph2(varargin) %#ok<STOUT>
%TESTCART2SPH2  One-line description here, please.
%
%   output = testCart2sph2(input)
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

initTestSuite;

function testNorthPole %#ok<*DEFNU>

[theta phi rho] = cart2sph2(0, 0, 1);
assertElementsAlmostEqual(0, theta);
assertElementsAlmostEqual(0, phi);
assertElementsAlmostEqual(1, rho);

function testPointOx

[theta phi rho] = cart2sph2(10, 0, 0);
assertElementsAlmostEqual(pi/2, theta);
assertElementsAlmostEqual(0, phi);
assertElementsAlmostEqual(10, rho);

function testPointXY

[theta phi rho] = cart2sph2(10, 10, 0);
assertElementsAlmostEqual(pi/2, theta);
assertElementsAlmostEqual(pi/4, phi);
assertElementsAlmostEqual(10*sqrt(2), rho);



function testSingleInput

[theta phi rho] = cart2sph2([0, 0, 1]);
assertElementsAlmostEqual(0, theta);
assertElementsAlmostEqual(0, phi);
assertElementsAlmostEqual(1, rho);

function testSingleOutput

res = cart2sph2([0, 0, 1]);
assertElementsAlmostEqual(0, res(1));
assertElementsAlmostEqual(0, res(2));
assertElementsAlmostEqual(1, res(3));


function testManyPoints

pts = [10 0 0;0 10 0;10 10 0;10 0 10;0 10 10;10 10 10];

[theta phi rho] = cart2sph2(pts);
pts2 = sph2cart2(theta, phi, rho);

assertElementsAlmostEqual(pts2, pts);
