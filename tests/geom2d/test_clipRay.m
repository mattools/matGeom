function test_suite = test_clipRay(varargin) %#ok<STOUT>
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

initTestSuite;

function testRightSide %#ok<*DEFNU>
% test edges totally inside window, possibly touching edges

% a basic bounding box
box = [0 100 0 100];

% inside
origin      = [30 40];
direction   = [10 0];
ray         = [origin direction];
expected    = [30 40 100 40];
assertElementsAlmostEqual(expected, clipRay(ray, box));

% outside
origin      = [30 140];
direction   = [10 0];
ray         = [origin direction];
assertTrue(sum(isnan(clipRay(ray, box)))==4);

% line inside, but ray outside
origin      = [130 40];
direction   = [10 0];
ray         = [origin direction];
assertTrue(sum(isnan(clipRay(ray, box)))==4);

function testLeftSide
% test edges totally inside window, possibly touching edges

% a basic bounding box
box = [0 100 0 100];

% inside
origin      = [30 40];
direction   = [-10 0];
ray         = [origin direction];
expected    = [30 40 0 40];
assertElementsAlmostEqual(expected, clipRay(ray, box));

% outside
origin      = [30 140];
direction   = [-10 0];
ray         = [origin direction];
assertTrue(sum(isnan(clipRay(ray, box)))==4);

% line inside, but ray outside
origin      = [-30 40];
direction   = [-10 0];
ray         = [origin direction];
assertTrue(sum(isnan(clipRay(ray, box)))==4);


function testUpSide
% test edges totally inside window, possibly touching edges

box = [0 100 0 100];

% inside
origin      = [30 40];
direction   = [0 10];
ray         = [origin direction];
expected    = [30 40 30 100];
assertElementsAlmostEqual(expected, clipRay(ray, box));

% outside
origin      = [130 40];
direction   = [0 10];
ray         = [origin direction];
assertTrue(sum(isnan(clipRay(ray, box)))==4);

% line inside, but ray outside
origin      = [30 140];
direction   = [0 10];
ray         = [origin direction];
assertTrue(sum(isnan(clipRay(ray, box)))==4);


function testDownSide
% test edges totally inside window, possibly touching edges

box = [0 100 0 100];

% inside
origin      = [30 40];
direction   = [0 -10];
ray         = [origin direction];
expected    = [30 40 30 0];
assertElementsAlmostEqual(expected, clipRay(ray, box));

% outside
origin      = [130 40];
direction   = [0 -10];
ray         = [origin direction];
assertTrue(sum(isnan(clipRay(ray, box)))==4);

% line inside, but ray outside
origin      = [30 -40];
direction   = [0 -10];
ray         = [origin direction];
assertTrue(sum(isnan(clipRay(ray, box)))==4);


function testArray
% test with an array of rays and a box

box = [0 100 0 100];

origins     = [30 40;30 40;30 140;130 40];
directions  = [10 0;0 10;10 0;0 10];
rays        = [origins directions];
expected    = [30 40 100 40;30 40 30 100;NaN NaN NaN NaN;NaN NaN NaN NaN];
clipped     = clipRay(rays, box);
assertElementsAlmostEqual(expected, clipped);
