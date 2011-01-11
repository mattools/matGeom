function test_suite = testPolygonNormalAngle(varargin)
%TESTPOLYGONNORMALANGLE  One-line description here, please.
%   output = testPolygonNormalAngle(input)
%
%   Example
%   testPolygonNormalAngle
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.
% Licensed under the terms of the LGPL, see the file "license.txt"

initTestSuite;

function testPolygon1
% test with a convex polygon 

poly = [1 1;2 1;3 2;2 2;1 2];

eps = 1e-14;

assertElementsAlmostEqual(polygonNormalAngle(poly, 1), pi/2, 'absolute', eps);
assertElementsAlmostEqual(polygonNormalAngle(poly, 2), pi/4, 'absolute', eps);
assertElementsAlmostEqual(polygonNormalAngle(poly, 3), 3*pi/4, 'absolute', eps);
assertElementsAlmostEqual(polygonNormalAngle(poly, 4), 0, 'absolute', eps);
assertElementsAlmostEqual(polygonNormalAngle(poly, 5), pi/2, 'absolute', eps);


function testPolygon2
% test with a non-convex polygon

poly = [0 0;0 1;-1 1;0 -1;1 0];
eps = 1e-14;

assertElementsAlmostEqual(polygonNormalAngle(poly, 1), -pi/2, 'absolute', eps);
assertElementsAlmostEqual(polygonNormalAngle(poly, 2), pi/2, 'absolute', eps);
assertElementsAlmostEqual(polygonNormalAngle(poly, 3), pi/2+atan(.5), 'absolute', eps);
assertElementsAlmostEqual(polygonNormalAngle(poly, 4), pi/4+atan(2), 'absolute', eps);
assertElementsAlmostEqual(polygonNormalAngle(poly, 5), 3*pi/4, 'absolute', eps);


function testPolygon3
% test with polygon oriented Clockwise instead of Counter-Clockwise

% use a single square
poly = [0 0;0 1;1 1;1 0];
eps = 1e-14;

assertElementsAlmostEqual(polygonNormalAngle(poly, 1), -pi/2, 'absolute', eps);
assertElementsAlmostEqual(polygonNormalAngle(poly, 2), -pi/2, 'absolute', eps);
assertElementsAlmostEqual(polygonNormalAngle(poly, 3), -pi/2, 'absolute', eps);
assertElementsAlmostEqual(polygonNormalAngle(poly, 4), -pi/2, 'absolute', eps);
assertElementsAlmostEqual(sum(polygonNormalAngle(poly, 1:4)), -2*pi, 'absolute', eps);
