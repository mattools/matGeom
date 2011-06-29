function test_suite = testSph2cart2(varargin) %#ok<STOUT>
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

initTestSuite;

function testNorthPole %#ok<*DEFNU>

[x y z] = sph2cart2(0, 0, 1);
assertElementsAlmostEqual(0, x);
assertElementsAlmostEqual(0, y);
assertElementsAlmostEqual(1, z);

function testPointOx

[x y z] = sph2cart2(pi/2, 0, 10);
assertElementsAlmostEqual(10, x);
assertElementsAlmostEqual(0, y);
assertElementsAlmostEqual(0, z);

function testPointXY

[x y z] = sph2cart2(pi/2, pi/4, 10*sqrt(2));
assertElementsAlmostEqual(10, x);
assertElementsAlmostEqual(10, y);
assertElementsAlmostEqual(0, z);



function testSingleInput

[x y z] = sph2cart2([0, 0, 1]);
assertElementsAlmostEqual(0, x);
assertElementsAlmostEqual(0, y);
assertElementsAlmostEqual(1, z);

function testSingleOutput

res = sph2cart2([0, 0, 1]);
assertElementsAlmostEqual(0, res(1));
assertElementsAlmostEqual(0, res(2));
assertElementsAlmostEqual(1, res(3));


function testManyPoints

pts = [ ...
    0 0 10; ...
    pi/2 0 10; ...
    pi/2 pi/2 10; ...
    pi/2 3*pi/5 10; ...
    pi/3 7*pi/3 20; ...
    2*pi/3 7*pi/3 2];

[theta phi rho] = cart2sph2(pts);
pts2 = sph2cart2(theta, phi, rho);

assertElementsAlmostEqual(pts2, pts);
