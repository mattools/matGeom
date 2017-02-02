function test_suite = test_drawLine 
% Tests the function 'drawLine'
%   output = test_drawLine(input)
%
%   Example
%   testClipLine
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

test_suite = functiontests(localfunctions);

function testHoriz(testCase) %#ok<*DEFNU>
% test clipping of horizontal lines

box = [0 100 0 100];

hf = figure; clf;
axis(box);

% inside, to the right
line = [30 40 10 0];
edge = [0 40 100 40];

hl = drawLine(line);
testCase.assertEqual(edge([1 3]), get(hl, 'xdata'), 'AbsTol', .01);
testCase.assertEqual(edge([2 4]), get(hl, 'ydata'), 'AbsTol', .01);

% inside, to the left
line = [30 40 -10 0];
edge = [100 40 0 40];
hl = drawLine(line);
testCase.assertEqual(edge([1 3]), get(hl, 'xdata'), 'AbsTol', .01);
testCase.assertEqual(edge([2 4]), get(hl, 'ydata'), 'AbsTol', .01);

% outside
line = [30 140 10 0];
hl = drawLine(line);
testCase.assertEqual(-1, hl);

close(hf);


function testVert(testCase)
% test clipping of vertical lines

box = [0 100 0 100];

hf = figure; clf;
axis(box);

% inside, upward
line = [30 40 0 10];
edge = [30 0 30 100];
hl = drawLine(line);
testCase.assertEqual(edge([1 3]), get(hl, 'xdata'), 'AbsTol', .01);
testCase.assertEqual(edge([2 4]), get(hl, 'ydata'), 'AbsTol', .01);

% inside, downward
line = [30 40 0 -10];
edge = [30 100 30 0];
hl = drawLine(line);
testCase.assertEqual(edge([1 3]), get(hl, 'xdata'), 'AbsTol', .01);
testCase.assertEqual(edge([2 4]), get(hl, 'ydata'), 'AbsTol', .01);

% outside
line = [140 30 0 10];
hl = drawLine(line);
testCase.assertEqual(-1, hl);

close(hf);


function testDiagUp(testCase)
% test clipping of upward diagonal lines

box = [0 100 0 100];

hf = figure; clf;
axis(box); hold on;

% inside, top right corner
line = [80 30 10 10];
edge = [50 0 100 50];
hl = drawLine(line);
testCase.assertEqual(edge([1 3]), get(hl, 'xdata'), 'AbsTol', .01);
testCase.assertEqual(edge([2 4]), get(hl, 'ydata'), 'AbsTol', .01);

% inside, down right corner
line = [20 70 10 10];
edge = [0 50 50 100];
hl = drawLine(line);
testCase.assertEqual(edge([1 3]), get(hl, 'xdata'), 'AbsTol', .01);
testCase.assertEqual(edge([2 4]), get(hl, 'ydata'), 'AbsTol', .01);

% outside
line = [140 -30 10 10];
hl = drawLine(line);
testCase.assertEqual(-1, hl);

line = [-40 130 10 10];
hl = drawLine(line);
testCase.assertEqual(-1, hl);

close(hf);

function testMultiLines(testCase)

box = [0 100 0 100];

hf = figure; clf;
axis(box);

% inside, top right corner
line = [...
    80 30 10 10; ...
    20 70 10 10; ...
    140 -30 10 10; ...
    -40 130 10 10];
edge = [...
    50 0 100 50; ...
    0 50 50 100];
hl = drawLine(line);
testCase.assertEqual(4, length(hl));
testCase.assertEqual(edge(1, [1 3]), get(hl(1), 'xdata'), 'AbsTol', .01);
testCase.assertEqual(edge(1, [2 4]), get(hl(1), 'ydata'), 'AbsTol', .01);
testCase.assertEqual(edge(2, [1 3]), get(hl(2), 'xdata'), 'AbsTol', .01);
testCase.assertEqual(edge(2, [2 4]), get(hl(2), 'ydata'), 'AbsTol', .01);
testCase.assertEqual(-1, hl(3));
testCase.assertEqual(-1, hl(4));

close(hf);
