function test_suite = testDistancePointPolyline(varargin)
%TESTDISTANCEPOINTEDGE  One-line description here, please.
%   output = testDistancePointPolyline(input)
%
%   Example
%   testDistancePointPolyline
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

function testPointOnPolyline

poly = [0 0;10 0;10 10;0 10];

p1 = [0 0];
d = distancePointPolyline(p1, poly);
assertAlmostEqual(0, d);

p1 = [10 0];
d = distancePointPolyline(p1, poly);
assertAlmostEqual(0, d);

p1 = [5 10];
d = distancePointPolyline(p1, poly);
assertAlmostEqual(0, d);

p1 = [10 5];
d = distancePointPolyline(p1, poly);
assertAlmostEqual(0, d);

function testPointNotOnPolyline

poly = [0 0;10 0;10 10;0 10];

p1 = [0 -10];
d = distancePointPolyline(p1, poly);
assertAlmostEqual(10, d);

p1 = [20 0];
d = distancePointPolyline(p1, poly);
assertAlmostEqual(10, d);

p1 = [0 5];
d = distancePointPolyline(p1, poly);
assertAlmostEqual(5, d);

p1 = [5 5];
d = distancePointPolyline(p1, poly);
assertAlmostEqual(5, d);
