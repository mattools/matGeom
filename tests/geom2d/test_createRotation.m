function test_suite = test_createRotation %#ok<STOUT>
%TESTCREATEROTATION  One-line description here, please.
%   output = testCreateRotation(input)
%
%   Example
%   testCreateRotation
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

function testCreateCentered %#ok<*DEFNU>

trans = createRotation(0);
assertElementsAlmostEqual(trans, [1 0 0;0 1 0;0 0 1]);

trans = createRotation(pi/2);
assertElementsAlmostEqual(trans, [0 -1 0; 1 0 0; 0 0 1]);

trans = createRotation(pi);
assertElementsAlmostEqual(trans, [-1 0 0;0 -1 0;0 0 1]);

trans = createRotation(3*pi/2);
assertElementsAlmostEqual(trans, [0 1 0; -1 0 0; 0 0 1]);

function testCreateShifted

p0 = [3 5];
theta = pi/3;

trans1 = createRotation(p0, theta);
t1 = createTranslation(-p0);
rot = createRotation(theta);
t2 = createTranslation(p0);
trans2 = t2*rot*t1;

assertElementsAlmostEqual(trans1, trans2);
