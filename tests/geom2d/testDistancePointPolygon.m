function test_suite = testDistancePointPolygon(varargin)
%TESTDISTANCEPOINTEDGE  One-line description here, please.
%   output = testDistancePointPolygon(input)
%
%   Example
%   testDistancePointPolygon
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

function testPointOnPolygon

poly = [0 0;10 0;10 10;0 10];

p1 = [0 0];
d = distancePointPolygon(p1, poly);
assertAlmostEqual(0, d);

p1 = [10 0];
d = distancePointPolygon(p1, poly);
assertAlmostEqual(0, d);

p1 = [5 10];
d = distancePointPolygon(p1, poly);
assertAlmostEqual(0, d);

p1 = [10 5];
d = distancePointPolygon(p1, poly);
assertAlmostEqual(0, d);

p1 = [0 5];
d = distancePointPolygon(p1, poly);
assertAlmostEqual(0, d);

function testPointNotOnPolygon

poly = [0 0;10 0;10 10;0 10];

p1 = [0 -10];
d = distancePointPolygon(p1, poly);
assertAlmostEqual(10, d);

p1 = [20 0];
d = distancePointPolygon(p1, poly);
assertAlmostEqual(10, d);

p1 = [5 5];
d = distancePointPolygon(p1, poly);
assertAlmostEqual(5, d);

p1 = [1 5];
d = distancePointPolygon(p1, poly);
assertAlmostEqual(1, d);

p1 = [-1 5];
d = distancePointPolygon(p1, poly);
assertAlmostEqual(1, d);
