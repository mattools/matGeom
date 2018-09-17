function test_suite = test_isPointOnLine
%TESTisPointOnLine  One-line description here, please.
%
%   output = testisPointOnLine(input)
%
%   Example
%   testisPointOnLine
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-12-17,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testHoriz(testCase) %#ok<*DEFNU>

p1 = [10 20];
p2 = [80 20];
line = createLine(p1, p2);

p0 = [10 20];
testCase.assertTrue(isPointOnLine(p0, line));

p0 = [80 20];
testCase.assertTrue(isPointOnLine(p0, line));

p0 = [50 20];
testCase.assertTrue(isPointOnLine(p0, line));

p0 = [9.99 20];
testCase.assertTrue(isPointOnLine(p0, line));

p0 = [80.01 20];
testCase.assertTrue(isPointOnLine(p0, line));

p0 = [50 21];
testCase.assertFalse(isPointOnLine(p0, line));

p0 = [79 19];
testCase.assertFalse(isPointOnLine(p0, line));


function testVertical(testCase) %#ok<*DEFNU>

p1 = [20 10];
p2 = [20 80];
line = createLine(p1, p2);

p0 = [20 10];
testCase.assertTrue(isPointOnLine(p0, line));

p0 = [20 80];
testCase.assertTrue(isPointOnLine(p0, line));

p0 = [20 50];
testCase.assertTrue(isPointOnLine(p0, line));

p0 = [20 9.99];
testCase.assertTrue(isPointOnLine(p0, line));

p0 = [20 80.01];
testCase.assertTrue(isPointOnLine(p0, line));

p0 = [21 50];
testCase.assertFalse(isPointOnLine(p0, line));

p0 = [19 79];
testCase.assertFalse(isPointOnLine(p0, line));

function testDiagonal(testCase)

% slope (+50,+50)
p1 = [10 20];
p2 = [60 70];
line = createLine(p1, p2);

testCase.assertTrue(isPointOnLine(p1, line));
testCase.assertTrue(isPointOnLine(p2, line));

p0 = [11 21];
testCase.assertTrue(isPointOnLine(p0, line));

p0 = [59 69];
testCase.assertTrue(isPointOnLine(p0, line));

p0 = [9.99 19.99];
testCase.assertTrue(isPointOnLine(p0, line));

p0 = [60.01 70.01];
testCase.assertTrue(isPointOnLine(p0, line));

p0 = [30 50.01];
testCase.assertFalse(isPointOnLine(p0, line));


function testScalarArline(testCase)

line = [10 20 60 0; 20 10 0 60; 20 10 40 60];
p0 = [20 20];
testCase.assertEqual([true true false], isPointOnLine(p0, line));


function testPointArrayLine(testCase)

p1 = [10 20];
p2 = [80 20];
line = createLine(p1, p2);

p0 = [10 20; 80 20; 50 20;50 21];
exp = [true;true;true;false];
testCase.assertEqual(exp, isPointOnLine(p0, line));


function testPointLineArray(testCase)

p1 = [10 20];
p2 = [80 20];
line = createLine(p1, p2);

p0 = [40 20];
exp = [true true true true];
testCase.assertEqual(exp, isPointOnLine(p0, [line;line;line;line]));


