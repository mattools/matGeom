function test_suite = testIntersectLinePolygon(varargin) %#ok<STOUT>
%TESTINTERSECTLINEPOLYGON Test case for function intersectLinePolygon
%   output = testIntersectLinePolygon(input)
%
%   Example
%   testIntersectLinePolygon
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


function testSquare %#ok<*DEFNU>
% test with a square and orthogonal lines, inside and outside

poly = [0 0;10 0;10 10;0 10];

lineH1 = [5 5 1 0];
assertEqual(2, size(intersectLinePolygon(lineH1, poly), 1));

lineH2 = [5 15 1 0];
assertEqual(0, size(intersectLinePolygon(lineH2, poly), 1));

lineV1 = [5 5 0 1];
assertEqual(2, size(intersectLinePolygon(lineV1, poly), 1));

lineV2 = [15 5 0 1];
assertEqual(0, size(intersectLinePolygon(lineV2, poly), 1));


function testClosedSquare
% test when the polygon has same vertices at end and at bginning

poly = [0 0;10 0;10 10;0 10;0 0];

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

[intersects inds] = intersectLinePolygon(lineH0, poly);
assertEqual(size(intersects, 1), size(inds, 1));


lineH1 = [10 10 3 0];
intersects = intersectLinePolygon(lineH1, poly);
target = [20 10];
assertTrue(ismember(target, intersects, 'rows'));
target = [0 10];
assertTrue(ismember(target, intersects, 'rows'));

[intersects inds] = intersectLinePolygon(lineH1, poly);
assertEqual(size(intersects, 1), size(inds, 1));


lineH2 = [0 20 3 0];
intersects = intersectLinePolygon(lineH2, poly);
target = [10 20];
assertTrue(ismember(target, intersects, 'rows'));

[intersects inds] = intersectLinePolygon(lineH2, poly);
assertEqual(size(intersects, 1), size(inds, 1));


lineV0 = [0 0 0 3];
target = [0 10];
intersects = intersectLinePolygon(lineV0, poly);
assertTrue(ismember(target, intersects, 'rows'));

[intersects inds] = intersectLinePolygon(lineV0, poly);
assertEqual(size(intersects, 1), size(inds, 1));


lineV1 = [10 10 0 3];
intersects = intersectLinePolygon(lineV1, poly);
target = [10 20];
assertTrue(ismember(target, intersects, 'rows'));
target = [10 0];
assertTrue(ismember(target, intersects, 'rows'));

[intersects inds] = intersectLinePolygon(lineV1, poly);
assertEqual(size(intersects, 1), size(inds, 1));


lineV2 = [20 0 0 3];
intersects = intersectLinePolygon(lineV2, poly);
target = [20 10];
assertTrue(ismember(target, intersects, 'rows'));

[intersects inds] = intersectLinePolygon(lineV2, poly);
assertEqual(size(intersects, 1), size(inds, 1));


function testMShape
% a more complicated polygon, with 4 intersections

poly = [10 10;60 10;60 40;40 20;30 20;10 40];
line = [0 30 3 0];

[inters inds] = intersectLinePolygon(line, poly);
expInters = [10 30;20 30;50 30;60 30];
assertEqual(expInters, inters);
expInds = [6;5;3;2];
assertEqual(expInds, inds);


function testUniquePoints
% Check that function returns unique results, even for vertex points

poly = [0 0;10 0;10 10;0 10];
line = [5 5 1 1];
intersects = intersectLinePolygon(line, poly);
assertEqual(2, size(intersects, 1), 'Wrong number of intersections');

function testGetEdgesIndices

poly = [0 0;10 0;10 10;0 10];
line = [5 5 1 0];
[intersects inds] = intersectLinePolygon(line, poly); %#ok<ASGLU>

assertEqual(2, length(inds));
assertEqual([4;2], inds);

