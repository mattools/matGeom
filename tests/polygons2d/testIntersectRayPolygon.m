function test_suite = testIntersectRayPolygon(varargin) %#ok<STOUT>
%TESTINTERSECTRAYPOLYGON  One-line description here, please.
%   output = testIntersectRayPolygon(input)
%
%   Example
%   testIntersectRayPolygon
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


function testSquare %#ok<*DEFNU>
poly = [0 0;10 0;10 10;0 10];

rayH1 = [5 5 1 0];
assertEqual(1, size(intersectRayPolygon(rayH1, poly), 1));

rayH2 = [5 15 1 0];
assertEqual(0, size(intersectRayPolygon(rayH2, poly), 1));

rayV1 = [5 5 0 1];
assertEqual(1, size(intersectRayPolygon(rayV1, poly), 1));

rayV2 = [15 5 0 1];
assertEqual(0, size(intersectRayPolygon(rayV2, poly), 1));


function testDiamond
poly = [10 0;20 10;10 20;0 10];

% touche lower corner
rayH0 = [0 0 3 0];
target = [10 0];
intersects = intersectRayPolygon(rayH0, poly);
assertTrue(ismember(target, intersects, 'rows'));

% touches right corner (only once)
rayH1 = [10 10 3 0];
intersects = intersectRayPolygon(rayH1, poly);
target = [20 10];
assertTrue(ismember(target, intersects, 'rows'));
assertEqual(1, size(intersects, 1));

% touches top corner
rayH2 = [0 20 3 0];
intersects = intersectRayPolygon(rayH2, poly);
target = [10 20];
assertEqual(1, size(intersects, 1));
assertTrue(ismember(target, intersects, 'rows'));

% touches left corner
rayV0 = [0 0 0 3];
target = [0 10];
intersects = intersectRayPolygon(rayV0, poly);
assertTrue(ismember(target, intersects, 'rows'));

% touches left corner
rayV1 = [10 10 0 3];
intersects = intersectRayPolygon(rayV1, poly);
target = [10 20];
assertTrue(ismember(target, intersects, 'rows'));

% touches right corner
rayV2 = [20 0 0 3];
intersects = intersectRayPolygon(rayV2, poly);
target = [20 10];
assertTrue(ismember(target, intersects, 'rows'));


function testUniquePoints
% Check that function returns unique results, even for vertex points

poly = [0 0;10 0;10 10;0 10];

ray = [5 5 1 1];
intersects = intersectRayPolygon(ray, poly);
assertEqual(1, size(intersects, 1), 'Wrong number of intersections');

ray = [-5 15 1 -1];
intersects = intersectRayPolygon(ray, poly);
assertEqual(2, size(intersects, 1), 'Wrong number of intersections');
