function test_suite = test_isPointOnEdge(varargin) %#ok<STOUT>
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

initTestSuite;

function testHoriz %#ok<*DEFNU>

p1 = [10 20];
p2 = [80 20];
edge = [p1 p2];

p0 = [10 20];
assertTrue(isPointOnEdge(p0, edge));

p0 = [80 20];
assertTrue(isPointOnEdge(p0, edge));

p0 = [50 20];
assertTrue(isPointOnEdge(p0, edge));

p0 = [9.99 20];
assertFalse(isPointOnEdge(p0, edge));

p0 = [80.01 20];
assertFalse(isPointOnEdge(p0, edge));

p0 = [50 21];
assertFalse(isPointOnEdge(p0, edge));

p0 = [79 19];
assertFalse(isPointOnEdge(p0, edge));


function testVertical %#ok<*DEFNU>

p1 = [20 10];
p2 = [20 80];
edge = [p1 p2];

p0 = [20 10];
assertTrue(isPointOnEdge(p0, edge));

p0 = [20 80];
assertTrue(isPointOnEdge(p0, edge));

p0 = [20 50];
assertTrue(isPointOnEdge(p0, edge));

p0 = [20 9.99];
assertFalse(isPointOnEdge(p0, edge));

p0 = [20 80.01];
assertFalse(isPointOnEdge(p0, edge));

p0 = [21 50];
assertFalse(isPointOnEdge(p0, edge));

p0 = [19 79];
assertFalse(isPointOnEdge(p0, edge));

function testDiagonal

p1 = [10 20];
p2 = [60 70];
edge = [p1 p2];

assertTrue(isPointOnEdge(p1, edge));
assertTrue(isPointOnEdge(p2, edge));

p0 = [11 21];
assertTrue(isPointOnEdge(p0, edge));

p0 = [59 69];
assertTrue(isPointOnEdge(p0, edge));

p0 = [9.99 19.99];
assertFalse(isPointOnEdge(p0, edge));

p0 = [60.01 70.01];
assertFalse(isPointOnEdge(p0, edge));

p0 = [30 50.01];
assertFalse(isPointOnEdge(p0, edge));


function testScalarArray

edge = [10 20 80 20; 20 10 20 80; 20 10 60 70];
p0 = [20 20];
assertEqual([true ; true ; false], isPointOnEdge(p0, edge));

function testLargeEdge

k = 1e15;

p1 = [10 20]*k;
p2 = [60 70]*k;
edge = [p1 p2];

assertTrue(isPointOnEdge(p1, edge));
assertTrue(isPointOnEdge(p2, edge));

p0 = [11 21]*k;
assertTrue(isPointOnEdge(p0, edge));

p0 = [59 69]*k;
assertTrue(isPointOnEdge(p0, edge));

p0 = [9.99 19.99]*k;
assertFalse(isPointOnEdge(p0, edge));

p0 = [60.01 70.01]*k;
assertFalse(isPointOnEdge(p0, edge));

p0 = [30 50.01]*k;
assertFalse(isPointOnEdge(p0, edge));


function testSmallEdge

k = 1e-10;

p1 = [10 20]*k;
p2 = [60 70]*k;
edge = [p1 p2];

assertTrue(isPointOnEdge(p1, edge));
assertTrue(isPointOnEdge(p2, edge));

p0 = [11 21]*k;
assertTrue(isPointOnEdge(p0, edge));

p0 = [59 69]*k;
assertTrue(isPointOnEdge(p0, edge));

p0 = [9.99 19.99]*k;
assertFalse(isPointOnEdge(p0, edge));

p0 = [60.01 70.01]*k;
assertFalse(isPointOnEdge(p0, edge));

p0 = [30 50.01]*k;
assertFalse(isPointOnEdge(p0, edge));


function testPointArray

p1 = [10 20];
p2 = [80 20];
edge = [p1 p2];

p0 = [10 20; 80 20; 50 20;50 21];
exp = [true;true;true;false];
assertEqual(exp, isPointOnEdge(p0, edge));


function testEdgeArray

p1 = [10 20];
p2 = [80 20];
edge = [p1 p2];

p0 = [40 20];
exp = [true;true;true;true];
assertEqual(exp, isPointOnEdge(p0, [edge;edge;edge;edge]));


function testTwoArrays

edge1 = [10 20 80 20];
edge2 = [30 10 30 80];
edges = [edge1; edge2];

p0 = [40 20;30 90];

exp = [true;false];
assertEqual(exp, isPointOnEdge(p0, edges));

