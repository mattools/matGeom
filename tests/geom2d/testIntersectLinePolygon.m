function test_suite = testIntersectLines(varargin)
%TESTINTERSECTLINES  One-line description here, please.
%   output = testIntersectLines(input)
%
%   Example
%   testIntersectLines
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


function testSquare
poly = [0 0;10 0;10 10;0 10];

lineH1 = [5 5 1 0];
assertEqual(2, size(intersectLinePolygon(lineH1, poly), 1));

lineH2 = [5 15 1 0];
assertEqual(0, size(intersectLinePolygon(lineH2, poly), 1));

lineV1 = [5 5 0 1];
assertEqual(2, size(intersectLinePolygon(lineV1, poly), 1));

lineV2 = [15 5 0 1];
assertEqual(0, size(intersectLinePolygon(lineV2, poly), 1));

function testDiamond
poly = [10 0;20 10;10 20;0 10];

lineH0 = [0 0 3 0];
target = [10 0];
intersects = intersectLinePolygon(lineH0, poly);
assertTrue(ismember(target, intersects, 'rows'));

lineH1 = [10 10 3 0];
intersects = intersectLinePolygon(lineH1, poly);
target = [20 10];
assertTrue(ismember(target, intersects, 'rows'));
target = [0 10];
assertTrue(ismember(target, intersects, 'rows'));

lineH2 = [0 20 3 0];
intersects = intersectLinePolygon(lineH2, poly);
target = [10 20];
assertTrue(ismember(target, intersects, 'rows'));

lineV0 = [0 0 0 3];
target = [0 10];
intersects = intersectLinePolygon(lineV0, poly);
assertTrue(ismember(target, intersects, 'rows'));

lineV1 = [10 10 0 3];
intersects = intersectLinePolygon(lineV1, poly);
target = [10 20];
assertTrue(ismember(target, intersects, 'rows'));
target = [10 0];
assertTrue(ismember(target, intersects, 'rows'));

lineV2 = [20 0 0 3];
intersects = intersectLinePolygon(lineV2, poly);
target = [20 10];
assertTrue(ismember(target, intersects, 'rows'));
