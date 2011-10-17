function test_suite = test_createScaling(varargin) %#ok<STOUT>
%TESTCREATESCALING  One-line description here, please.
%   output = testCreateScaling(input)
%
%   Example
%   testCreateScaling
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

function testCentered %#ok<*DEFNU>

% same coeff for both x and y
trans = createScaling(2);
assertElementsAlmostEqual(trans, [2 0 0;0 2 0;0 0 1]);

% different factor
trans = createScaling(2, 3);
assertElementsAlmostEqual(trans, [2 0 0;0 3 0;0 0 1]);

% different factor
trans = createScaling([2 3]);
assertElementsAlmostEqual(trans, [2 0 0;0 3 0;0 0 1]);

function testShifted

sx = 2;
sy = 3;
p0 = [4 5];

trans1 = createScaling(p0, sx, sy);
t1 = createTranslation(-p0);
sca = createScaling(sx, sy);
t2 = createTranslation(p0);
trans2 = t2*sca*t1;

assertElementsAlmostEqual(trans1, trans2);
