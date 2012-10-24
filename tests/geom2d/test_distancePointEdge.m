function test_suite = test_distancePointEdge(varargin) %#ok<STOUT>
%TESTDISTANCEPOINTEDGE  One-line description here, please.
%   output = test_distancePointEdge(input)
%
%   Example
%   testDistancePointEdge
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

function testBasic %#ok<*DEFNU>
point = [0 0];
edge = [1 2 3 4];
assertElementsAlmostEqual(distancePointEdge(point, edge), sqrt(5));

function testHorizontal
% an horizontal edge, with points all around
edge = [2 2 4 2];
assertElementsAlmostEqual(distancePointEdge([1 1], edge), sqrt(2));
assertElementsAlmostEqual(distancePointEdge([2 1], edge), 1);
assertElementsAlmostEqual(distancePointEdge([3 1], edge), 1);
assertElementsAlmostEqual(distancePointEdge([4 1], edge), 1);
assertElementsAlmostEqual(distancePointEdge([5 1], edge), sqrt(2));
assertElementsAlmostEqual(distancePointEdge([5 2], edge), 1);


function testDiagonal
% diagonal (slope 1.5)
edge = [1 1 5 7];
assertElementsAlmostEqual(distancePointEdge([0 0], edge), sqrt(2));
assertElementsAlmostEqual(distancePointEdge([2 0], edge), sqrt(2));
assertElementsAlmostEqual(distancePointEdge([4 8], edge), sqrt(2));
assertElementsAlmostEqual(distancePointEdge([1 0], edge), 1);
assertElementsAlmostEqual(distancePointEdge([0 1], edge), 1);
assertElementsAlmostEqual(distancePointEdge([6 7], edge), 1);
assertElementsAlmostEqual(distancePointEdge([5 8], edge), 1);
assertElementsAlmostEqual(distancePointEdge([6 2], edge), sqrt(13));
assertElementsAlmostEqual(distancePointEdge([0 6], edge), sqrt(13));

function testSingleMulti
point = [5 5];
edges = [0 0 10 0;10 0 10 10;10 10 20 10;10 0 0 10];
exp = [5 5 5*sqrt(2) 0];
assertElementsAlmostEqual(exp, distancePointEdge(point, edges));

function testSingleMultiWithInvalid
point = [5 5];
edges = [0 0 10 0;10 0 10 10;10 10 20 10;5 0 5 0];
exp = [5 5 5*sqrt(2) 5];
assertElementsAlmostEqual(exp, distancePointEdge(point, edges));


function testMultiSingle
edge  = [10 10 20 10];
points = [10 10;15 10;20 10;10 0;30 10];
exp = [0;0;0;10;10];
assertElementsAlmostEqual(exp, distancePointEdge(points, edge));

function testMultiSingleInvalidEdge
edge  = [15 10 15 10];
points = [10 10;15 10;20 10;10 10;30 10];
exp = [5;0;5;5;15];
assertElementsAlmostEqual(exp, distancePointEdge(points, edge));

function testMultiMulti
edges  = [10 30 20 30; 20 30 20 40;20 40 10 40;10 40 10 30];
points = [14 33;15 38];
exp = [3 6 7 4;8 5 2 5];
assertElementsAlmostEqual(exp, distancePointEdge(points, edges));

function testMultiMultiWithInvalid
edges  = [10 30 20 30; 20 30 20 40;20 40 10 40;10 40 10 30;10 30 10 30];
points = [14 33;15 38];
exp = [3 6 7 4 5;8 5 2 5 hypot(8, 5)];
assertElementsAlmostEqual(exp, distancePointEdge(points, edges));
