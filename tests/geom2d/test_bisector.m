function test_suite = test_bisector(varargin) %#ok<STOUT>
% One-line description here, please.
%   output = testBisector(input)
%
%   Example
%   testBisector
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

function testTwoLines %#ok<*DEFNU>

p0 = [0 0];
p1 = [10 0];
p2 = [0 10];
line1 = createLine(p0, p1);
line2 = createLine(p0, p2);

ray = bisector(line1, line2);
assertElementsAlmostEqual([0 0], ray(1,1:2));
assertAlmostEqual(pi/4, lineAngle(ray));

function testThreePoints

p0 = [0 0];
p1 = [10 0];
p2 = [0 10];

ray = bisector(p1, p0, p2);
assertElementsAlmostEqual([0 0], ray(1,1:2));
assertAlmostEqual(pi/4, lineAngle(ray));

function testThreeBundldedPoints

p0 = [0 0];
p1 = [10 0];
p2 = [0 10];

ray = bisector([p1; p0; p2]);
assertElementsAlmostEqual([0 0], ray(1,1:2));
assertAlmostEqual(pi/4, lineAngle(ray));
