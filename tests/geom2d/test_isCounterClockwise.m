function test_suite = test_isCounterClockwise 
%test orientation of 3 points
%   output = testEq(input)
%
%   Example
%   testEq
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-03,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.
% Licensed under the terms of the LGPL, see the file "license.txt"

test_suite = functiontests(localfunctions); 

function testCcwTurnLeft(testCase) %#ok<*DEFNU>
% turn 90° left => return +1

p0 = [2, 3]; % center point
pu = [2, 4]; % up point
pd = [2, 2]; % down point
pl = [1, 3]; % left point
pr = [3, 3]; % right point

testCase.assertEqual(isCounterClockwise(pl, p0, pu), +1);
testCase.assertEqual(isCounterClockwise(pd, p0, pl), +1);
testCase.assertEqual(isCounterClockwise(pr, p0, pd), +1);
testCase.assertEqual(isCounterClockwise(pu, p0, pr), +1);

function testCcwTurnRight(testCase)
% turn 90° right => return -1

p0 = [2, 3]; % center point
pu = [2, 4]; % up point
pd = [2, 2]; % down point
pl = [1, 3]; % left point
pr = [3, 3]; % right point

testCase.assertEqual(isCounterClockwise(pl, p0, pd), -1);
testCase.assertEqual(isCounterClockwise(pd, p0, pr), -1);
testCase.assertEqual(isCounterClockwise(pr, p0, pu), -1);
testCase.assertEqual(isCounterClockwise(pu, p0, pl), -1);

function testCcwTurnLeftArray(testCase)
% turn 90° left => return +1

p0 = [2, 3]; % center point
pu = [2, 4]; % up point
pd = [2, 2]; % down point
pl = [1, 3]; % left point
pr = [3, 3]; % right point

pts1 = [pl;pd;pr;pu;pl;pd;pr;pu];
pts2 = [p0;p0;p0;p0;p0;p0;p0;p0];
pts3 = [pu;pl;pd;pr;pd;pr;pu;pl];
expected = [1;1;1;1;-1;-1;-1;-1];
result = isCounterClockwise(pts1, pts2, pts3);
testCase.assertEqual(expected, result, 'AbsTol', .01);

function testCcwCol1(testCase)
% aligned with p0-p1-p2 => return +1

p0 = [2, 3]; % center point
pu = [2, 4]; % up point
pd = [2, 2]; % down point
pl = [1, 3]; % left point
pr = [3, 3]; % right point

testCase.assertEqual(isCounterClockwise(pl, p0, pr), +1);
testCase.assertEqual(isCounterClockwise(pu, p0, pd), +1);
testCase.assertEqual(isCounterClockwise(pr, p0, pl), +1);
testCase.assertEqual(isCounterClockwise(pd, p0, pu), +1);

function testCcwCol0(testCase)
% aligned ]ith p0-p2-p1 => return 0
p0 = [2, 3]; % center point
pu = [2, 4]; % up point
pd = [2, 2]; % down point
pl = [1, 3]; % left point
pr = [3, 3]; % right point

testCase.assertEqual(isCounterClockwise(pl, pr, p0), 0);
testCase.assertEqual(isCounterClockwise(pu, pd, p0), 0);
testCase.assertEqual(isCounterClockwise(pr, pl, p0), 0);
testCase.assertEqual(isCounterClockwise(pd, pu, p0), 0);

function testCcwColM1(testCase)
% aligned with p1-p0-p2 => return -1
p0 = [2, 3]; % center point
pu = [2, 4]; % up point
pd = [2, 2]; % down point
pl = [1, 3]; % left point
pr = [3, 3]; % right point

testCase.assertEqual(isCounterClockwise(p0, pl, pr), -1);
testCase.assertEqual(isCounterClockwise(p0, pu, pd), -1);
testCase.assertEqual(isCounterClockwise(p0, pr, pl), -1);
testCase.assertEqual(isCounterClockwise(p0, pd, pu), -1);

