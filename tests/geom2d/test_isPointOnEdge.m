function test_suite = test_isPointOnEdge
%TESTISPOINTONEDGE  One-line description here, please.
%
%   output = testIsPointOnEdge(input)
%
%   Example
%   testIsPointOnEdge
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-10-04,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testHoriz(testCase) %#ok<*DEFNU>

p1 = [10 20];
p2 = [80 20];
edge = [p1 p2];

p0 = [10 20];
testCase.assertTrue(isPointOnEdge(p0, edge));

p0 = [80 20];
testCase.assertTrue(isPointOnEdge(p0, edge));

p0 = [50 20];
testCase.assertTrue(isPointOnEdge(p0, edge));

p0 = [9.99 20];
testCase.assertFalse(isPointOnEdge(p0, edge));

p0 = [80.01 20];
testCase.assertFalse(isPointOnEdge(p0, edge));

p0 = [50 21];
testCase.assertFalse(isPointOnEdge(p0, edge));

p0 = [79 19];
testCase.assertFalse(isPointOnEdge(p0, edge));


function testVertical(testCase) %#ok<*DEFNU>

p1 = [20 10];
p2 = [20 80];
edge = [p1 p2];

p0 = [20 10];
testCase.assertTrue(isPointOnEdge(p0, edge));

p0 = [20 80];
testCase.assertTrue(isPointOnEdge(p0, edge));

p0 = [20 50];
testCase.assertTrue(isPointOnEdge(p0, edge));

p0 = [20 9.99];
testCase.assertFalse(isPointOnEdge(p0, edge));

p0 = [20 80.01];
testCase.assertFalse(isPointOnEdge(p0, edge));

p0 = [21 50];
testCase.assertFalse(isPointOnEdge(p0, edge));

p0 = [19 79];
testCase.assertFalse(isPointOnEdge(p0, edge));

function testDiagonal(testCase)

p1 = [10 20];
p2 = [60 70];
edge = [p1 p2];

testCase.assertTrue(isPointOnEdge(p1, edge));
testCase.assertTrue(isPointOnEdge(p2, edge));

p0 = [11 21];
testCase.assertTrue(isPointOnEdge(p0, edge));

p0 = [59 69];
testCase.assertTrue(isPointOnEdge(p0, edge));

p0 = [9.99 19.99];
testCase.assertFalse(isPointOnEdge(p0, edge));

p0 = [60.01 70.01];
testCase.assertFalse(isPointOnEdge(p0, edge));

p0 = [30 50.01];
testCase.assertFalse(isPointOnEdge(p0, edge));


function testScalarArray(testCase)

edge = [10 20 80 20; 20 10 20 80; 20 10 60 70];
p0 = [20 20];
testCase.assertEqual([true ; true ; false], isPointOnEdge(p0, edge));

function testLargeEdge(testCase)

k = 1e15;

p1 = [10 20]*k;
p2 = [60 70]*k;
edge = [p1 p2];

testCase.assertTrue(isPointOnEdge(p1, edge));
testCase.assertTrue(isPointOnEdge(p2, edge));

p0 = [11 21]*k;
testCase.assertTrue(isPointOnEdge(p0, edge));

p0 = [59 69]*k;
testCase.assertTrue(isPointOnEdge(p0, edge));

p0 = [9.99 19.99]*k;
testCase.assertFalse(isPointOnEdge(p0, edge));

p0 = [60.01 70.01]*k;
testCase.assertFalse(isPointOnEdge(p0, edge));

p0 = [30 50.01]*k;
testCase.assertFalse(isPointOnEdge(p0, edge));


function testSmallEdge(testCase)

k = 1e-10;

p1 = [10 20]*k;
p2 = [60 70]*k;
edge = [p1 p2];

testCase.assertTrue(isPointOnEdge(p1, edge));
testCase.assertTrue(isPointOnEdge(p2, edge));

p0 = [11 21]*k;
testCase.assertTrue(isPointOnEdge(p0, edge));

p0 = [59 69]*k;
testCase.assertTrue(isPointOnEdge(p0, edge));

p0 = [9.99 19.99]*k;
testCase.assertFalse(isPointOnEdge(p0, edge));

p0 = [60.01 70.01]*k;
testCase.assertFalse(isPointOnEdge(p0, edge));

p0 = [30 50.01]*k;
testCase.assertFalse(isPointOnEdge(p0, edge));


function testPointArray(testCase)

p1 = [10 20];
p2 = [80 20];
edge = [p1 p2];

p0 = [10 20; 80 20; 50 20;50 21];
exp = [true;true;true;false];
testCase.assertEqual(exp, isPointOnEdge(p0, edge));


function testEdgeArray(testCase)

p1 = [10 20];
p2 = [80 20];
edge = [p1 p2];

p0 = [40 20];
exp = [true;true;true;true];
testCase.assertEqual(exp, isPointOnEdge(p0, [edge;edge;edge;edge]));


function testTwoArrays(testCase)

edge1 = [10 20 80 20];
edge2 = [30 10 30 80];
edges = [edge1; edge2];

p0 = [40 20;30 90];

exp = [true;false];
testCase.assertEqual(exp, isPointOnEdge(p0, edges));

