function test_suite = test_angle3Points(varargin) %#ok<STOUT>
% One-line description here, please.
%   output = testAngle3Points(input)
%
%   Example
%   testAngle3Points
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

function testSimple %#ok<*DEFNU>
% all points inside window, possibly touching edges

p1 = [10 0];
p2 = [0 0];
p3 = [0 10];
angle = angle3Points(p1, p2, p3);
assertAlmostEqual(pi/2, angle);


function testBundledInput
% all points inside window, possibly touching edges

p1 = [10 0];
p2 = [0 0];
p3 = [0 10];
angle = angle3Points([p1; p2; p3]);
assertAlmostEqual(pi/2, angle);

function testArray
% all points inside window, possibly touching edges

p1 = [10 0; 20 0];
p2 = [0 0;0 0];
p3 = [0 10; 0 20];
angle = angle3Points(p1, p2, p3);

assertEqual(2, size(angle, 1));
assertElementsAlmostEqual([pi/2;pi/2], angle);

