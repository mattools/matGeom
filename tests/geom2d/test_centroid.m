function test_suite = test_centroid(varargin) %#ok<STOUT>
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

initTestSuite;

function testSquareCentroid %#ok<*DEFNU>
% Centroid of 4 points

points = [0 0;10 0;10 10;0 10];
centro = centroid(points);
assertElementsAlmostEqual([5 5], centro);

function testSquareCentroidSeparateCoords
% Centroid of 4 points

points = [0 0;10 0;10 10;0 10];
centro = centroid(points(:,1), points(:,2));
assertElementsAlmostEqual([5 5], centro);

function testSquareWeightedCentroid
% Centroid of 4 points

points = [0 0;30 0;30 30;0 30];
centro = centroid(points, [1;1;1;3]);
assertElementsAlmostEqual([10 20], centro);


function testSquareWeightedCentroidSeparateCoords
% Centroid of 4 points

points = [0 0;30 0;30 30;0 30];
centro = centroid(points(:,1), points(:,2), [1;1;1;3]);
assertElementsAlmostEqual([10 20], centro);

