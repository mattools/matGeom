function test_suite = test_intersectPolylines
%TESTROWTOPOLYGON  One-line description here, please.
%
%   output = testRowToPolygon(input)
%
%   Example
%   testRowToPolygon
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-10-29,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testSelfCrosses(testCase) %#ok<*DEFNU>
% basic test with two intersection points

poly = [10 30;50 30;50 50;40 50;40 10;20 10;20 50];

inters = intersectPolylines(poly);

inter1 = [20 30];
testCase.assertTrue(ismember(inter1, inters, 'rows'));
inter2 = [40 30];
testCase.assertTrue(ismember(inter2, inters, 'rows'));


function testTwoCrosses(testCase) %#ok<*DEFNU>
% basic test with two intersection points

poly1 = [60 20;20 20;20 60];
poly2 = [50 10;50 50;10 50];

inters = intersectPolylines(poly1, poly2);

inter1 = [20 50];
testCase.assertTrue(ismember(inter1, inters, 'rows'));
inter2 = [50 20];
testCase.assertTrue(ismember(inter2, inters, 'rows'));


function test_simple_polylines(testCase) %#ok<*DEFNU>
% Compute intersection points between 2 simple polylines
poly1 = [20 10 ; 20 50 ; 60 50 ; 60 10];
poly2 = [10 40 ; 30 40 ; 30 60 ; 50 60 ; 50 40 ; 70 40];
points = intersectPolylines(poly1, poly2);
testCase.assertEqual(4, size(points, 1));

exp = [20 40 ; 30 50 ; 50 50 ; 60 40];
testCase.assertEqual(exp, points);
