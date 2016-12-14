function test_suite = test_centroid
%TESTCLIPLINE  One-line description here, please.
%   output = testCentroid(input)
%
%   Example
%   testCentroid
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function testSquareCentroid(testCase) %#ok<*DEFNU>
% Centroid of 4 points

points = [0 0;10 0;10 10;0 10];
centro = centroid(points);
testCase.assertEqual([5 5], centro, 'AbsTol', .01);

function testSquareCentroidSeparateCoords(testCase)
% Centroid of 4 points

points = [0 0;10 0;10 10;0 10];
centro = centroid(points(:,1), points(:,2));
testCase.assertEqual([5 5], centro, 'AbsTol', .01);

function testSquareWeightedCentroid(testCase)
% Centroid of 4 points

points = [0 0;30 0;30 30;0 30];
centro = centroid(points, [1;1;1;3]);
testCase.assertEqual([10 20], centro, 'AbsTol', .01);


function testSquareWeightedCentroidSeparateCoords(testCase)
% Centroid of 4 points

points = [0 0;30 0;30 30;0 30];
centro = centroid(points(:,1), points(:,2), [1;1;1;3]);
testCase.assertEqual([10 20], centro, 'AbsTol', .01);

