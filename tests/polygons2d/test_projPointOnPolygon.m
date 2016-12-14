function test_suite = test_projPointOnPolygon
%TEST_projPointOnPolygon  One-line description here, please.
%   output = test_projPointOnPolygon(input)
%
%   Example
%   testPolygonPoint
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-16,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testSquare(testCase) %#ok<*DEFNU>

p1 = [10 10];
p2 = [20 10];
p3 = [20 20];
p4 = [10 20];
poly = [p1;p2;p3;p4];

testCase.assertEqual(  0, projPointOnPolygon([ 0  0], poly), 'AbsTol', .01);
testCase.assertEqual( .5, projPointOnPolygon([15  0], poly), 'AbsTol', .01);
testCase.assertEqual(  1, projPointOnPolygon([30  0], poly), 'AbsTol', .01);
testCase.assertEqual(1.5, projPointOnPolygon([30 15], poly), 'AbsTol', .01);
testCase.assertEqual(  2, projPointOnPolygon([30 30], poly), 'AbsTol', .01);
testCase.assertEqual(2.5, projPointOnPolygon([15 30], poly), 'AbsTol', .01);
testCase.assertEqual(  3, projPointOnPolygon([ 0 30], poly), 'AbsTol', .01);

testCase.assertEqual(3.8, projPointOnPolygon([ 0 12], poly), 'AbsTol', .01);
testCase.assertEqual(3.2, projPointOnPolygon([ 0 18], poly), 'AbsTol', .01);

function testPointArray(testCase)

p1 = [10 10];
p2 = [20 10];
p3 = [20 20];
p4 = [10 20];
poly = [p1;p2;p3;p4];

pts = [0 0;15 0;30 0;30 15;30 30;15 30;0 30;0 12;0 18];
exp = [0;.5;1;1.5;2;2.5;3;3.8;3.2];

testCase.assertEqual(exp, projPointOnPolygon(pts, poly), 'AbsTol', .01);
