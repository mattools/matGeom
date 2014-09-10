function test_suite = test_normalizeAngle(varargin) %#ok<STOUT>
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

initTestSuite;

function testDefault %#ok<*DEFNU>

theta = pi/2;
assertElementsAlmostEqual(theta, normalizeAngle(theta));

theta = pi;
assertElementsAlmostEqual(theta, normalizeAngle(theta));

theta = 3*pi/2;
assertElementsAlmostEqual(theta, normalizeAngle(theta));

function testPiCentered

theta = pi/2;
assertElementsAlmostEqual(theta, normalizeAngle(theta, pi));

theta = pi;
assertElementsAlmostEqual(theta, normalizeAngle(theta, pi));

theta = 3*pi/2;
assertElementsAlmostEqual(theta, normalizeAngle(theta, pi));


function testVector

theta = linspace(0, 2*pi-.1, 100);
assertElementsAlmostEqual(theta, normalizeAngle(theta));


function testZeroCentered

theta = 0;
assertElementsAlmostEqual(theta, normalizeAngle(theta, 0));

theta = pi/2;
assertElementsAlmostEqual(theta, normalizeAngle(theta, 0));

theta = -pi;
assertElementsAlmostEqual(theta, normalizeAngle(theta, 0));

theta = 7*pi/2;
assertElementsAlmostEqual(-pi/2, normalizeAngle(theta, 0));

function testVectorZeroCentered

theta = linspace(-pi+.1, pi-.1, 100);
assertElementsAlmostEqual(theta, normalizeAngle(theta, 0));


