function test_suite = test_angle2Points(varargin) %#ok<STOUT>
%TESTCLIPLINE  One-line description here, please.
%   output = testAngle2Points(input)
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

function testHoriz %#ok<*DEFNU>
% all points inside window, possibly touching edges

p1 = [0 0];
p2 = [10 0];
angle = angle2Points(p1, p2);
assertAlmostEqual(0, angle);

angle = angle2Points(p2, p1);
assertAlmostEqual(pi, angle);

function testVert
% all points inside window, possibly touching edges

p1 = [0 0];
p2 = [0 10];
angle = angle2Points(p1, p2);
assertAlmostEqual(pi/2, angle);

angle = angle2Points(p2, p1);
assertAlmostEqual(3*pi/2, angle);


function testMultiMulti
% all points inside window, possibly touching edges

p1 = [0 0;0 0;0 0;0 0];
p2 = [10 0;10 10;0 10;-10 10];
angle = angle2Points(p1, p2);
assertEqual(size(p1, 1), size(angle, 1));

res = [0;pi/4;pi/2;3*pi/4];
assertElementsAlmostEqual(res, angle);

function testOneMulti
% all points inside window, possibly touching edges

p1 = [0 0];
p2 = [10 0;10 10;0 10;-10 10];
angle = angle2Points(p1, p2);
assertEqual(size(p2, 1), size(angle, 1));

res = [0;pi/4;pi/2;3*pi/4];
assertElementsAlmostEqual(res, angle);

