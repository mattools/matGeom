function test_suite = test_intersectLines(varargin) %#ok<STOUT>
%TESTINTERSECTLINES  One-line description here, please.
%   output = testIntersectLines(input)
%
%   Example
%   testIntersectLines
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


function testOrthogonal %#ok<*DEFNU>
% basic test with two orthogonal lines
line1 = [3 1 0 1];
line2 = [1 4 1 0];
assertElementsAlmostEqual(intersectLines(line1, line2), [3 4]);

function testOrthogonalDiagonals
% orthognal diagonal lines
line1 = [0 0 3 2];
line2 = [5 -1 4 -6];
assertElementsAlmostEqual(intersectLines(line1, line2), [3 2]);

function testDiagonalHorizontal
% one diagonal and one horizontal line
line1 = [10 2 25 0];
line2 = [5 -1 4 -6];
assertElementsAlmostEqual(intersectLines(line1, line2), [3 2]);

function testBigDerivative
% check for dx and dy very big compared to other line
line1 = [3 1 0 1000];
line2 = [1 4 -14 0];
assertElementsAlmostEqual(intersectLines(line1, line2), [3 4]);

line1 = [2 0 20000 30000];
line2 = [1 6 1 -1];
assertElementsAlmostEqual(intersectLines(line1, line2), [4 3]);

function testSingleArray

line1 = [3 1 0 1];
line2 = repmat([1 4 1 0], 5, 1);
exp = repmat([3 4], 5, 1);

inters = intersectLines(line1, line2);
assertElementsAlmostEqual(exp, inters);


function testArraySingle

line1 = repmat([3 1 0 1], 5, 1);
line2 = [1 4 1 0];
exp = repmat([3 4], 5, 1);

inters = intersectLines(line1, line2);
assertElementsAlmostEqual(exp, inters);


function testArrayArray

line1 = repmat([3 1 0 1], 5, 1);
line2 = repmat([1 4 1 0], 5, 1);
exp = repmat([3 4], 5, 1);

inters = intersectLines(line1, line2);
assertElementsAlmostEqual(exp, inters);
