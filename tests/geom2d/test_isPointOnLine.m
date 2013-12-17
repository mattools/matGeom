function test_suite = test_isPointOnLine(varargin) %#ok<STOUT>
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

initTestSuite;

function testHoriz %#ok<*DEFNU>

p1 = [10 20];
p2 = [80 20];
line = createLine(p1, p2);

p0 = [10 20];
assertTrue(isPointOnLine(p0, line));

p0 = [80 20];
assertTrue(isPointOnLine(p0, line));

p0 = [50 20];
assertTrue(isPointOnLine(p0, line));

p0 = [9.99 20];
assertTrue(isPointOnLine(p0, line));

p0 = [80.01 20];
assertTrue(isPointOnLine(p0, line));

p0 = [50 21];
assertFalse(isPointOnLine(p0, line));

p0 = [79 19];
assertFalse(isPointOnLine(p0, line));


function testVertical %#ok<*DEFNU>

p1 = [20 10];
p2 = [20 80];
line = createLine(p1, p2);

p0 = [20 10];
assertTrue(isPointOnLine(p0, line));

p0 = [20 80];
assertTrue(isPointOnLine(p0, line));

p0 = [20 50];
assertTrue(isPointOnLine(p0, line));

p0 = [20 9.99];
assertTrue(isPointOnLine(p0, line));

p0 = [20 80.01];
assertTrue(isPointOnLine(p0, line));

p0 = [21 50];
assertFalse(isPointOnLine(p0, line));

p0 = [19 79];
assertFalse(isPointOnLine(p0, line));

function testDiagonal

% slope (+50,+50)
p1 = [10 20];
p2 = [60 70];
line = createLine(p1, p2);

assertTrue(isPointOnLine(p1, line));
assertTrue(isPointOnLine(p2, line));

p0 = [11 21];
assertTrue(isPointOnLine(p0, line));

p0 = [59 69];
assertTrue(isPointOnLine(p0, line));

p0 = [9.99 19.99];
assertTrue(isPointOnLine(p0, line));

p0 = [60.01 70.01];
assertTrue(isPointOnLine(p0, line));

p0 = [30 50.01];
assertFalse(isPointOnLine(p0, line));


function testScalarArline

line = [10 20 60 0; 20 10 0 60; 20 10 40 60];
p0 = [20 20];
assertEqual([true true false], isPointOnLine(p0, line));


function testPointArline

p1 = [10 20];
p2 = [80 20];
line = createLine(p1, p2);

p0 = [10 20; 80 20; 50 20;50 21];
exp = [true;true;true;false];
assertEqual(exp, isPointOnLine(p0, line));


function testlineArline

p1 = [10 20];
p2 = [80 20];
line = createLine(p1, p2);

p0 = [40 20];
exp = [true true true true];
assertEqual(exp, isPointOnLine(p0, [line;line;line;line]));


