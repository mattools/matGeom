function test_suite = test_distancePointLine(varargin) %#ok<STOUT>
%TESTDISTANCEPOINTEDGE  One-line description here, please.
%   output = test_distancePointLine(input)
%
%   Example
%   testDistancePointLine
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-10-24,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

initTestSuite;

function testBasic %#ok<*DEFNU>
point = [0 0];
line = [1 2 1 0];
assertElementsAlmostEqual(2, distancePointLine(point, line));

function testHorizontal
% an horizontal line, with points all around
line = [2 2 2 0];
assertElementsAlmostEqual(distancePointLine([1 1], line), 1);
assertElementsAlmostEqual(distancePointLine([2 1], line), 1);
assertElementsAlmostEqual(distancePointLine([3 1], line), 1);
assertElementsAlmostEqual(distancePointLine([4 1], line), 1);
assertElementsAlmostEqual(distancePointLine([5 1], line), 1);
assertElementsAlmostEqual(distancePointLine([5 2], line), 0);
assertElementsAlmostEqual(distancePointLine([5 3], line), 1);


function testDiagonal
% diagonal (slope 2)
line = [1 1 3 6];
assertElementsAlmostEqual(0, distancePointLine([3 5], line));
assertElementsAlmostEqual(sqrt(5), distancePointLine([3 0], line));

function testSingleMulti
point = [5 5];
lines = [0 0 3 0;10 0 0 3;10 10 -3 0;10 0 3 3];
exp = [5 5 5 5*sqrt(2)];
assertElementsAlmostEqual(exp, distancePointLine(point, lines));

function testSingleMultiWithInvalid
point = [5 5];
lines = [0 0 3 0;10 0 0 3;10 10 -3 0;10 0 3 3;10 0 0 0];
exp = [5 5 5 5*sqrt(2) 5*sqrt(2)];
assertElementsAlmostEqual(exp, distancePointLine(point, lines));


function testMultiSingle
line  = [10 10 5 0];
points = [10 10;15 10;20 10;10 0;30 10];
exp = [0; 0; 0; 10; 0];
assertElementsAlmostEqual(exp, distancePointLine(points, line));

function testMultiSingleInvalidLine
line  = [15 10 0 0];
points = [10 10; 15 10; 20 10; 10 10; 30 10];
exp = [5; 0; 5; 5; 15];
assertElementsAlmostEqual(exp, distancePointLine(points, line));

function testMultiMulti
lines  = [10 30 10 0; 20 30 0 10;20 40 -10 0;10 40 0 -10];
points = [14 33;15 38];
exp = [3 6 7 4;8 5 2 5];
assertElementsAlmostEqual(exp, distancePointLine(points, lines));

function testMultiMultiWithInvalid
lines  = [10 30 10 0; 20 30 0 10;20 40 -10 0;10 40 0 -10;10 30 0 0];
points = [14 33;15 38];
exp = [3 6 7 4 5;8 5 2 5 hypot(8, 5)];
assertElementsAlmostEqual(exp, distancePointLine(points, lines));
