function test_suite = test_intersectRayPolygon
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
% e-mail: david.legland@inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 


function testSquare(testCase) %#ok<*DEFNU>
poly = [0 0;10 0;10 10;0 10];

rayH1 = [5 5 1 0];
testCase.assertEqual(1, size(intersectRayPolygon(rayH1, poly), 1));

rayH2 = [5 15 1 0];
testCase.assertEqual(0, size(intersectRayPolygon(rayH2, poly), 1));

rayV1 = [5 5 0 1];
testCase.assertEqual(1, size(intersectRayPolygon(rayV1, poly), 1));

rayV2 = [15 5 0 1];
testCase.assertEqual(0, size(intersectRayPolygon(rayV2, poly), 1));


function testDiamond(testCase)
poly = [10 0;20 10;10 20;0 10];

% definition from 14/02/2022 do not intersect lower vertices
rayH0 = [0 0 3 0];
intersects = intersectRayPolygon(rayH0, poly);
testCase.assertTrue(isempty(intersects));

% definition from 14/02/2022 do not intersect lower vertices
rayH1 = [10 10 3 0];
intersects = intersectRayPolygon(rayH1, poly);
target = [20 10];
testCase.assertEqual(intersects, target, 'AbsTol', 0.01);
testCase.assertEqual(1, size(intersects, 1));

% touches top corner twice
rayH2 = [0 20 3 0];
intersects = intersectRayPolygon(rayH2, poly);
testCase.assertEqual(2, size(intersects, 1));

% touches left corner twice
rayV0 = [0 0 0 3];
intersects = intersectRayPolygon(rayV0, poly);
testCase.assertEqual(2, size(intersects, 1));

% intersects top corner
rayV1 = [10 10 0 3];
intersects = intersectRayPolygon(rayV1, poly);
target = [10 20];
testCase.assertEqual(intersects, target, 'AbsTol', 0.01);

% touches right corner
rayV2 = [20 0 0 3];
intersects = intersectRayPolygon(rayV2, poly);
testCase.assertTrue(isempty(intersects));



function testUniquePoints(testCase)
% Check that function returns unique results, even for vertex points

poly = [0 0;10 0;10 10;0 10];

ray = [5 5 1 1];
intersects = intersectRayPolygon(ray, poly);
testCase.assertEqual(1, size(intersects, 1), 'Wrong number of intersections');

ray = [-5 15 1 -1];
intersects = intersectRayPolygon(ray, poly);
testCase.assertEqual(2, size(intersects, 1), 'Wrong number of intersections');
