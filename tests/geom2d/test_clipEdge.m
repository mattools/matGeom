function test_suite = test_clipEdge(varargin) %#ok<STOUT>
%TESTCLIPEDGE  One-line description here, please.
%   output = testClipEdge(input)
%
%   Example
%   testClipEdge
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

function testInside  %#ok<*DEFNU>
% test edges totally inside window, possibly touching edges

box = [0 100 0 100];
assertElementsAlmostEqual(clipEdge([20 30 80 60], box), [20 30 80 60]);
assertElementsAlmostEqual(clipEdge([0  30 80 60], box), [0  30 80 60]);
assertElementsAlmostEqual(clipEdge([0  30 100 60], box), [0  30 100 60]);
assertElementsAlmostEqual(clipEdge([30 0 80 100], box), [30 0 80 100]);
assertElementsAlmostEqual(clipEdge([0 0 100 100], box), [0 0 100 100]);
assertElementsAlmostEqual(clipEdge([0 100 100 0], box), [0 100 100 0]);

function testClip
% test edges totally inside window, possibly touching edges

box = [0 100 0 100];
assertElementsAlmostEqual(clipEdge([20 60 120 60], box), [20 60 100 60]);
assertElementsAlmostEqual(clipEdge([-20 60 80 60], box), [0  60 80 60]);
assertElementsAlmostEqual(clipEdge([20 60 20 160], box), [20 60 20 100]);
assertElementsAlmostEqual(clipEdge([20 -30 20 60], box), [20 0 20 60]);


function testOutside
% test edges totally outside window

box = [0 100 0 100];
assertElementsAlmostEqual(clipEdge([120 30 180 60], box), [0 0 0 0]);
assertElementsAlmostEqual(clipEdge([-20 30 -80 60], box), [0 0 0 0]);
assertElementsAlmostEqual(clipEdge([30 120 60 180], box), [0 0 0 0]);
assertElementsAlmostEqual(clipEdge([30 -20 60 -80], box), [0 0 0 0]);
assertElementsAlmostEqual(clipEdge([-120 110 190 150], box), [0 0 0 0]);

function testClipLast
% test edges clipped at last extremity, with orthogonal edges

box = [0 100 0 100];
assertAlmostEqual([50 50 100 50], clipEdge([50 50 150 50], box));
assertAlmostEqual([50 50 0 50], clipEdge([50 50 -50 50], box));
assertAlmostEqual([50 50 50 100], clipEdge([50 50 50 150], box));
assertAlmostEqual([50 50 50 0], clipEdge([50 50 50 -50], box));

function testClipLastDiag
% test edges clipped at last extremity, with diagonal edges

box = [0 100 0 100];
assertAlmostEqual([80 50 100 70], clipEdge([80 50 130 100], box));
assertAlmostEqual([80 50 100 30], clipEdge([80 50 130 0], box));
assertAlmostEqual([20 50 0 70], clipEdge([20 50 -30 100], box));
assertAlmostEqual([20 50 0 30], clipEdge([20 50 -30 0], box));
assertAlmostEqual([50 80 70 100], clipEdge([50 80 100 130], box));
assertAlmostEqual([50 80 30 100], clipEdge([50 80 0 130], box));
assertAlmostEqual([50 20 70 0], clipEdge([50 20 100 -30], box));
assertAlmostEqual([50 20 30 0], clipEdge([50 20 0 -30], box));

function testClipFirst
% test edges clipped at first extremity, with orthogonal edges

box = [0 100 0 100];
assertAlmostEqual([100 50 50 50], clipEdge([150 50 50 50], box));
assertAlmostEqual([0 50 50 50], clipEdge([-50 50 50 50], box));
assertAlmostEqual([50 100 50 50], clipEdge([50 150 50 50], box));
assertAlmostEqual([50 0 50 50], clipEdge([50 -50 50 50], box));

function testClipFirstDiag
% test edges clipped at last extremity, with diagonal edges

box = [0 100 0 100];
assertAlmostEqual([100 70 80 50], clipEdge([130 100 80 50], box));
assertAlmostEqual([100 30 80 50], clipEdge([130 0 80 50], box));
assertAlmostEqual([0 70 20 50], clipEdge([-30 100 20 50], box));
assertAlmostEqual([0 30 20 50], clipEdge([-30 0 20 50], box));
assertAlmostEqual([70 100 50 80], clipEdge([100 130 50 80], box));
assertAlmostEqual([30 100 50 80], clipEdge([0 130 50 80], box));
assertAlmostEqual([70 0 50 20], clipEdge([100 -30 50 20], box));
assertAlmostEqual([30 0 50 20], clipEdge([0 -30 50 20], box));

function testClipBoth
% test edges clipped at both extremities

box = [0 100 0 100];
assertAlmostEqual([0 20 80 100], clipEdge([-10 10 90 110], box));

