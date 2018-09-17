function test_suite = test_clipEdge
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

test_suite = functiontests(localfunctions);

function testInside(testCase)  %#ok<*DEFNU>
% test edges totally inside window, possibly touching edges

box = [0 100 0 100];
testCase.assertEqual(clipEdge([20 30 80 60], box), [20 30 80 60], 'AbsTol', .01);
testCase.assertEqual(clipEdge([0  30 80 60], box), [0  30 80 60], 'AbsTol', .01);
testCase.assertEqual(clipEdge([0  30 100 60], box), [0  30 100 60], 'AbsTol', .01);
testCase.assertEqual(clipEdge([30 0 80 100], box), [30 0 80 100], 'AbsTol', .01);
testCase.assertEqual(clipEdge([0 0 100 100], box), [0 0 100 100], 'AbsTol', .01);
testCase.assertEqual(clipEdge([0 100 100 0], box), [0 100 100 0], 'AbsTol', .01);

function testClip(testCase)
% test edges totally inside window, possibly touching edges

box = [0 100 0 100];
testCase.assertEqual(clipEdge([20 60 120 60], box), [20 60 100 60], 'AbsTol', .01);
testCase.assertEqual(clipEdge([-20 60 80 60], box), [0  60 80 60], 'AbsTol', .01);
testCase.assertEqual(clipEdge([20 60 20 160], box), [20 60 20 100], 'AbsTol', .01);
testCase.assertEqual(clipEdge([20 -30 20 60], box), [20 0 20 60], 'AbsTol', .01);


function testOutside(testCase)
% test edges totally outside window

box = [0 100 0 100];
testCase.assertEqual(clipEdge([120 30 180 60], box), [0 0 0 0], 'AbsTol', .01);
testCase.assertEqual(clipEdge([-20 30 -80 60], box), [0 0 0 0], 'AbsTol', .01);
testCase.assertEqual(clipEdge([30 120 60 180], box), [0 0 0 0], 'AbsTol', .01);
testCase.assertEqual(clipEdge([30 -20 60 -80], box), [0 0 0 0], 'AbsTol', .01);
testCase.assertEqual(clipEdge([-120 110 190 150], box), [0 0 0 0], 'AbsTol', .01);

function testClipLast(testCase)
% test edges clipped at last extremity, with orthogonal edges

box = [0 100 0 100];
testCase.assertEqual([50 50 100 50], clipEdge([50 50 150 50], box), 'AbsTol', .01);
testCase.assertEqual([50 50 0 50], clipEdge([50 50 -50 50], box), 'AbsTol', .01);
testCase.assertEqual([50 50 50 100], clipEdge([50 50 50 150], box), 'AbsTol', .01);
testCase.assertEqual([50 50 50 0], clipEdge([50 50 50 -50], box), 'AbsTol', .01);

function testClipLastDiag(testCase)
% test edges clipped at last extremity, with diagonal edges

box = [0 100 0 100];
testCase.assertEqual([80 50 100 70], clipEdge([80 50 130 100], box), 'AbsTol', .01);
testCase.assertEqual([80 50 100 30], clipEdge([80 50 130 0], box), 'AbsTol', .01);
testCase.assertEqual([20 50 0 70], clipEdge([20 50 -30 100], box), 'AbsTol', .01);
testCase.assertEqual([20 50 0 30], clipEdge([20 50 -30 0], box), 'AbsTol', .01);
testCase.assertEqual([50 80 70 100], clipEdge([50 80 100 130], box), 'AbsTol', .01);
testCase.assertEqual([50 80 30 100], clipEdge([50 80 0 130], box), 'AbsTol', .01);
testCase.assertEqual([50 20 70 0], clipEdge([50 20 100 -30], box), 'AbsTol', .01);
testCase.assertEqual([50 20 30 0], clipEdge([50 20 0 -30], box), 'AbsTol', .01);

function testClipFirst(testCase)
% test edges clipped at first extremity, with orthogonal edges

box = [0 100 0 100];
testCase.assertEqual([100 50 50 50], clipEdge([150 50 50 50], box), 'AbsTol', .01);
testCase.assertEqual([0 50 50 50], clipEdge([-50 50 50 50], box), 'AbsTol', .01);
testCase.assertEqual([50 100 50 50], clipEdge([50 150 50 50], box), 'AbsTol', .01);
testCase.assertEqual([50 0 50 50], clipEdge([50 -50 50 50], box), 'AbsTol', .01);

function testClipFirstDiag(testCase)
% test edges clipped at last extremity, with diagonal edges

box = [0 100 0 100];
testCase.assertEqual([100 70 80 50], clipEdge([130 100 80 50], box), 'AbsTol', .01);
testCase.assertEqual([100 30 80 50], clipEdge([130 0 80 50], box), 'AbsTol', .01);
testCase.assertEqual([0 70 20 50], clipEdge([-30 100 20 50], box), 'AbsTol', .01);
testCase.assertEqual([0 30 20 50], clipEdge([-30 0 20 50], box), 'AbsTol', .01);
testCase.assertEqual([70 100 50 80], clipEdge([100 130 50 80], box), 'AbsTol', .01);
testCase.assertEqual([30 100 50 80], clipEdge([0 130 50 80], box), 'AbsTol', .01);
testCase.assertEqual([70 0 50 20], clipEdge([100 -30 50 20], box), 'AbsTol', .01);
testCase.assertEqual([30 0 50 20], clipEdge([0 -30 50 20], box), 'AbsTol', .01);

function testClipBoth(testCase)
% test edges clipped at both extremities

box = [0 100 0 100];
testCase.assertEqual([0 20 80 100], clipEdge([-10 10 90 110], box), 'AbsTol', 0.01);


function testClipArray(testCase)
% test an array of edges, with one inside

% one edge totally inside, one edge crossing boundary
edge1 = [40 40 60 40];
edge2 = [60 60 100 60];
edges = [edge1 ; edge2];

box = [20 80 20 80];

% compute clipping results
clip1 = clipEdge(edge1, box);
clip2 = clipEdge(edge2, box);
clipped = clipEdge(edges, box);

% compare results
testCase.assertEqual(clip1, clipped(1,:), 'AbsTol', .01);
testCase.assertEqual(clip2, clipped(2,:), 'AbsTol', .01);

function testDiagonalEdge(testCase)

edge=[ 102.5260 -1.8235 91.5926 12.6135]; 
box=[0 100 0 100]; 

clip = clipEdge(edge, box);

testCase.assertEqual(clip(1), 100, 'AbsTol', .01);
