function test_suite = test_clipLine(varargin) %#ok<STOUT>
% Tests the function 'clipLine'
%   output = testClipLine(input)
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

% inside, to the right
line = [30 40 10 0];
edge = [0 40 100 40];
assertElementsAlmostEqual(edge, clipLine(line, box));

% inside, to the left
line = [30 40 -10 0];
edge = [100 40 0 40];
assertElementsAlmostEqual(edge, clipLine(line, box));

% outside
line = [30 140 10 0];
assertTrue(sum(isnan(clipLine(line, box)))==4);

function testVert
% test clipping of vertical lines

box = [0 100 0 100];

% inside, upward
line = [30 40 0 10];
edge = [30 0 30 100];
assertElementsAlmostEqual(edge, clipLine(line, box));

% inside, downward
line = [30 40 0 -10];
edge = [30 100 30 0];
assertElementsAlmostEqual(edge, clipLine(line, box));

% outside
line = [140 30 0 10];
assertTrue(sum(isnan(clipLine(line, box)))==4);

function testDiagUp
% test clipping of upward diagonal lines

box = [0 100 0 100];

% inside, top right corner
line = [80 30 10 10];
edge = [50 0 100 50];
assertElementsAlmostEqual(edge, clipLine(line, box));

% inside, down right corner
line = [20 70 10 10];
edge = [0 50 50 100];
assertElementsAlmostEqual(edge, clipLine(line, box));

% outside
line = [140 -30 10 10];
assertTrue(sum(isnan(clipLine(line, box)))==4);

line = [-40 130 10 10];
assertTrue(sum(isnan(clipLine(line, box)))==4);


function testMultiLines

box = [0 100 0 100];

% inside, top right corner
line = [...
    80 30 10 10; ...
    20 70 10 10; ...
    140 -30 10 10; ...
    -40 130 10 10];
edge = [...
    50 0 100 50; ...
    0 50 50 100; ...
    NaN NaN NaN NaN; ...
    NaN NaN NaN NaN; ...
    ];

clipped = clipLine(line, box);
assertEqual(4, size(clipped, 1));
assertElementsAlmostEqual(edge(1:2, :), clipped(1:2, :));
assertTrue(sum(isnan(clipped(3,:)))==4);
assertTrue(sum(isnan(clipped(4,:)))==4);

function testBigBox
% test clipping of horizontal lines

box = [-1 1 -1 1]*1e10;

% inside, to the right
line = [3 0 1 2];
D = 1e10;
edge = [3-D/2 -D 3+D/2 D];
clipped = clipLine(line, box);
assertElementsAlmostEqual(edge, clipped);

function testBigLine
% test clipping of horizontal lines

box = [-1 1 -1 1]*100;

% inside, to the right
line = [3 0 1*1e10 2*1e10];
D = 100;
edge = [3-D/2 -D 3+D/2 D];
clipped = clipLine(line, box);
assertElementsAlmostEqual(edge, clipped);
