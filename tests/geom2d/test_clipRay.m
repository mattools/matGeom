function test_suite = test_clipRay
% Tests the function 'clipRay'
%   output = testClipRay(input)
%
%   Example
%   testClipRay
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

function testRightSide(testCase) %#ok<*DEFNU>
% test edges totally inside window, possibly touching edges

% a basic bounding box
box = [0 100 0 100];

% inside
origin      = [30 40];
direction   = [10 0];
ray         = [origin direction];
expected    = [30 40 100 40];
testCase.assertEqual(expected, clipRay(ray, box), 'AbsTol', .01);

% outside
origin      = [30 140];
direction   = [10 0];
ray         = [origin direction];
testCase.assertTrue(sum(isnan(clipRay(ray, box)))==4);

% line inside, but ray outside
origin      = [130 40];
direction   = [10 0];
ray         = [origin direction];
testCase.assertTrue(sum(isnan(clipRay(ray, box)))==4);

function testLeftSide(testCase)
% test edges totally inside window, possibly touching edges

% a basic bounding box
box = [0 100 0 100];

% inside
origin      = [30 40];
direction   = [-10 0];
ray         = [origin direction];
expected    = [30 40 0 40];
testCase.assertEqual(expected, clipRay(ray, box), 'AbsTol', .01);

% outside
origin      = [30 140];
direction   = [-10 0];
ray         = [origin direction];
testCase.assertTrue(sum(isnan(clipRay(ray, box)))==4);

% line inside, but ray outside
origin      = [-30 40];
direction   = [-10 0];
ray         = [origin direction];
testCase.assertTrue(sum(isnan(clipRay(ray, box)))==4);


function testUpSide(testCase)
% test edges totally inside window, possibly touching edges

box = [0 100 0 100];

% inside
origin      = [30 40];
direction   = [0 10];
ray         = [origin direction];
expected    = [30 40 30 100];
testCase.assertEqual(expected, clipRay(ray, box), 'AbsTol', .01);

% outside
origin      = [130 40];
direction   = [0 10];
ray         = [origin direction];
testCase.assertTrue(sum(isnan(clipRay(ray, box)))==4);

% line inside, but ray outside
origin      = [30 140];
direction   = [0 10];
ray         = [origin direction];
testCase.assertTrue(sum(isnan(clipRay(ray, box)))==4);


function testDownSide(testCase)
% test edges totally inside window, possibly touching edges

box = [0 100 0 100];

% inside
origin      = [30 40];
direction   = [0 -10];
ray         = [origin direction];
expected    = [30 40 30 0];
testCase.assertEqual(expected, clipRay(ray, box), 'AbsTol', .01);

% outside
origin      = [130 40];
direction   = [0 -10];
ray         = [origin direction];
testCase.assertTrue(sum(isnan(clipRay(ray, box)))==4);

% line inside, but ray outside
origin      = [30 -40];
direction   = [0 -10];
ray         = [origin direction];
testCase.assertTrue(sum(isnan(clipRay(ray, box)))==4);


function testArray(testCase)
% test with an array of rays and a box

box = [0 100 0 100];

origins     = [30 40;30 40;30 140;130 40];
directions  = [10 0;0 10;10 0;0 10];
rays        = [origins directions];
expected    = [30 40 100 40;30 40 30 100;NaN NaN NaN NaN;NaN NaN NaN NaN];
clipped     = clipRay(rays, box);
testCase.assertEqual(expected, clipped, 'AbsTol', .01);
