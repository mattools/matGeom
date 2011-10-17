function test_suite = test_lineAngle(varargin) %#ok<STOUT>
%TESTLINEANGLE  One-line description here, please.
%   output = testLineAngle(input)
%
%   Example
%   testLineAngle
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

function testLineAngle1 %#ok<*DEFNU>
% test lineAngle with one parameter

% horizontal
line1 = createLine([2 3 1 0]);
assertElementsAlmostEqual(lineAngle(line1), 0);

line1 = createLine([2 3 0 1]);
assertElementsAlmostEqual(lineAngle(line1), pi/2);

line1 = createLine([2 3 1 1]);
assertElementsAlmostEqual(lineAngle(line1), pi/4);

line1 = createLine([2 3 5 -1]);
assertElementsAlmostEqual(lineAngle(line1), mod(atan2(-1, 5)+2*pi, 2*pi));

line1 = createLine([2 3 5000 -1000]);
assertElementsAlmostEqual(lineAngle(line1), mod(atan2(-1, 5)+2*pi, 2*pi));

line1 = createLine([2 3 -1 0]);
assertElementsAlmostEqual(lineAngle(line1), pi);



function testLineAngle2
% test lineAngle with two parameters : angle between 2 lines

% check for 2 orthogonal lines
line1 = createLine([1 3 1 0]);
line2 = createLine([-2 -1 0 1]);
assertElementsAlmostEqual(lineAngle(line1, line2), pi/2);
assertElementsAlmostEqual(lineAngle(line2, line1), 3*pi/2);


% check for 2 orthogonal lines, with very different parametrizations
line1 = createLine([1 3 1 1]);
line2 = createLine([-2 -1 -1000 1000]);
assertElementsAlmostEqual(lineAngle(line1, line2), pi/2);
assertElementsAlmostEqual(lineAngle(line2, line1), 3*pi/2);


