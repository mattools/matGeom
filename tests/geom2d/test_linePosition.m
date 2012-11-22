function test_suite = test_linePosition(varargin) %#ok<STOUT>
%TESTLINEPOSITION  One-line description here, please.
%
%   output = testLinePosition(input)
%
%   Example
%   testLinePosition
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-15,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


initTestSuite;

function testBasic %#ok<*DEFNU>

point = [20 60];
line = createLine([10 30], [30 90]);

exp = .5;
pos = linePosition(point, line);

assertEqual(exp, pos);


function testPointArray

point = [20 60;10 30;25 75];
line = createLine([10 30], [30 90]);

exp = [.5; 0; .75];
pos = linePosition(point, line);

assertEqual(exp, pos);


function testLineArray

point = [20 60];
line1 = createLine([10 30], [30 90]);
line2 = createLine([0 0], [20 60]);
line3 = createLine([20 60], [40 120]);
lines = [line1;line2;line3];

exp = [.5  1  0];
pos = linePosition(point, lines);

assertEqual(exp, pos);

function testArrayArray

lines = [10 20 1 0;10 20 0 1;10 20 1 1];
points = [30 20;10 40; 30 40];

exp = [20 0 10; 0 20 10; 20 20 20];
pos = linePosition(points, lines);

assertElementsAlmostEqual(exp, pos);

function testArrayArrayDiag

lines = [10 20 1 0;10 20 0 1;10 20 1 1];
points = [30 20;10 40; 30 40];

exp = [20; 20; 20];
pos = linePosition(points, lines, 'diag');

assertElementsAlmostEqual(exp, pos);
