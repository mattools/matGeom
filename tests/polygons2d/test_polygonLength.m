function test_suite = test_polygonLength
%TESTPOLYGONLENGTH  One-line description here, please.
%
%   output = testPolygonLength(input)
%
%   Example
%   testPolygonLength
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-27,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function test_Square(testCase) %#ok<*DEFNU>
% Tests with a square of perimeter 40
p1 = [10 10];
p2 = [20 10];
p3 = [20 20];
p4 = [10 20];
square = [p1;p2;p3;p4];
exp = 40;

testCase.assertEqual(exp, polygonLength(square));

function test_SquareSplitArgs(testCase)
% Tests with a square of perimeter 40
p1 = [10 10];
p2 = [20 10];
p3 = [20 20];
p4 = [10 20];
square = [p1;p2;p3;p4];
exp = 40;

testCase.assertEqual(exp, polygonLength(square(:,1), square(:,2)));

function test_MultiPolygon(testCase)
% Test for a rectangle with two rectangular holes

poly1 = [10 10;60 10;60 50;10 50];  % outer ring
poly2 = [20 20;20 40;30 40;30 20];  % inner ring 1
poly3 = [40 20;40 40;50 40;50 20];  % inner ring 2
poly = {poly1, poly2, poly3};

res = polygonLength(poly);
testCase.assertEqual(1, length(res));

exp = 30 * 10;
testCase.assertEqual(exp, res);
