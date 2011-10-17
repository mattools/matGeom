function test_suite = test_drawLine(varargin) %#ok<STOUT>
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

initTestSuite;

function testHoriz %#ok<*DEFNU>
% test clipping of horizontal lines

box = [0 100 0 100];

hf = figure; clf;
axis(box);

% inside, to the right
line = [30 40 10 0];
edge = [0 40 100 40];

hl = drawLine(line);
assertElementsAlmostEqual(edge([1 3]), get(hl, 'xdata'));
assertElementsAlmostEqual(edge([2 4]), get(hl, 'ydata'));

% inside, to the left
line = [30 40 -10 0];
edge = [100 40 0 40];
hl = drawLine(line);
assertElementsAlmostEqual(edge([1 3]), get(hl, 'xdata'));
assertElementsAlmostEqual(edge([2 4]), get(hl, 'ydata'));

% outside
line = [30 140 10 0];
hl = drawLine(line);
assertEqual(-1, hl);

close(hf);


function testVert
% test clipping of vertical lines

box = [0 100 0 100];

hf = figure; clf;
axis(box);

% inside, upward
line = [30 40 0 10];
edge = [30 0 30 100];
hl = drawLine(line);
assertElementsAlmostEqual(edge([1 3]), get(hl, 'xdata'));
assertElementsAlmostEqual(edge([2 4]), get(hl, 'ydata'));

% inside, downward
line = [30 40 0 -10];
edge = [30 100 30 0];
hl = drawLine(line);
assertElementsAlmostEqual(edge([1 3]), get(hl, 'xdata'));
assertElementsAlmostEqual(edge([2 4]), get(hl, 'ydata'));

% outside
line = [140 30 0 10];
hl = drawLine(line);
assertEqual(-1, hl);

close(hf);


function testDiagUp
% test clipping of upward diagonal lines

box = [0 100 0 100];

hf = figure; clf;
axis(box); hold on;

% inside, top right corner
line = [80 30 10 10];
edge = [50 0 100 50];
hl = drawLine(line);
assertElementsAlmostEqual(edge([1 3]), get(hl, 'xdata'));
assertElementsAlmostEqual(edge([2 4]), get(hl, 'ydata'));

% inside, down right corner
line = [20 70 10 10];
edge = [0 50 50 100];
hl = drawLine(line);
assertElementsAlmostEqual(edge([1 3]), get(hl, 'xdata'));
assertElementsAlmostEqual(edge([2 4]), get(hl, 'ydata'));

% outside
line = [140 -30 10 10];
hl = drawLine(line);
assertEqual(-1, hl);

line = [-40 130 10 10];
hl = drawLine(line);
assertEqual(-1, hl);

close(hf);

function testMultiLines

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
assertEqual(4, length(hl));
assertElementsAlmostEqual(edge(1, [1 3]), get(hl(1), 'xdata'));
assertElementsAlmostEqual(edge(1, [2 4]), get(hl(1), 'ydata'));
assertElementsAlmostEqual(edge(2, [1 3]), get(hl(2), 'xdata'));
assertElementsAlmostEqual(edge(2, [2 4]), get(hl(2), 'ydata'));
assertEqual(-1, hl(3));
assertEqual(-1, hl(4));

close(hf);
